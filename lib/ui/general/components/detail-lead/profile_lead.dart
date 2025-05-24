import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/controllers/lead_list_controller.dart';

class ProfileLead extends StatelessWidget implements PreferredSizeWidget {
  final String leadId;

  ProfileLead({super.key, required this.leadId});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LeadListController>();
    controller.streamLeadById(leadId);

    return Obx(() {
      final lead = controller.selectedLead.value;

      if (lead == null) {
        return const Text("Loading...");
      }

      final selectedCategory = lead.reminderCategory ?? 'No Reminder';

      return Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: lightBlue,
            child: SvgPicture.asset(
              'assets/icons/username.svg',
              width: 25,
              height: 25,
            ),
          ),
          const SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                lead.name.length > 10
                    ? lead.name.substring(0, 13) + '..'
                    : lead.name,
                style: TextStyle(
                  fontSize: descText,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Text(
                    '\u2022 ',
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
    });
  }
}
