import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';

class ProfileCs extends StatelessWidget implements PreferredSizeWidget {
  const ProfileCs({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage('assets/images/role_cs.png'),
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hajjah Mecca',
              style: TextStyle(
                fontSize: heading3,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Customer Service', 
              style: TextStyle(
                fontSize: body,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
