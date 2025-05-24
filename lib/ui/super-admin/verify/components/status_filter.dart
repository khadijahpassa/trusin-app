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
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: selected.map((status) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: lightBlue,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => controller.selectedStatuses.remove(status),
                    icon: const Icon(Icons.close_rounded,
                        size: 20, color: primary500),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(), // Ini juga penting biar gak nge-force ukuran
                  ),
                  SizedBox(width: 3),
                  Text(
                    status.capitalizeFirst!,
                    style: TextStyle(
                        fontSize: body,
                        color: primary500,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          }).toList());
    });
  }
}
