import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  const Appbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(70);

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
        "Detail",
        style: TextStyle(
          fontSize: heading3,
          fontWeight: FontWeight.w700
        ),
      ),
    );
  }
}
