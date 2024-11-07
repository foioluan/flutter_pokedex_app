import '../../domain/pokemon.dart';
import './entity/pokemon_entity.dart';

class NetworkMapper {
  Pokemon toPokemon(PokemonEntity entity) {
    return Pokemon(
      id: entity.id,
      name: Map<String, String>.from(entity.name),
      type: entity.type,
      base: Map<String, int>.from(entity.base),
    );
  }

  List<Pokemon> toPokemonList(List<PokemonEntity> entities) {
    return entities.map((e) => toPokemon(e)).toList();
  }
}