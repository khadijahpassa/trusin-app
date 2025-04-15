import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trusin_app/const.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final String iconPath;
  final String? Function(String?)? validator;
  final TextInputType inputType;
  final VoidCallback? onEditingComplete;


  TextFieldInput({
    super.key,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    required this.iconPath,
    this.validator,
    this.inputType = TextInputType.text, 
    this.onEditingComplete, 
  });

  final ValueNotifier<bool> obscureTextNotifier = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: ValueListenableBuilder<bool>(
        valueListenable: obscureTextNotifier,
        // parameter ketiga yang harusnya child ngga kepake, 
        // cukup pake _ sebagai placeholder untuk mengabaikan
        builder: (context, obscureText, _) {
          return TextFormField(
            style: TextStyle(fontSize: body),
            obscureText: isPass ? obscureText : false,
            controller: textEditingController,
            cursorColor: primary500,
            keyboardType: inputType,
            validator: validator, 
            onEditingComplete: onEditingComplete, 
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: text200, 
                fontSize: body
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  iconPath,
                  fit: BoxFit.contain,
                  colorFilter: ColorFilter.mode(primary500, BlendMode.srcIn),
                ),
              ),
              suffixIcon: isPass
                  ? IconButton(
                      icon: Icon(
                        obscureText ? Icons.visibility_off : Icons.visibility,
                        color: text200,
                      ),
                      onPressed: () {
                        obscureTextNotifier.value = !obscureTextNotifier.value;
                      },
                    )
                  : null,
              contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
              border: InputBorder.none,
              filled: true,
              fillColor: secondary200,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: text200),
                borderRadius: BorderRadius.circular(12),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: text200),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        },
      ),
    );
  }
}
