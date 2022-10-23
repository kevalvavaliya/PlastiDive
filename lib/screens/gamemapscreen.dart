import 'dart:async';
import 'package:flutter/rendering.dart';
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
                    Provider.of<MapProvide>(context, listen: false)
                        .addMarker(Marker(
                            markerId: MarkerId(location.toString()),
                            icon: BitmapDescriptor.defaultMarkerWithHue(123.0),
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: ((context) {
                                    return ConstrainedBox(
                                      constraints: const BoxConstraints(
                                          maxHeight: 450,
                                          minWidth: double.infinity),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Image.network(
                                              'https://cdn.discordapp.com/attachments/889907958857744494/1033658140283113512/e44d5e33-d3b7-417e-8477-a5d17955de82.jpg'),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 4, horizontal: 10),
                                            child: Text(
                                              'cleaned plastic at Marina beach',
                                              style: TextStyle(
                                                  fontFamily: 'Rubik',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Container(
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 6,
                                                      horizontal: 10),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 4,
                                                      horizontal: 12),
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: Colors.blue[100]),
                                                  child: const FittedBox(
                                                    child: Text(
                                                      'plastic detected',
                                                      style: TextStyle(
                                                          fontFamily: 'Rubik',
                                                          color: Colors.blue),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                child: Container(
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 6,
                                                      horizontal: 10),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 4,
                                                      horizontal: 12),
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: Colors.green[100]),
                                                  child: const FittedBox(
                                                    child: Text(
                                                      'Detections : 0',
                                                      style: TextStyle(
                                                          fontFamily: 'Rubik',
                                                          color: Colors.green),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                child: Container(
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 6,
                                                      horizontal: 10),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 4,
                                                      horizontal: 12),
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: Colors.amber[100]),
                                                  child: const FittedBox(
                                                    child: Text(
                                                      'cleaned by : Abhi',
                                                      style: TextStyle(
                                                          fontFamily: 'Rubik',
                                                          color: Colors.orange),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pushNamed(
                                                    AddMarkerData.routeName);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Color.fromARGB(
                                                    255, 2, 253, 44),
                                              ),
                                              child: const Text(
                                                  'Plastic cleaned look for another marker',
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }));
                            },
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
                    child: const Text("Add marker"),
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
