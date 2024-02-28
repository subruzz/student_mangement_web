import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  const AuthButton(
      {super.key,
      required this.text,
      required this.authCheck,
      required this.isLoading});
  final String text;
  final bool isLoading;
  final void Function() authCheck;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () async {
        authCheck();
      },
      style: OutlinedButton.styleFrom(
        fixedSize: const Size(395, 55),
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: isLoading
            ? const CircularProgressIndicator()
            : Text(
                text,
              ),
      ),
    );
  }
}
