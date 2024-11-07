import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/configure_providers.dart';
import 'ui/pages/daily_encounter_screen.dart';
import 'ui/pages/home_screen.dart';
import 'ui/pages/party_screen.dart';
import 'ui/pages/pokedex_screen.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  
  final configureProviders = await ConfigureProviders.createDependencyTree();

  runApp(
    MultiProvider(
      providers: configureProviders.providers,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokedex App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/pokedexScreen': (context) => PokedexScreen(),
        '/dailyEncounterScreen': (context) => DailyEncounterScreen(),
        '/partyScreen': (context) => PartyScreen(),
      },
    );
  }
}

