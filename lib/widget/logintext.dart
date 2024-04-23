import 'package:flutter/material.dart';

class LoginText extends StatelessWidget {
  const LoginText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'LOGIN',
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 40, letterSpacing: 20),
    );
  }
}
