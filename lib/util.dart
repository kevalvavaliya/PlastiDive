import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utility {
  static const String url = 'https://4e97-150-107-232-127.in.ngrok.io';

  static void showLoadingIndicator(String text, BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
              title: Text(text),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              )),
        );
      },
    );
  }
}
