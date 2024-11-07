import './entity/pokemon_database_entity.dart';
import '../../domain/pokemon.dart';

class DatabaseMapper {
  PokemonDatabaseEntity toPokemonDatabaseEntity(Pokemon pokemon) {
    return PokemonDatabaseEntity(
      id: pokemon.id,
      name: PokemonDatabaseEntity.nameToJson(
          pokemon.name),
      type: PokemonDatabaseEntity.typeToJson(
          pokemon.type),
      base: PokemonDatabaseEntity.baseToJson(
          pokemon.base),
    );
  }

  Pokemon toPokemon(PokemonDatabaseEntity entity) {
    return Pokemon(
      id: entity.id,
      name: entity.getNameMap(),
      type: entity.getTypeList(),
      base: entity.getBaseMap(),
    );
  }

  List<Pokemon> toPokemonList(List<PokemonDatabaseEntity> entities) {
    final List<Pokemon> pokemonList = [];
    for (var entity in entities) {
      pokemonList.add(toPokemon(entity));
    }
    return pokemonList;
  }
}