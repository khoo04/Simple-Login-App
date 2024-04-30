import 'package:flutter/material.dart';
import 'package:simple_login_app/page/homepage.dart';
import 'package:simple_login_app/page/registerpage.dart';
import 'package:simple_login_app/repos/user_repo.dart';
import 'package:simple_login_app/widget/alert_dialog.dart';
import 'package:simple_login_app/widget/date_picker.dart';
import 'package:simple_login_app/widget/logintext.dart';

import '../models/user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  // void autoLogin() async {
  //   User user = await checkSavedUser();
  //   if (!isNullUser(user)) {
  //     final result = await loginWithApi(user.username, user.password);
  //     if (result) {
  //       Navigator.of(context).push(MaterialPageRoute(
  //         builder: (context) =>
  //             MyHomePage(title: "Hello AWord ${user.username} "),
  //       ));
  //     } else {
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(SnackBar(content: Text("Invalid User")));
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'LOGIN',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    letterSpacing: 20),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "Username",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "Password",
                  ),
                  obscureText: true,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (_usernameController.text.isEmpty ||
                          _passwordController.text.isEmpty) {
                        showAlertDialog(
                            context: context,
                            title: "Empty String",
                            message: "Please fill all fields.");
                        return;
                      }
                      //Login With Api
                      final result = await loginWithApi(
                          _usernameController.text, _passwordController.text);
                      _pushPage(result);
                    },
                    child: const Text('Login'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RegisterPage(),
                        ),
                      );
                    },
                    child: const Text("Register"),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      print(await myDatePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                          timePickerEntryMode: TimePickerEntryMode.dial));
                    },
                    child: const Text("Show Time Picker"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _pushPage(bool result) {
    if (result) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MyHomePage(
            title: "My Home Page",
            currentUsername: _usernameController.text,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Invalid User")));
    }
  }
}
