import 'package:flutter/material.dart';

void showSnackBar(String msg, BuildContext context) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
}
