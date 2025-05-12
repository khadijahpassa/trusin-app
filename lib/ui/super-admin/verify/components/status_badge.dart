import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: lightBlue,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              Icon(
                Icons.close, 
                color: primary500,
                size: defaultPadding
              ),
              SizedBox(width: 10),
              Text(
                'Pending',
                style: TextStyle(
                  fontSize: descText,
                  color: primary500, 
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: lightBlue,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: const [
              Icon(
                Icons.close, 
                color: primary500,
                size: defaultPadding
              ),
              SizedBox(width: 10),
              Text(
                'Tolak',
                style: TextStyle(
                  fontSize: descText,
                  color: primary500, 
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}