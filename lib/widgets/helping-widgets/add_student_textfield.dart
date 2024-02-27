import 'package:flutter/material.dart';

class AddStudentTextField extends StatelessWidget {
  const AddStudentTextField(
      {super.key,
      this.maxLines,
      required this.icon,
      required this.controller,
      required this.label,
      required this.validation});
  final TextEditingController controller;
  final String label;
  final String? Function(String?) validation;
  final int? maxLines;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: TextFormField(
          maxLines: maxLines,
          style: Theme.of(context).textTheme.labelLarge,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          decoration: InputDecoration(
            labelStyle: Theme.of(context).textTheme.bodySmall,
            label: Text(label),
            hintText: label,
            prefixIcon: Icon(icon),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
          ),
          validator: validation),
    );
  }
}
