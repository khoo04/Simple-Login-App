import 'package:flutter/material.dart';
import 'package:simple_login_app2/page/homepage.dart';
import 'package:simple_login_app2/widget/logintext.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
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
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_usernameController.text == "zhenxian" &&
                      _passwordController.text == "abc123") {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MyHomePage(title: "Hello World"),
                      ),
                    );
                  }
                },
                child: Text('Login'))
          ],
        ),
      )),
    );
  }
}
