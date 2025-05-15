import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/controllers/verify_controller.dart';

class StatusFilter extends StatelessWidget {
  final controller = Get.find<VerifyController>();
  StatusFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.selectedStatuses.isEmpty) return SizedBox();

      final selected = controller.selectedStatuses.keys.toList();
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: selected.map((status) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: lightBlue,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => controller.selectedStatuses.remove(status), 
                  icon: const Icon(Icons.close, size: 16, color: primary500),
                  constraints: const BoxConstraints(),
                ),
                SizedBox(width: 10),
                Text(
                  status.capitalizeFirst!,
                  style: TextStyle(
                    fontSize: descText,
                    color: primary500,  
                    fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          );
        }).toList()
      );
    });
  }
}