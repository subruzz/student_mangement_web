import 'package:flutter/material.dart';
import 'package:studentmanagement/responsive/responsive_widget.dart';
import 'package:studentmanagement/widgets/desktop-widgets/web_login.dart';
import 'package:studentmanagement/widgets/mobile-widgets/mobile_signup.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponiveLayout(
        desktop: WebScreenLogin(), mobile: MobileSignup());
  }
}
