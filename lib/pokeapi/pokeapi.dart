import 'dart:convert';

import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:pokedex/pokeapi/api_resource_list.dart';
import 'package:pokedex/pokeapi/pokemon.dart';
import 'package:pokedex/pokeapi/species.dart';

class PokeAPI {
  static const String baseUrl = 'https://pokeapi.co/api/v2/';

  static final PokeAPI _instance = PokeAPI._();

  factory PokeAPI() {
    return _instance;
  }

  PokeAPI._() : super();

  Future<Map<String, dynamic>> _callUrl(String url) async {
    final File file = await DefaultCacheManager().getSingleFile(url);
    return _toJsonMap(file);
  }

  Future<Map<String, dynamic>> _callEndpoint(String endpoint) {
    return _callUrl(baseUrl + endpoint);
  }

  Map<String, dynamic> _toJsonMap(File file) {
    final String jsonText = utf8.decode(file.readAsBytesSync());
    return jsonDecode(jsonText) as Map<String, dynamic>;
  }

  Future<ApiResourceList> getPokemonSpeciesList() async {
    final json = await _callEndpoint('pokemon-species');
    return ApiResourceList.fromJson(json);
  }

  Future<Pokemon> getPokemon(String name) async {
    final json = await _callEndpoint('pokemon/$name');
    return Pokemon.fromJson(json);
  }

  Future<Species> getPokemonSpecies(String name) async {
    final json = await _callEndpoint('pokemon-species/$name');
    return Species.fromJson(json);
  }

  Future<ApiResourceList> next(ApiResourceList current) async {
    final json = await _callUrl(current.next ?? '');
    return ApiResourceList.fromJson(json);
  }

  Future<ApiResourceList> previous(ApiResourceList current) async {
    final json = await _callUrl(current.previous ?? '');
    return ApiResourceList.fromJson(json);
  }
}
