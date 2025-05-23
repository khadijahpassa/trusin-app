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
              'assets/icons/customer.svg',
              width: 30,
              height: 30,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                lead.name,
                style: TextStyle(
                  fontSize: heading3,
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
