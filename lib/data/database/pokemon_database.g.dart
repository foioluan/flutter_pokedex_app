// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $PokemonDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $PokemonDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $PokemonDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<PokemonDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorPokemonDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $PokemonDatabaseBuilderContract databaseBuilder(String name) =>
      _$PokemonDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $PokemonDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$PokemonDatabaseBuilder(null);
}

class _$PokemonDatabaseBuilder implements $PokemonDatabaseBuilderContract {
  _$PokemonDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $PokemonDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $PokemonDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<PokemonDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$PokemonDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$PokemonDatabase extends PokemonDatabase {
  _$PokemonDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  PokemonDao? _pokemonDaoInstance;

  PartyDao? _partyDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Pokemon` (`id` INTEGER NOT NULL, `name` TEXT NOT NULL, `type` TEXT NOT NULL, `base` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Party` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `pokemonId` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  PokemonDao get pokemonDao {
    return _pokemonDaoInstance ??= _$PokemonDao(database, changeListener);
  }

  @override
  PartyDao get partyDao {
    return _partyDaoInstance ??= _$PartyDao(database, changeListener);
  }
}

class _$PokemonDao extends PokemonDao {
  _$PokemonDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _pokemonDatabaseEntityInsertionAdapter = InsertionAdapter(
            database,
            'Pokemon',
            (PokemonDatabaseEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'type': item.type,
                  'base': item.base
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PokemonDatabaseEntity>
      _pokemonDatabaseEntityInsertionAdapter;

  @override
  Future<List<PokemonDatabaseEntity>> selectAllPokemon() async {
    return _queryAdapter.queryList('SELECT * FROM Pokemon',
        mapper: (Map<String, Object?> row) => PokemonDatabaseEntity(
            id: row['id'] as int,
            name: row['name'] as String,
            type: row['type'] as String,
            base: row['base'] as String));
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Pokemon');
  }

  @override
  Future<PokemonDatabaseEntity?> findPokemonById(int id) async {
    return _queryAdapter.query('SELECT * FROM Pokemon WHERE id = ?1',
        mapper: (Map<String, Object?> row) => PokemonDatabaseEntity(
            id: row['id'] as int,
            name: row['name'] as String,
            type: row['type'] as String,
            base: row['base'] as String),
        arguments: [id]);
  }

  @override
  Future<List<PokemonDatabaseEntity>> selectPaginated(
    int limit,
    int offset,
  ) async {
    return _queryAdapter.queryList('SELECT * FROM Pokemon LIMIT ?1 OFFSET ?2',
        mapper: (Map<String, Object?> row) => PokemonDatabaseEntity(
            id: row['id'] as int,
            name: row['name'] as String,
            type: row['type'] as String,
            base: row['base'] as String),
        arguments: [limit, offset]);
  }

  @override
  Future<void> insertAll(List<PokemonDatabaseEntity> entities) async {
    await _pokemonDatabaseEntityInsertionAdapter.insertList(
        entities, OnConflictStrategy.replace);
  }
}

class _$PartyDao extends PartyDao {
  _$PartyDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _partyDatabaseEntityInsertionAdapter = InsertionAdapter(
            database,
            'Party',
            (PartyDatabaseEntity item) =>
                <String, Object?>{'id': item.id, 'pokemonId': item.pokemonId}),
        _partyDatabaseEntityDeletionAdapter = DeletionAdapter(
            database,
            'Party',
            ['id'],
            (PartyDatabaseEntity item) =>
                <String, Object?>{'id': item.id, 'pokemonId': item.pokemonId});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PartyDatabaseEntity>
      _partyDatabaseEntityInsertionAdapter;

  final DeletionAdapter<PartyDatabaseEntity>
      _partyDatabaseEntityDeletionAdapter;

  @override
  Future<List<PartyDatabaseEntity>> findAllPokemon() async {
    return _queryAdapter.queryList('SELECT * FROM Party',
        mapper: (Map<String, Object?> row) => PartyDatabaseEntity(
            id: row['id'] as int?, pokemonId: row['pokemonId'] as int));
  }

  @override
  Future<void> deletePokemonByPokemonId(int pokemonId) async {
    await _queryAdapter.queryNoReturn('DELETE FROM Party WHERE pokemonId = ?1',
        arguments: [pokemonId]);
  }

  @override
  Future<void> insertPokemon(PartyDatabaseEntity party) async {
    await _partyDatabaseEntityInsertionAdapter.insert(
        party, OnConflictStrategy.abort);
  }

  @override
  Future<void> deletePokemon(PartyDatabaseEntity party) async {
    await _partyDatabaseEntityDeletionAdapter.delete(party);
  }
}
