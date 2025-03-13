import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({super.key, required this.text, required this.image, required this.description,});
  final String text, image, description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        Image.asset(
          image,
          height: 350,
          width: 350,
          fit: BoxFit.contain,
        ),
        Text(
          text,
          style: TextStyle(
            color: primary600,
            fontSize: heading1
            ),
            textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10,),
        SizedBox(
          width: 300, // Sesuaikan dengan lebar maksimal yang diinginkan
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