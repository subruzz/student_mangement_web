import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout(
      {super.key, required this.desktopScreen, required this.mobileScreen});
  final Widget mobileScreen;
  final Widget desktopScreen;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 900) {
          return mobileScreen;
        } else {
          return desktopScreen;
        }
      },
    );
  }
}
