import 'package:flutter/material.dart';

// TextFormFieldコンポーネント
class TF extends StatelessWidget {
  TF({
    this.controller,
    this.labelText,
    this.maxLines,
    this.onChanged,
    this.maxLength,
    this.validator,
  });

  final TextEditingController controller;
  final String labelText;
  final int maxLines;
  final int maxLength;
  final onChanged;
  final validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        maxLength: maxLength,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}
