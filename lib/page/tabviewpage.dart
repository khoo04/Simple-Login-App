import 'package:flutter/material.dart';
import 'package:simple_login_app/page/loginpage.dart';
import 'package:simple_login_app/page/registerpage.dart';

class TabViewPage extends StatefulWidget {
  const TabViewPage({super.key});

  @override
  State<TabViewPage> createState() => _TabViewPageState();
}

class _TabViewPageState extends State<TabViewPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Tab Bar Example"),
        ),
        body: TabBarView(children: [
          const LoginPage(),
          RegisterPage(),
        ]),
        bottomNavigationBar: TabBar(
          tabs: [
            Text("Login Page"),
            Text("Register Page"),
          ],
        ),
      ),
    );
  }
}
