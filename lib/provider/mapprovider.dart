import 'dart:convert';
import 'dart:io';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:plastidive/provider/userprovider.dart';

class MapProvide with ChangeNotifier {
  Set<Marker> _markers = {};
  File? pickedImaged;

  Set<Marker> get getMarkers {
    print(_markers);
    return _markers;
  }

  Future<void> addMarkerFirebase(LatLng position) async {
    final response = await http.post(
        Uri.parse(
            "https://plastidive-default-rtdb.firebaseio.com/markers.json"),
        body: jsonEncode({
          'position': position,
          'userid': UserProvider.UserModel.getUserId,
          'username': UserProvider.UserModel.getUsername
        }));
    print(response.body);
  }

  void addMarker(Marker marker) {
    addMarkerFirebase(marker.position);
    _markers.add(marker);
    notifyListeners();
  }

  void getImageFromCamera() async {
    XFile pickedFile = await ImagePicker().pickImage(
      imageQuality: 50,
      source: ImageSource.camera,
    ) as XFile;
    setImagepath(File(pickedFile.path));
  }
  void getImageFromGallery() async {
    XFile pickedFile = await ImagePicker().pickImage(
      imageQuality: 50,
      source: ImageSource.gallery,
    ) as XFile;
    setImagepath(File(pickedFile.path));
  }
   void setImagepath(File? image) {
    pickedImaged = image;
    notifyListeners();
  }

  File? getImagepath() {
    return pickedImaged;
  }
}
