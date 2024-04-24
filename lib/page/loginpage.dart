import 'package:flutter/material.dart';
import 'package:simple_login_app/page/homepage.dart';
import 'package:simple_login_app/repos/user_repo.dart';
import 'package:simple_login_app/widget/logintext.dart';

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
    checkUser();
  }

  void checkUser() async {
    int userExist = await checkSavedUserData();

    if (userExist == 1) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MyHomePage(title: "Hello AWord"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'LOGIN',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 40, letterSpacing: 20),
            ),
            TextField(
              controller: _usernameController,
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  getUserList();
                  // if (_usernameController.text == "zhenxian" &&
                  //     _passwordController.text == "abc123") {
                  //   Navigator.of(context).push(
                  //     MaterialPageRoute(
                  //       builder: (context) => MyHomePage(title: "Hello World"),
                  //     ),
                  //   );
                  // }
                  // final result = await login(
                  //     _usernameController.text, _passwordController.text);

                  //Login With Api
                  // final result = await loginWithApi(
                  //     _usernameController.text, _passwordController.text);
                  // if (result != 0) {
                  //   Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => MyHomePage(title: "Hello AWord"),
                  //   ));
                  // } else {
                  //   ScaffoldMessenger.of(context)
                  //       .showSnackBar(SnackBar(content: Text("Invalid User")));
                  // }

                  // if (result.username != "" && result.password != "") {
                  //   Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => MyHomePage(title: "Hello AWord"),
                  //   ));
                  // } else {
                  //   ScaffoldMessenger.of(context)
                  //       .showSnackBar(SnackBar(content: Text("Invalid User")));
                  // }
                },
                child: Text('Login'))
          ],
        ),
      )),
    );
  }
}
