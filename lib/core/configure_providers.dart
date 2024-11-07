import 'package:flutter/material.dart';
import 'package:pokedex_app/data/database/dao/party_dao.dart';
import 'package:provider/provider.dart';
import '../data/database/pokemon_database.dart';
import '../data/database/database_mapper.dart';
import '../data/network/client/api_client.dart';
import '../data/network/network_mapper.dart';
import '../data/repository/pokemon_repository_impl.dart';

//  facilita o uso de recursos como o banco de dados, 
//  a API de rede e o repositório de Pokémon

class ConfigureProviders {
  final List<Provider> providers;

  ConfigureProviders._(this.providers);

  static Future<ConfigureProviders> createDependencyTree() async {

    // Inicializando o banco de dados
    final database =
        await $FloorPokemonDatabase.databaseBuilder('pokedex_db.db').build();

    // Inicializando as dependências
    final pokemonDao = database.pokemonDao;
    final partyDao = database.partyDao;
    final databaseMapper = DatabaseMapper();
    final apiClient = ApiClient(baseUrl: "http://192.168.0.34:3000");
    final networkMapper = NetworkMapper();

    // Criando o repositório
    final pokemonRepository = PokemonRepositoryImpl(
      pokemonDao: pokemonDao,
      databaseMapper: databaseMapper,
      apiClient: apiClient,
      networkMapper: networkMapper,
    );

    // Configurando os providers
    final providers = [
      Provider<PokemonRepositoryImpl>.value(value: pokemonRepository),
      Provider<PartyDao>.value(value: partyDao),
    ];

    return ConfigureProviders._(providers);
  }
}