import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
          'Verify Super Admin',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold
          )
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
            icon: SvgPicture.asset('assets/icons/filter.svg'
          )
        )
      ],
    );
  }
}
