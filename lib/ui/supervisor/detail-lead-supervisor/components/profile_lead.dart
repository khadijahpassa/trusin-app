import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/ui/state-management/date_provider.dart';

class ProfileLead extends StatelessWidget implements PreferredSizeWidget {
  
  const ProfileLead({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    final selectedCategory = context.watch<DateProvider>().selectedCategory;

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
              'Nenek Alkhansa',
              style: TextStyle(
                fontSize: heading3,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Text(
                  '\u2022 ', // ini bullet
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
                Text(
                  selectedCategory,
                  style: TextStyle(
                    fontSize: body,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
