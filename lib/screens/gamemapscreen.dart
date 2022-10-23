import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plastidive/provider/mapprovider.dart';
import 'package:plastidive/screens/addmarkerdata.dart';
import 'package:provider/provider.dart';

class GameMapScreen extends StatefulWidget {
  static const routeName = '/gamemap';
  @override
  State<GameMapScreen> createState() => _GameMapScreenState();
}

class _GameMapScreenState extends State<GameMapScreen> {
  Completer<GoogleMapController> mapController = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(21.111592730314037, 72.95422811061144), zoom: 10);

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(21.111592730314037, 72.95422811061144),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  Future<bool> requestPermission() async {
    final status = await [Permission.location, Permission.storage].request();
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
          if (snapshot.hasData) {
            return Stack(
              children: [
                GoogleMap(
                  onLongPress: (location) {
                    Provider.of<MapProvide>(context, listen: false).addMarker(
                        Marker(
                            markerId: MarkerId(location.toString()),
                            position: location));
                  },
                  mapToolbarEnabled: false,
                  mapType: MapType.normal,
                  markers: Provider.of<MapProvide>(context).getMarkers.toSet(),
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    mapController.complete(controller);
                  },
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AddMarkerData.routeName);
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue),
                    child: Text("Add marker"),
                  ),
                )
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        }
      }),
    ));
  }
}
