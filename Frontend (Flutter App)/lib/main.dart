import 'package:flutter/material.dart';
import 'package:plastidive/provider/mapprovider.dart';
import 'package:plastidive/provider/userprovider.dart';
import 'package:plastidive/screens/addmarkerdata.dart';
import 'package:plastidive/screens/gamemapscreen.dart';
import 'package:plastidive/screens/rewardscreen.dart';
import 'package:plastidive/screens/startgamescreen.dart';
import 'package:plastidive/screens/userscreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: MapProvide()),
        ChangeNotifierProvider.value(value: UserProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
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
          UserScreen.routeName: (context) => UserScreen(),
          GameMapScreen.routeName: (context) => GameMapScreen(),
          AddMarkerData.routeName: (context) => AddMarkerData(),
          RewardScreen.routeName: (context) => RewardScreen(),
        },
      ),
    );
  }
}
