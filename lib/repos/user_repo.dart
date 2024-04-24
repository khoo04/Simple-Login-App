import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_login_app/models/user.dart';

const url = "http://169.254.16.140:5000/api/";
Future<List> getUserList() async {
  final String userJson = await rootBundle.loadString('lib/assets/user.json');
  //final _json = jsonDecode(userJson);
  final List userData = json.decode(userJson)['users'] as List;
  // if (_json case {"users": List users}) {
  //   return users.map((json) => User.fromJson(json)).toList();
  // } else {
  //   throw const FormatException();
  // }

  final users = userData.map((value) => User.fromJson(value)).toList();
  return users;
}

Future<int> loginWithApi(String username, String password) async {
  try {
    final login_url = url + "User/login";
    final request = await HttpClient().postUrl(Uri.parse(login_url));
    request.headers.set("Content-Type", "application/json;charset=UTF-8");

    final requestBody =
        json.encode({'username': username, 'password': password});
    request.write(requestBody);

    final response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      return int.parse(await response.transform(utf8.decoder).join());
    } else {
      return 0;
    }
  } catch (ex) {
    return 0;
  }
}

Future<User> login(String username, String password) async {
  final userList = await getUserList();
  User user = userList.firstWhere(
    (user) => user.username == username && user.password == password,
    orElse: () => User.nullUser(),
  );

  if (!isNullUser(user)) {
    saveUserData(user);
  }
  return user;
}

bool isNullUser(User user) {
  return (user.username == "" && user.password == "");
}

//Flutter pub add shared_preferences
Future<void> saveUserData(User user) async {
  final prefs = await SharedPreferences.getInstance();

  final userJson = json.encode(user.toJson());
  prefs.setString('user', userJson);
}

Future<int> checkSavedUserData() async {
  final prefs = await SharedPreferences.getInstance();
  final userInPrefs = prefs.getString('user');

  if (userInPrefs == null) {
    return 0;
  }
  final userJson = json.decode(userInPrefs);

  final user = User.fromJson(userJson);

  if (isNullUser(user)) {
    return 0;
  } else {
    return 1;
  }
}

Future<User> checkSavedUser() async {
  final prefs = await SharedPreferences.getInstance();
  final userInPrefs = prefs.getString('user');

  if (userInPrefs == null) {
    return User.nullUser();
  }
  final userJson = json.decode(userInPrefs);

  final user = User.fromJson(userJson);
  return user;
}
