import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget{
  const Appbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(53);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'Notification', 
            style: TextStyle(
              fontSize: heading3, 
              color: Colors.black,
              fontWeight: FontWeight.bold
            )
          ),
        ),
    );
  }
}