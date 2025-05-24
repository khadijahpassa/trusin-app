import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    scrolledUnderElevation: 0,
    elevation: 0,
    title: const Text(
      'Rank Customer Service',
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    ),
    centerTitle: true,
  );
}