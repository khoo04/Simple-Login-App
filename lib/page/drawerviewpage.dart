import 'package:flutter/material.dart';
import 'package:simple_login_app/page/loginpage.dart';
import 'package:simple_login_app/page/registerpage.dart';

class DrawerViewPage extends StatefulWidget {
  const DrawerViewPage({super.key});

  @override
  State<DrawerViewPage> createState() => _DrawerViewPageState();
}

class _DrawerViewPageState extends State<DrawerViewPage> {
  Widget? body;
  List<Text> myTitle = [
    Text('Main Page'),
    Text("Login Page"),
    Text("Register Page")
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: myTitle[index],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.login),
              title: Text('Login'),
              onTap: () {
                // Navigate to home page

                Navigator.pop(context);
                setState(() {
                  index = 1;
                  body = LoginPage();
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.app_registration_rounded),
              title: Text('Register'),
              onTap: () {
                // Navigate to settings page

                Navigator.pop(context);
                setState(() {
                  index = 2;
                  body = RegisterPage();
                });
              },
            ),
          ],
        ),
      ),
      body: body,
    );
  }
}
