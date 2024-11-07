import 'package:floor/floor.dart';
import 'dao/party_dao.dart';
import 'entity/party_database_entity.dart';
import 'entity/pokemon_database_entity.dart';
import 'dao/pokemon_dao.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:path/path.dart';

part 'pokemon_database.g.dart';

@Database(version: 1, entities: [PokemonDatabaseEntity, PartyDatabaseEntity])
abstract class PokemonDatabase extends FloorDatabase {
  PokemonDao get pokemonDao;
  PartyDao get partyDao;
}