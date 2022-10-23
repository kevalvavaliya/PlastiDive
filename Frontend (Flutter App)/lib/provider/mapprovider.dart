import 'dart:convert';
import 'dart:io';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:plastidive/provider/userprovider.dart';
import 'package:plastidive/util.dart';

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

  Future<void> uplodeImage(File image) async {
    // upload image to estuary filecoin
    var estuaryUplodeData = Uri.parse('${Utility.url}/uplode');

    var multipart_request = http.MultipartRequest('POST', estuaryUplodeData);

    multipart_request.files
        .add(await http.MultipartFile.fromPath('data', image.path));
    multipart_request.headers.addAll({
      "ngrok-skip-browser-warning": "2354",
      'Content-Type': 'multipart/form-data',
    });
    var response =
        await http.Response.fromStream(await multipart_request.send());
    print('img sent ipfs api called' + response.statusCode.toString());
    // print(response.body);
    var data = jsonDecode(response.body);

    //pinning data to ipfs
  }

  Future<void> detect() async {
    final resp = await http.post(Uri.parse('${Utility.url}/detect'),
        headers: {
          "ngrok-skip-browser-warning": "2354",
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          "image_url":
              "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8c/Cow_%28Fleckvieh_breed%29_Oeschinensee_Slaunger_2009-07-07.jpg/360px-Cow_%28Fleckvieh_breed%29_Oeschinensee_Slaunger_2009-07-07.jpg"
        }));
    print(resp.statusCode);
    print(resp.body);
  }
}
