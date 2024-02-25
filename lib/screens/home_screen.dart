import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.email});
  final String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance
                    .signOut()
                    .then((value) => Navigator.pop(context));
              },
              icon: const Icon(Icons.logout)),
          Center(
            child: Text(email),
          ),
        ],
      ),
    );
  }
}
