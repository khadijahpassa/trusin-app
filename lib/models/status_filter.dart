import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trusin_app/controllers/verify_controller.dart';

void showStatusFilterBottomSheet(BuildContext context, VerifyController controller) {
  showModalBottomSheet(
    context: context, 
    builder: (_) {
      return Obx(() {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: ['pending', 'tolak'].map((status) {
            return CheckboxListTile(
              title: Text(status.capitalizeFirst!),
              value: controller.selectedStatuses.containsKey(status), 
              onChanged: (value) {
                if (value == true) {
                  controller.selectedStatuses[status] == status;
                } else {
                  controller.selectedStatuses.remove(status);
                }
              }
            );
          }).toList()
        );
      });
    }
  );
}