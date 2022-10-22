import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:plastidive/screens/gamemapscreen.dart';

class StartGameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(
              'assets/images/base.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  "Let's Plasti Dive",
                  style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.w900),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: const Text(
                    "Player can collect multiple points over clearing plastic on beaches and compete over \n scores with friends.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                Align(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context)
                        .pushNamed(GameMapScreen.routeName),
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(270, 100)),
                    child: Text(
                      'Play Now',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
