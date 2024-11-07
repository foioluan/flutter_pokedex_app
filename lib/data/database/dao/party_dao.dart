import 'package:floor/floor.dart';
import '../entity/party_database_entity.dart';

@dao
abstract class PartyDao {
  @insert
  Future<void> insertPokemon(PartyDatabaseEntity party);

  @Query('SELECT * FROM Party')
  Future<List<PartyDatabaseEntity>> findAllPokemon();

  @delete
  Future<void> deletePokemon(PartyDatabaseEntity party);

  @Query('DELETE FROM Party WHERE pokemonId = :pokemonId')
  Future<void> deletePokemonByPokemonId(int pokemonId);
}