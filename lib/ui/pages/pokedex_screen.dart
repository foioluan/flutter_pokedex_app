import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import '../../data/repository/pokemon_repository_impl.dart';
import '../../domain/pokemon.dart';
import '../widgets/pokemon_card.dart';

class PokedexScreen extends StatefulWidget {
  @override
  _PokemonListPageState createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokedexScreen> {
  static const int _pageSize = 20;
  final PagingController<int, Pokemon> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPokemons(pageKey);
    });
  }

  Future<void> _fetchPokemons(int pageKey) async {
    try {
      final repository = Provider.of<PokemonRepositoryImpl>(context, listen: false);
      final pokemons = await repository.getPokemonList(page: pageKey, limit: _pageSize);

      final isLastPage = pokemons.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(pokemons);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(pokemons, nextPageKey);
      }
    } catch (error, stackTrace) {
      debugPrint("Erro ao carregar pokémons: ${error.toString()}");
      debugPrintStack(label: "Stack Trace", stackTrace: stackTrace);

      _pagingController.error = error;
      _showErrorDialog(error);
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pokedex',
          style: TextStyle(
              fontFamily: 'PixelFont',
              fontSize: 12, // Ajuste o tamanho conforme necessário
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.red
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: PagedListView<int, Pokemon>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Pokemon>(
            itemBuilder: (context, pokemon, index) {
              final pokemonId = pokemon.id.toString().padLeft(3, '0');
              final imageUrl = 'https://raw.githubusercontent.com/fanzeyi/pokemon.json/refs/heads/master/sprites/${pokemonId}MS.png';
        
              return PokemonCard(imageUrl: imageUrl, pokemon: pokemon);
            },
          ),
        ),
      ),
    );
  }

  void _showErrorDialog(dynamic error) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Erro ao carregar Pokémons"),
        content: Text(
          "Ocorreu um erro ao carregar a lista de pokémons. Tente novamente mais tarde.\n\nDetalhes: ${error.toString()}",
        ),
        actions: <Widget>[
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
}



