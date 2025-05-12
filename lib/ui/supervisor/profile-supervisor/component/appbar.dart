import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  const Appbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios , 
          color: Colors.black
        ),
        onPressed: () {},
      ),
      title: Text(
        "Profile",
        style: TextStyle(
          fontSize: heading3,
          fontWeight: FontWeight.w700
        ),
      ),
    );
  }
}