import '../../domain/pokemon.dart';

abstract class PokemonRepository {
  Future<List<Pokemon>> getPokemonList({required int page, required int limit});
}