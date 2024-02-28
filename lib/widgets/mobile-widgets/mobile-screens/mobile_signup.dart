import 'package:flutter/material.dart';
import 'package:studentmanagement/widgets/helping-widgets/form.dart';
import 'package:studentmanagement/widgets/helping-widgets/signup_image.dart';
import 'package:studentmanagement/widgets/helping-widgets/welcome_text.dart';

class MobileSignup extends StatelessWidget {
  const MobileSignup({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              children: [
                WelcomeText(
                  type: 'm',
                  text1: 'Welcome, New User!\n',
                  text2:
                      'Start exploring our app and discover amazing features!',
                ),
                SizedBox(height: 20),
                SignUpImage(
                  height: 300,
                  width: 300,
                  image: 'assets/images/signup_image.json',
                ),
                LoginForm(type: 'type'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
