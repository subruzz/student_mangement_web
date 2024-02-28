import 'package:flutter/material.dart';
import 'package:studentmanagement/utils/responsive/responsive_widget.dart';
import 'package:studentmanagement/widgets/desktop-widgets/desktop_screens/web_login.dart';
import 'package:studentmanagement/widgets/mobile-widgets/mobile-screens/mobile_login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponiveLayout(
        desktop: WebScreenLogin(), mobile: MobileLogin());
  }
}
