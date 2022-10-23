import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class usermodel {
  String username = '';
  String userid = '';

  set setUsername(String username) {
    this.username = username;
  }

  String get getUsername {
    return username;
  }

  String get getUserId {
    return userid;
  }

  set setUserId(String userId) {
    this.userid = userid;
  }
}

class UserProvider extends ChangeNotifier {
  static usermodel UserModel = usermodel();

  Future<void> addUser(String username) async {
    final response = await http.post(
        Uri.parse('https://plastidive-default-rtdb.firebaseio.com/users.json'),
        body: jsonEncode({
          'username': username,
        }));
    final data = jsonDecode(response.body);
    final userId = data["name"];
    print(userId);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map userMap = {'username': username, 'userId': userId};
    prefs.setString("user", jsonEncode(userMap));
    UserModel.setUserId = userId;
    UserModel.setUsername = username;
  }

  Future<bool> tryLogin() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey("user")) {
        return false;
      }
      var userData = jsonDecode(prefs.getString("user") as String);
      UserProvider.UserModel.setUsername = userData['username'];
      UserProvider.UserModel.setUserId = userData['userId'];
      print(userData);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
