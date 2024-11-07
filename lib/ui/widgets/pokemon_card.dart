import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pokedex_app/ui/widgets/type_colors.dart';

import '../pages/pokemon_details.dart';


class PokemonCard extends StatelessWidget {
  const PokemonCard({
    super.key,
    required this.imageUrl,
    required this.pokemon,
  });

  final String imageUrl;
  final dynamic pokemon;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PokemonDetails(pokemon: pokemon)),
          );
        },
        child: Card(
          color: TypeColors.getColorType(type: pokemon.type.first),
          child: ListTile(
            leading: CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              width: 50,
              height: 50,
            ),
            title: Text(
              pokemon.name['english'] ?? 'Unknown',
              style: TextStyle(
                fontFamily: 'PixelFont',
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            subtitle: Text(
              'Types: ${pokemon.type.join(', ')}',
              style: TextStyle(
                fontFamily: 'PixelFont',
                fontSize: 12,
                color: Colors.black, // Ajuste o tamanho conforme necessário
              ),
            ),
          ),
        ),
      ) 
    );
  }
}