import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../domain/pokemon.dart';
import '../network/client/api_client.dart';
import '../network/network_mapper.dart';
import '../repository/pokemon_repository.dart';
import '../database/dao/pokemon_dao.dart';
import '../database/database_mapper.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonDao pokemonDao;
  final DatabaseMapper databaseMapper;
  final ApiClient apiClient;
  final NetworkMapper networkMapper;

  PokemonRepositoryImpl(
      {required this.pokemonDao,
      required this.databaseMapper,
      required this.apiClient,
      required this.networkMapper});

  Future<List<Pokemon>> getPokemonList({required int page, required int limit}) async {
    final int offset = (page - 1) * limit;

    final pokemonEntitys = await pokemonDao.selectPaginated(limit, offset);

    if (pokemonEntitys.isNotEmpty) {
      return databaseMapper.toPokemonList(pokemonEntitys);
    }
    final internetEntity = await apiClient.fetchPokemons();
    final pokemons = networkMapper.toPokemonList(internetEntity);
    await pokemonDao.insertAll(
      pokemons.map(databaseMapper.toPokemonDatabaseEntity).toList(),
    );
    return pokemons;
  }
}