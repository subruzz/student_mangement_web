import 'package:flutter/material.dart';

class LoginTextfields extends StatelessWidget {
  const LoginTextfields(
      {super.key,
      required this.controller,
      required this.fieldName,
      required this.icon});
  final TextEditingController controller;
  final String fieldName;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 400,
      ),
      child: TextFormField(
        style: Theme.of(context).textTheme.labelLarge,
        controller: controller,
        decoration: InputDecoration(
          labelStyle: Theme.of(context).textTheme.labelLarge,
          prefixIcon: Icon(icon),
          labelText: fieldName,
          hintText: fieldName,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$fieldName not found';
          }
          return null;
        },
      ),
    );
  }
}
