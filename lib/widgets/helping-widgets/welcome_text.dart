import 'package:flutter/material.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText(
      {super.key,
      required this.text1,
      required this.text2,
      required this.type});
  final String text1;
  final String text2;
  final String type;
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        children: [
          TextSpan(
              text: text1,
              style: type == 'd'
                  ? Theme.of(context).textTheme.bodyMedium
                  : Theme.of(context).textTheme.labelMedium),
          TextSpan(
              text: text2,
              style: type == 'd'
                  ? Theme.of(context).textTheme.bodyMedium
                  : Theme.of(context).textTheme.labelMedium),
        ],
      ),
    );
  }
}
