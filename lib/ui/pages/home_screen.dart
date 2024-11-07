import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(
            fontFamily: 'PixelFont',
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                 Navigator.pushNamed(context, '/pokedexScreen');
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
                        'Pokedex',
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
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/dailyEncounterScreen');
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
                        'Encounter',
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
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/partyScreen');
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
                        'Party',
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
          ],
        ),
      ),
    );
  }
}