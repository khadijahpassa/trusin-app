import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const PrimaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: primary400,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        minimumSize: const Size(double.infinity, 50), 
        padding: const EdgeInsets.symmetric(vertical: 16), 
      ),
      child: Text(
        text, 
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: heading3,
          )
        ),
    );
  }
}
