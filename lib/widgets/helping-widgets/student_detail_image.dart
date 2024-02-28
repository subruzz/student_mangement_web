import 'package:flutter/material.dart';

class StudentImage extends StatelessWidget {
  const StudentImage({super.key, required this.image});
  final String image;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 2,
        child: Container(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: image.isEmpty
              ? Image.asset(
                  'assets/images/profile.png',
                  width: 100,
                  height: 200,
                )
              : Image.network(
                  image,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
        ));
  }
}
