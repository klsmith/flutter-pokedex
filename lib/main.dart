import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/pokeapi/api_resource_list.dart';
import 'package:pokedex/pokeapi/pokeapi.dart';
import 'package:pokedex/pokeapi/pokemon.dart';
import 'package:pokedex/pokeapi/species.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokédex',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ApiResourceList speciesResourceList = ApiResourceList.empty();

  @override
  void initState() {
    super.initState();
    PokeAPI().getPokemonSpeciesList().then(_updateSpeciesResourceList);
  }

  void _previousPage() {
    if (speciesResourceList.previous != null) {
      PokeAPI().previous(speciesResourceList).then(_updateSpeciesResourceList);
    }
  }

  void _nextPage() {
    if (speciesResourceList.next != null) {
      PokeAPI().next(speciesResourceList).then(_updateSpeciesResourceList);
    }
  }

  void _updateSpeciesResourceList(ApiResourceList response) {
    setState(() {
      speciesResourceList = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
        title: Text('Pokédex - List'),
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 3,
          children:
              speciesResourceList.results
                  .map(
                    (species) => PokemonSpeciesThumbnail(
                      key: Key(species.name!),
                      species: species,
                    ),
                  )
                  .toList(),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: 10,
        children: [
          Builder(
            builder: (context) {
              if (speciesResourceList.previous == null) {
                return SizedBox.shrink();
              }
              return FloatingActionButton(
                backgroundColor: colors.secondary,
                foregroundColor: colors.onSecondary,
                onPressed: _previousPage,
                tooltip: 'Previous Page',
                child: const Icon(Icons.chevron_left),
              );
            },
          ),
          Builder(
            builder: (context) {
              if (speciesResourceList.next == null) {
                return SizedBox.shrink();
              }
              return FloatingActionButton(
                backgroundColor: colors.secondary,
                foregroundColor: colors.onSecondary,
                onPressed: _nextPage,
                tooltip: 'Next Page',
                child: const Icon(Icons.chevron_right),
              );
            },
          ),
        ],
      ),
    );
  }
}

class PokemonSpeciesThumbnail extends StatefulWidget {
  final ApiResource species;

  const PokemonSpeciesThumbnail({super.key, required this.species});

  @override
  State<PokemonSpeciesThumbnail> createState() =>
      _PokemonSpeciesThumbnailState();
}

class _PokemonSpeciesThumbnailState extends State<PokemonSpeciesThumbnail> {
  Pokemon? pokemon;
  Species? species;

  @override
  void initState() {
    super.initState();
    PokeAPI().getPokemon(widget.species.name!).then(_updatePokemon);
    PokeAPI().getPokemonSpecies(widget.species.name!).then(_updateSpecies);
  }

  _updatePokemon(Pokemon p) {
    setState(() {
      pokemon = p;
    });
  }

  _updateSpecies(Species s) {
    setState(() {
      species = s;
    });
  }

  @override
  Widget build(BuildContext context) {
    return pokemon?.sprites.frontDefault == null
        ? SizedBox.shrink()
        : MaterialButton(
          onPressed: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(species?.getEnglishName() ?? widget.species.name ?? '???'),
              CachedNetworkImage(
                imageUrl: pokemon!.sprites.frontDefault!,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              // ElevatedButton(onPressed: () {}, child: Text('VIEW')),
            ],
          ),
        );
  }
}
