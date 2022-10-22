import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GameMapScreen extends StatefulWidget {
  static const routeName = '/gamemap';
  @override
  State<GameMapScreen> createState() => _GameMapScreenState();
}

class _GameMapScreenState extends State<GameMapScreen> {
  Completer<GoogleMapController> mapController = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  Future<bool> requestPermission() async {
    final status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      // files.sublist(1, 8);
      return true;
    } else if (status == PermissionStatus.denied) {
      return false;
    } else if (status == PermissionStatus.permanentlyDenied) {
      await openAppSettings();
      return false;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: requestPermission(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          //loader
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          );
        } else {
          return GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              mapController.complete(controller);
            },
          );
        }
      }),
    ));
  }
}
