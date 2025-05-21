import 'package:flutter/material.dart';

class LabelForm extends StatelessWidget {
  final String label;

  const LabelForm({super.key, required this.label});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 5
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }
}