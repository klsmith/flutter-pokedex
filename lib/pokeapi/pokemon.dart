import 'package:pokedex/pokeapi/sprites.dart';

class Pokemon {
  final int id;
  final String name;
  final Sprites sprites;

  Pokemon(this.id, this.name, this.sprites);

  factory Pokemon.fromJson(Map json) {
    return Pokemon(json['id'], json['name'], Sprites.fromJson(json['sprites']));
  }

  @override
  String toString() {
    return 'Pokemon( name=$name )';
  }
}
