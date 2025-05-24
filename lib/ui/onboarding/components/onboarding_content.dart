import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({super.key, required this.text, required this.image, required this.description,});
  final String text, image, description;

  @override
Widget build(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Flexible(
        flex: 3,
        child: Image.asset(
          image,
          fit: BoxFit.contain,
        ),
      ),
      SizedBox(
        width: 270,
        child: Text(
          text,
          style: TextStyle(
            color: primary600,
            fontSize: heading2,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      const SizedBox(height: 30),
      SizedBox(
        width: 300,
        child: Text(
          description,
          style: TextStyle(
            color: Colors.grey,
            fontSize: descText,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ],
  );
}

}
