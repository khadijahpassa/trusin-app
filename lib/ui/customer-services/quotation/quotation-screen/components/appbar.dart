import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';

class Appbar extends StatelessWidget {
  const Appbar({super.key});


  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: secondary100,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios , 
          color: Colors.black
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        "Buat Quotation",
        style: TextStyle(
          fontSize: heading3,
          fontWeight: FontWeight.w700
        ),
      ),
    );
    
  }
}