import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String imagePath;
  final String username;
  final String role;
  const UserTile(
      {super.key,
      required this.imagePath,
      required this.username,
      required this.role});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        imagePath,
        width: 120.0,
        fit: BoxFit.fitWidth,
      ),
      title: Text(
        username,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
      ),
      subtitle: Text(role),
      tileColor: Colors.grey[200],
    );
  }
}
