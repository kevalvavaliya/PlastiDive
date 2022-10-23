import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';

class RewardScreen extends StatelessWidget {
  static const String routeName = '/rewards';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset('assets/images/score.json'),
            Text(
              'Woo hoo 🥳🥳!!',
              style: Theme.of(context).textTheme.headline5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
              child: Text(
                'You have Earned 10 plastidive coins 🪙🪙 \n earn more to get rewards.',
                style: TextStyle(fontFamily: 'Rubik', fontSize: 30),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
