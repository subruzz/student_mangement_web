import 'package:flutter/material.dart';
import 'package:studentmanagement/responsive/responsive_widget.dart';
import 'package:studentmanagement/widgets/mobile-widgets/mobile_signup.dart';
import 'package:studentmanagement/widgets/desktop-widgets/web_signup.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
        desktopScreen: WebScreenSignup(), mobileScreen: MobileSignup());
  }
}
