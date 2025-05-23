import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trusin_app/const.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  const Appbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: secondary100,
      title: Padding(
        padding: const EdgeInsets.only(left: 120),
        child: Text(
          "Semua Customers",
          style: TextStyle(
            fontSize: heading3,
            fontWeight: FontWeight.w700
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 26),
          child: SvgPicture.asset('assets/icons/filter.svg'),
        )
      ],
    );
  }
}