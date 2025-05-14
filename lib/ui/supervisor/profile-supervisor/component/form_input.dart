import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trusin_app/const.dart';

class TextFieldInput extends StatelessWidget {
  final String hintText;
  final bool isRequired;
  final bool enabled;
  final String svgIconPath;
  final TextEditingController? controller;

  const TextFieldInput({
    super.key,
    required this.hintText,
    required this.svgIconPath, // ← SVG icon path
    this.isRequired = false,
    this.enabled = true,
    this.controller, 
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      validator: isRequired
          ? (value) {
              if (value == null || value.isEmpty) {
                return 'Field ini tidak boleh kosong';
              }
              return null;
            }
          : null,
          
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: secondary100,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),

        // ⬅️ Icon kiri (SVG)
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SvgPicture.asset(
            svgIconPath,
            width: 24,
            height: 24,
            fit: BoxFit.contain,
            color: primary500,
          ),
        ),

        // ➡️ Icon kanan (edit)
        suffixIcon: Icon(Icons.edit, color: text300,),
      ),
    );
  }
}
