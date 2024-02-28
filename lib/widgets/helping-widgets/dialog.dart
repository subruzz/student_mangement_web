import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({super.key, required this.onClick, required this.title});
  final void Function() onClick;
  final String title;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
                color: Colors.red,
              ),
            ),
            IconButton(
                onPressed: () {
                  onClick();
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.check,
                  color: Colors.green,
                )),
          ],
        )
      ],
      title: Text(
        title,
        style:const  TextStyle(
            color: Colors.black, fontWeight: FontWeight.normal, fontSize: 18),
      ),
    );
  }
}
