import 'package:flutter/material.dart';

class SignUpImage extends StatelessWidget {
  const SignUpImage(
      {super.key,
      required this.height,
      required this.width,
      required this.image});
  final double width;
  final double height;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/login_image_3bd54d0c.png',
        width: width, height: height);
  }
}
