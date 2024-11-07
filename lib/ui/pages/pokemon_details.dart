import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_app/ui/widgets/type_colors.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class PokemonDetails extends StatelessWidget {
  const PokemonDetails({
    super.key, 
    required this.pokemon,
  });

  final dynamic pokemon;

  @override
  Widget build(BuildContext context) {
    final pokemonId = pokemon.id.toString().padLeft(3, '0');
    final imageUrl = 'https://raw.githubusercontent.com/fanzeyi/pokemon.json/refs/heads/master/images/${pokemonId}.png';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detalhes do Pokemon',
          style: TextStyle(
            fontFamily: 'PixelFont',
            fontSize: 12,
          ),
        ),
        backgroundColor: TypeColors.getColorType(type: pokemon.type.first),
      ),
      backgroundColor: TypeColors.getColorType(type: pokemon.type.first),
      body: Stack(
        children: [
          // Imagem de fundo (imagem do seu computador), posicionada atrás da imagem do Pokémon
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
              pokemon.name['english'] + ' #${pokemonId}' ?? 'Unknown',
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
                imageUrl: imageUrl,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                width: 250,
                height: 250,
              ),
            ),
          ),
          // SlidingSheet sobrepondo parcialmente a imagem
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
                    // Row contendo os tipos, no início do SlidingSheet
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
                            color: TypeColors.getColorType(type: pokemon.type.first), // Cor do fundo do container
                            borderRadius: BorderRadius.circular(8), // Borda arredondada
                          ),
                          child: Center(
                            child: Text(
                              pokemon.type.first,
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
                              color: TypeColors.getColorType(type: pokemon.type.last), // Cor do fundo do container
                              borderRadius: BorderRadius.circular(8), // Borda arredondada
                            ),
                            child: Center(
                              child: Text(
                                pokemon.type.last,
                                style: TextStyle(
                                  fontFamily: 'PixelFont',
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 50), // Espaço entre os tipos e o resto do conteúdo
                    // O resto do conteúdo do SlidingSheet...
                    const Center(
                      child: Text(
                        "Base Stats",
                        style: TextStyle(
                          fontFamily: 'PixelFont',
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'HP',
                              style: TextStyle(
                                fontFamily: 'PixelFont',
                                fontSize: 10,
                                color: Colors.black,
                              )
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Attack',
                              style: TextStyle(
                                fontFamily: 'PixelFont',
                                fontSize: 10,
                                color: Colors.black,
                              )
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Defense',
                              style: TextStyle(
                                fontFamily: 'PixelFont',
                                fontSize: 10,
                                color: Colors.black,
                              )
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Sp. Attack',
                              style: TextStyle(
                                fontFamily: 'PixelFont',
                                fontSize: 10,
                                color: Colors.black,
                              )
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Sp. Defense',
                              style: TextStyle(
                                fontFamily: 'PixelFont',
                                fontSize: 10,
                                color: Colors.black,
                              )
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Speed',
                              style: TextStyle(
                                fontFamily: 'PixelFont',
                                fontSize: 10,
                                color: Colors.black,
                              )
                            ),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${pokemon.base['HP']}',
                              style: const TextStyle(
                                fontFamily: 'PixelFont',
                                fontSize: 10,
                                color: Colors.black,
                              )
                            ),
                            const SizedBox(height: 20),
                            Text(
                              '${pokemon.base['Attack']}',
                              style: const TextStyle(
                                fontFamily: 'PixelFont',
                                fontSize: 10,
                                color: Colors.black,
                              )
                            ),
                            const SizedBox(height: 20),
                            Text(
                              '${pokemon.base['Defense']}',
                              style: const TextStyle(
                                fontFamily: 'PixelFont',
                                fontSize: 10,
                                color: Colors.black,
                              )
                            ),
                            const SizedBox(height: 20),
                            Text(
                              '${pokemon.base['Sp. Attack']}',
                              style: const TextStyle(
                                fontFamily: 'PixelFont',
                                fontSize: 10,
                                color: Colors.black,
                              )
                            ),
                            const SizedBox(height: 20),
                            Text(
                              '${pokemon.base['Sp. Defense']}',
                              style: const TextStyle(
                                fontFamily: 'PixelFont',
                                fontSize: 10,
                                color: Colors.black,
                              )
                            ),
                            const SizedBox(height: 20),
                            Text(
                              '${pokemon.base['Speed']}',
                              style: const TextStyle(
                                fontFamily: 'PixelFont',
                                fontSize: 10,
                                color: Colors.black,
                              )
                            ),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Column(
                          children: [
                            StatusBar(
                              widthFactor: pokemon.base['HP'] / 160,
                            ),
                            SizedBox(
                              height: 23,
                            ),
                            StatusBar(
                              widthFactor: pokemon.base['Attack'] / 160,
                            ),
                            SizedBox(
                              height: 23,
                            ),
                            StatusBar(
                              widthFactor: pokemon.base['Defense'] / 160,
                            ),
                            SizedBox(
                              height: 23,
                            ),
                            StatusBar(
                              widthFactor: pokemon.base['Sp. Attack'] / 160,
                            ),
                            SizedBox(
                              height: 23,
                            ),
                            StatusBar(
                              widthFactor: pokemon.base['Sp. Defense'] / 160,
                            ),
                            SizedBox(
                              height: 23,
                            ),
                            StatusBar(
                              widthFactor: pokemon.base['Speed'] / 160,
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class StatusBar extends StatelessWidget {
  final double widthFactor;

  const StatusBar({super.key, required this.widthFactor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10,
      child: Center(
        child: Container(
          height: 4,
          width: 150,
          alignment: Alignment.centerLeft,
          decoration: ShapeDecoration(
            shape: StadiumBorder(),
            color: Colors.grey,
          ),
          child: FractionallySizedBox(
            widthFactor: widthFactor,
            heightFactor: 1.0,
            child: Container(
              decoration: ShapeDecoration(
                shape: StadiumBorder(),
                color: widthFactor > 0.5 ? Colors.teal : Colors.red,
              ),
            ),
          ),
        ),
      ),
    );
  }
}