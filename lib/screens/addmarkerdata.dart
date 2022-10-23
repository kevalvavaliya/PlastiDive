import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:plastidive/provider/mapprovider.dart';
import 'package:plastidive/screens/rewardscreen.dart';
import 'package:plastidive/util.dart';
import 'package:provider/provider.dart';

class AddMarkerData extends StatelessWidget {
  TextEditingController markercontroller = TextEditingController();

  static const String routeName = '/addmarker';

  @override
  Widget build(BuildContext context) {
    File? image = Provider.of<MapProvide>(context).getImagepath();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.lightBlue,
        child: Column(
          children: [
            Container(
                height: 300,
                decoration: BoxDecoration(color: Colors.blue[50]),
                width: double.infinity,
                child: image != null
                    ? Image.file(
                        image,
                        fit: BoxFit.cover,
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Add image'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Provider.of<MapProvide>(context,
                                            listen: false)
                                        .getImageFromCamera();
                                  },
                                  icon: Icon(Icons.camera_enhance)),
                              IconButton(
                                  onPressed: () {
                                    Provider.of<MapProvide>(context,
                                            listen: false)
                                        .getImageFromGallery();
                                  },
                                  icon: Icon(Icons.photo))
                            ],
                          ),
                        ],
                      )),
            Padding(
              padding: const EdgeInsets.all(38.0),
              child: TextField(
                controller: markercontroller,
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
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                if (!markercontroller.text.isEmpty) {
                  // Provider.of<MapProvide>(context, listen: false)
                  //     .uplodeImage(image as File);
                  Utility.showLoadingIndicator(
                      "We are diving deep a few bits tried to escape, but we caught them",
                      context);
                  Timer(Duration(seconds: 5), () {
                    Navigator.of(context).pop(context);
                    Navigator.of(context)
                        .pushReplacementNamed(RewardScreen.routeName);
                  });
                }
              },
              style: ElevatedButton.styleFrom(fixedSize: Size(200, 70)),
              child: const Text('Detect plastic',
                  style: TextStyle(
                      fontFamily: 'AlfaSlabOne',
                      fontSize: 20,
                      color: Colors.black)),
            ),
            Image.asset('assets/images/scuba.png')
          ],
        ),
      ),
    );
  }
}
