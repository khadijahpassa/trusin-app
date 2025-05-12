import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';

class AppbarSuperadmin extends StatelessWidget implements PreferredSizeWidget {
  const AppbarSuperadmin({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(53);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      actions: [
        Text(
          'Admin',
          style: TextStyle(
            fontSize: heading3, 
            fontWeight: FontWeight.bold
          ),
        ),
        IconButton(
          onPressed: () {}, // -> ngarahin ke profile
          icon: Container(
            padding: EdgeInsets.all(defaultPadding),
            height: 57,
            width: 57,
            decoration: BoxDecoration(
              color: primary400,
              shape: BoxShape.circle,
            ),
              child: Image.asset('assets/images/role_supervisor.png')
          )
        )
      ],
    );
  }
}
