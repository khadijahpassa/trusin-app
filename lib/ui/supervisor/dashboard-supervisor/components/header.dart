import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/controllers/auth_controller.dart';
import 'package:trusin_app/ui/supervisor/profile-supervisor/profile_screen.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  Header({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(70);
  
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {

    return Container(
      color: secondary100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(left: 5),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: secondary200,
              borderRadius: BorderRadius.circular(10)
            ),
            child: IconButton(
              icon: const Icon(Icons.notifications, color: Colors.black),
              onPressed: () {
                Get.toNamed('/notification');
              },
            ),
          ),
          // User Info
          Obx(() {
            return Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      authController.currentUser.value?.name ?? '' ,
                      style: TextStyle(
                        fontSize: heading3,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      authController.currentUser.value?.role ?? '',
                      style: TextStyle(
                        fontSize: body,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    Get.to(ProfileScreenSupervisor());
                  },
                  child: const CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/images/role_cs.png'),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
