import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_app/data/database/dao/party_dao.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import '../../data/database/entity/party_database_entity.dart';
import '../../data/repository/pokemon_repository_impl.dart';
import '../../domain/pokemon.dart';
import '../widgets/type_colors.dart';

class DailyEncounterScreen extends StatefulWidget {
  const DailyEncounterScreen({super.key});

  @override
  State<DailyEncounterScreen> createState() => _DailyEncounterScreenState();
}

class _DailyEncounterScreenState extends State<DailyEncounterScreen> {
  Future<Pokemon>? _randomPokemonFuture;
  late SharedPreferences _prefs;
  static const String _pokemonKey = 'dailyPokemonKey';
  static const String _dateKey = 'dailyDateKey';

  @override
  void initState() {
    super.initState();
    _initializePrefs();
  }

  Future<void> _initializePrefs() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _randomPokemonFuture = fetchRandomPokemon();
    });
  }

  Future<Pokemon> fetchRandomPokemon() async {
    final today = DateTime.now().toString().substring(0, 10);
    final storedDate = _prefs.getString(_dateKey);
    final storedPokemonId = _prefs.getInt(_pokemonKey);

    if (storedDate == today && storedPokemonId != null) {
      final repository = Provider.of<PokemonRepositoryImpl>(context, listen: false);
      final pokemons = await repository.getPokemonList(page: 1, limit: 809);
      final cachedPokemon = pokemons.firstWhere((p) => p.id == storedPokemonId);
      return cachedPokemon;
    }

    final repository = Provider.of<PokemonRepositoryImpl>(context, listen: false);
    final pokemons = await repository.getPokemonList(page: 1, limit: 809);
    final randomIndex = Random().nextInt(pokemons.length);
    final randomPokemon = pokemons[randomIndex];

    await _prefs.setString(_dateKey, today);
    await _prefs.setInt(_pokemonKey, randomPokemon.id);

    return randomPokemon;
  }

  Future<void> catchPokemon(Pokemon pokemon) async {
    final caught = _prefs.getBool('caught_${pokemon.id}') ?? false;
    if (caught) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("This Pokemon has already been captured!")),
      );
      return;
    }
    final partyDao = Provider.of<PartyDao>(context, listen: false);

    // Verificar a quantidade de Pokémon na equipe
    final party = await partyDao.findAllPokemon();
    if (party.length >= 6) {
      // Mostrar mensagem e voltar para a tela anterior
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text("Full party! No more Pokemon can be captured.")),
      ); // Voltar para a tela anterior
      return;
    }

    // Criar uma nova instância de EquipeEntity a partir do Pokémon
    final partyEntity = PartyDatabaseEntity(pokemonId: pokemon.id);

    // Inserir no banco de dados
    await partyDao.insertPokemon(partyEntity);
    _prefs.setBool('caught_${pokemon.id}', true);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Pokemon successfully captured!")),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Daily Encounter',
                style: TextStyle(
                  fontFamily: 'PixelFont',
                  fontSize: 12,
                ),
              ),
              backgroundColor: Colors.red
            ),
            body: Center(
              child: FutureBuilder<Pokemon>(
                future: _randomPokemonFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else if (snapshot.hasData) {
                    final pokemon = snapshot.data!;
                    return Stack(
                      children: [
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.15, // A mesma altura que a imagem do Pokémon
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Image.asset(
                              'assets/images/pokeball_white_image.png', // Caminho da sua imagem no diretório de assets
                              width: 280, // Mesmo tamanho que a imagem do Pokémon
                              height: 280, // Mesmo tamanho que a imagem do Pokémon
                              fit: BoxFit.cover, // Garante que a imagem preencha completamente a área
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Text(
                            '${pokemon.name['english']} #${pokemon.id}' ?? 'Unknown',
                            style: const TextStyle(
                              fontFamily: 'PixelFont',
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.15, // A mesma altura que a imagem de fundo
                          left: 0,
                          right: 0,
                          child: Center(
                            child: CachedNetworkImage(
                              imageUrl: 'https://raw.githubusercontent.com/fanzeyi/pokemon.json/refs/heads/master/images/${pokemon.id}.png',
                              placeholder: (context, url) => CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                              width: 250,
                              height: 250,
                            ),
                          ),
                        ),
                        SlidingSheet(
                          elevation: 8,
                          cornerRadius: 16,
                          snapSpec: const SnapSpec(
                            snap: true,
                            snappings: [0.4, 0.7, 1.0],
                            positioning: SnapPositioning.relativeToAvailableSpace,
                          ),
                          builder: (context, state) {
                            return Container(
                              height: 500,
                              padding: const EdgeInsets.all(30.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        "Types:",
                                        style: TextStyle(
                                          fontFamily: 'PixelFont',
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(width: 8), // Espaço entre o texto e o Container
                                      Container(
                                        width: 100,
                                        height: 30,
                                        padding: EdgeInsets.all(4), // Espaço interno do container
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(255, 0, 164, 170), // Cor do fundo do container
                                          borderRadius: BorderRadius.circular(8), // Borda arredondada
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Unknown',
                                            style: TextStyle(
                                              fontFamily: 'PixelFont',
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      if (pokemon.type.first != pokemon.type.last)
                                        Container(
                                          width: 100,
                                          height: 30,
                                          padding: EdgeInsets.all(4), // Espaço interno do container
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(255, 0, 164, 170), // Cor do fundo do container
                                            borderRadius: BorderRadius.circular(8), // Borda arredondada
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Unknown',
                                              style: TextStyle(
                                                fontFamily: 'PixelFont',
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  SizedBox(height: 30),
                                  Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        catchPokemon(pokemon);
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          // Imagem ao lado esquerdo do botão
                                          Image.asset(
                                            'assets/images/pokeball_image.png', // Substitua pelo caminho da sua imagem
                                            width: 50,
                                            height: 50,
                                          ), // Espaço entre a imagem e o botão
                                          Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/images/button_border_image.png',
                                                width: 150,
                                                height: 120,
                                              ),
                                              const Text(
                                                'Catch',
                                                style: TextStyle(
                                                  fontFamily: 'PixelFont',
                                                  fontSize: 9,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  } else {
                    return const Text("No Pokemon found.",
                      style: TextStyle(color: Colors.white));
                  }
                },
              ),
            ),
          );
        }
      }