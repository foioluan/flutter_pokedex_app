import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../data/database/database_mapper.dart';
import '../../data/database/pokemon_database.dart';
import '../../domain/pokemon.dart';
import '../widgets/pokemon_card.dart';

class PartyScreen extends StatefulWidget {
  const PartyScreen({super.key});

  @override
  State<PartyScreen> createState() => _PartyScreenState();
}

class _PartyScreenState extends State<PartyScreen> {
  late Future<List<Pokemon>> _caughtPokemonFuture;

  @override
  void initState() {
    super.initState();
    _caughtPokemonFuture = fetchCaughtPokemon();
  }

  Future<List<Pokemon>> fetchCaughtPokemon() async {
    final database = await $FloorPokemonDatabase.databaseBuilder('pokedex_db.db')
    .build();

    final partyDao = database.partyDao;
    final pokemonDao = database.pokemonDao;

    final caught = await partyDao.findAllPokemon();
    final List<Pokemon> pokemonList = [];

    for (final partyPokemon in caught) {
      final pokemonEntity = await pokemonDao.findPokemonById(partyPokemon.pokemonId);
      if (pokemonEntity != null) {
        final databaseMapper = DatabaseMapper();
        final pokemon = databaseMapper.toPokemon(pokemonEntity);
        pokemonList.add(pokemon);
      }
    }
    return pokemonList;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Party Pokemon",
          style: TextStyle(
              fontFamily: 'PixelFont',
              fontSize: 12,
            ),
          ),
          backgroundColor: Colors.red
      ),
      body: FutureBuilder<List<Pokemon>>(
        future: _caughtPokemonFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print("error: ${snapshot.error}");
            print("Stack trace: ${snapshot.stackTrace}");
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final pokemonList = snapshot.data!;
            return ListView.builder(
              itemCount: pokemonList.length,
              itemBuilder: (context, index) {
                final pokemon = pokemonList[index];
                final imageUrl = 'https://raw.githubusercontent.com/fanzeyi/pokemon.json/refs/heads/master/sprites/${pokemon.id}MS.png';
                return PokemonCard(imageUrl: imageUrl, pokemon: pokemon);
              },
            );
          } else {
            return const Center(child: Text("No Pokemon found."));
          }
        },
      ),
    );
  }
}
