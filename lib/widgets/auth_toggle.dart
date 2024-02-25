import 'package:flutter/material.dart';

class AuthScreenToggle extends StatelessWidget {
  const AuthScreenToggle(
      {super.key,
      required this.toggleAuthScreen,
      required this.text1,
      required this.text2});
  final void Function() toggleAuthScreen;
  final String text1;
  final String text2;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text1,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        TextButton(
            onPressed: () {
              toggleAuthScreen();
            },
            child: Text(
              text2,
              style: const TextStyle(color: Colors.blue, fontSize: 14),
            ))
      ],
    );
  }
}
