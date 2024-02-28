import 'package:flutter/material.dart';
import 'package:studentmanagement/utils/responsive/responsive_widget.dart';
import 'package:studentmanagement/widgets/mobile-widgets/mobile-screens/mobile_signup.dart';
import 'package:studentmanagement/widgets/desktop-widgets/desktop_screens/web_signup.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponiveLayout(
        desktop: WebScreenSignup(), mobile: MobileSignup());
  }
}
