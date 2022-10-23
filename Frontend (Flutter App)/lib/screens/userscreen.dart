import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:plastidive/provider/userprovider.dart';
import 'package:plastidive/screens/gamemapscreen.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatelessWidget {
  static const routeName = '/userscreen';
  TextEditingController usercontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.lightBlue,
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  height: 200,
                  child: LottieBuilder.asset('assets/images/surf.json')),
              const Text(
                'Enter username',
                style: TextStyle(fontFamily: 'AlfaSlabOne', fontSize: 34),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: usercontroller,
                style: const TextStyle(fontFamily: 'Rubik', fontSize: 30),
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueGrey, width: 5.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 5.0),
                    ),
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white),
              ),
              const SizedBox(
                height: 60,
              ),
              ElevatedButton(
                onPressed: () {
                  if (!usercontroller.text.isEmpty) {
                    Provider.of<UserProvider>(context, listen: false)
                        .addUser(usercontroller.text)
                        .then((_) => Navigator.of(context)
                            .pushReplacementNamed(GameMapScreen.routeName));
                  }
                },
                style: ElevatedButton.styleFrom(fixedSize: Size(200, 70)),
                child: const Text('Start game',
                    style: TextStyle(
                        fontFamily: 'AlfaSlabOne',
                        fontSize: 20,
                        color: Colors.black)),
              )
            ],
          ),
        ));
  }
}
