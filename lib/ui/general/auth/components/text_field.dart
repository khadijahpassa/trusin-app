import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trusin_app/const.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final String iconPath;

  const TextFieldInput({super.key, required this.textEditingController, this.isPass = false, required this.hintText, required this.iconPath,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        style: TextStyle(
          fontSize: descText
        ),
        obscureText: isPass,
        controller: textEditingController,
        cursorColor: primary500,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: text300,
            fontSize: descText
          ),
          prefixIcon: SvgPicture.asset(
            iconPath,
            width: 3,
            colorFilter: ColorFilter.mode(primary500, BlendMode.srcIn),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: defaultPadding, horizontal: 50),
          border: InputBorder.none,
          filled: true,
          fillColor: secondary200,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: text200),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}