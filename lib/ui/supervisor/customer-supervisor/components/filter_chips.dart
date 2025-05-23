import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';

class FilterChips extends StatelessWidget {
  const FilterChips({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        Chip(
          backgroundColor: primary100,
          label: Text(
            'Follow Up',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: primary500
            ),
          ),
          avatar: Icon(
            Icons.close_rounded, 
            size: 15, 
            color: primary500
          ),
          side: BorderSide.none,
        ),
        Chip(
          backgroundColor: primary100,
          label: Text(
            'Won',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: primary500
            ),
          ),
          avatar: Icon(
            Icons.close_rounded, 
            size: 15, 
            color: primary500,
          ),
          side: BorderSide.none,
        ),
      ],
    );
  }
}