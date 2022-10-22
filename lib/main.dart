import 'package:flutter/material.dart';
import 'package:plastidive/screens/gamemapscreen.dart';
import 'package:plastidive/screens/startgamescreen.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        textTheme: ThemeData.light().textTheme.copyWith(
            headline5: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                fontFamily: 'AlfaSlabOne')),
      ),
      home: StartGameScreen(),
      routes: {
        GameMapScreen.routeName:(context) => GameMapScreen()
      },
    );
  }
}
