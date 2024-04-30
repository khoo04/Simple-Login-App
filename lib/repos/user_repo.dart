import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_login_app/models/user.dart';

const url = "http://10.0.2.2:5000/api/User";
// Future<List> getUserList() async {
//   final String userJson = await rootBundle.loadString('lib/assets/user.json');
//   //final _json = jsonDecode(userJson);
//   final List userData = json.decode(userJson)['users'] as List;
//   // if (_json case {"users": List users}) {
//   //   return users.map((json) => User.fromJson(json)).toList();
//   // } else {
//   //   throw const FormatException();
//   // }

//   final users = userData.map((value) => User.fromJson(value)).toList();
//   return users;
// }

Future<List?> getUserList() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    const getUserUrl = "$url/getUser";
    final request = await HttpClient().postUrl(Uri.parse(getUserUrl));
    request.headers.set("token", token!);
    final response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      String responseBody = await response.transform(utf8.decoder).join();
      List<dynamic> parsedList = json.decode(responseBody) as List;
      return parsedList;
    } else {
      return null;
    }
  } catch (ex) {
    print(ex);
    return null;
  }
}

Future<List<String>> getUserName() async {
  try {
    final getNameUrl = "$url/getNames";
    final request = await HttpClient().getUrl(Uri.parse(getNameUrl));
    final response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      String responseBody = await response.transform(utf8.decoder).join();
      List<dynamic> parsedList = json.decode(responseBody) as List<dynamic>;
      List<String> users =
          parsedList.map((element) => element.toString()).toList();
      return users;
    } else {
      return [];
    }
  } catch (ex) {
    return [];
  }
}

Future<bool> loginWithApi(String username, String password) async {
  try {
    const loginURL = "$url/login";
    final request = await HttpClient().postUrl(Uri.parse(loginURL));
    request.headers.set("Content-Type", "application/json;charset=UTF-8");

    final requestBody =
        json.encode({"Username": username, "Password": password});
    request.write(requestBody);

    final response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      String token = await response.transform(utf8.decoder).join();
      saveUserData(
          user: User(username: username, password: password), token: token);
      return true;
    } else {
      return false;
    }
  } catch (ex) {
    print(ex);
    return false;
  }
}

// Future<User> login(String username, String password) async {
//   final userList = await getUserList();
//   User user = userList.firstWhere(
//     (user) => user.username == username && user.password == password,
//     orElse: () => User.nullUser(),
//   );

//   if (!isNullUser(user)) {
//     //saveUserData(user);
//   }
//   return user;
// }

bool isNullUser(User user) {
  return (user.username == "" && user.password == "");
}

//Flutter pub add shared_preferences
//Save User Token
Future<void> saveUserData({required User user, required String token}) async {
  final prefs = await SharedPreferences.getInstance();

  final userJson = json.encode(user.toJson());
  prefs.setString('user', userJson);
  prefs.setString('token', token);
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

//Get Roles
Future<String> getUserRoles(String username) async {
  try {
    final getRolesURL = "$url/getUserRoles?username=$username";
    final request = await HttpClient().getUrl(Uri.parse(getRolesURL));
    final response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      String responseBody = await response.transform(utf8.decoder).join();
      return responseBody;
    } else {
      return "";
    }
  } catch (ex) {
    return "";
  }
}

Future<bool> registerWithApi(String username, String password) async {
  try {
    const registerUrl = "$url/addUser";
    final request = await HttpClient().postUrl(Uri.parse(registerUrl));
    request.headers.set("Content-Type", "application/json;charset=UTF-8");
    final requestBody =
        json.encode({"Username": username, "Password": password});
    request.write(requestBody);
    final response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else {
      return false;
    }
  } catch (ex) {
    print(ex);
    return false;
  }
}

Future<void> userLogOut() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove("token");
}
