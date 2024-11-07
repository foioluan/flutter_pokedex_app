import 'package:floor/floor.dart';
import '../entity/pokemon_database_entity.dart';

@dao
abstract class PokemonDao {
  @Query('SELECT * FROM Pokemon')
  Future<List<PokemonDatabaseEntity>> selectAllPokemon();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAll(List<PokemonDatabaseEntity> entities);

  @Query('DELETE FROM Pokemon')
  Future<void> deleteAll();

  @Query('SELECT * FROM Pokemon WHERE id = :id')
  Future<PokemonDatabaseEntity?> findPokemonById(int id);

  @Query('SELECT * FROM Pokemon LIMIT :limit OFFSET :offset')
  Future<List<PokemonDatabaseEntity>> selectPaginated(int limit, int offset);
}