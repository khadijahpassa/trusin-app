import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/controllers/lead_controller.dart';

class Data extends StatelessWidget {
  const Data({super.key});

  @override
  Widget build(BuildContext context) {
    final LeadController controller = Get.find();

    return Obx(() => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildBox(
                    count: controller.statusCount['New Customer'] ?? 0,
                    label: 'New Customer',
                    color: lightBlue,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildBox(
                    count: controller.statusCount['Follow Up'] ?? 0,
                    label: 'Follow Up',
                    color: warningLight100,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildBox(
                    count: controller.statusCount['Send Quotation'] ?? 0,
                    label: 'Send Quotation',
                    color: secondary600,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildBox(
                    count: controller.statusCount['Won'] ?? 0,
                    label: 'Won',
                    color: success100,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildBox(
                    count: controller.statusCount['Rejected'] ?? 0,
                    label: 'Rejected',
                    color: error100,
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  Widget _buildBox({
    required int count,
    required String label,
    required Color color,
  }) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            count.toString(),
            style: const TextStyle(
              fontSize: heading1,
              fontWeight: FontWeight.bold,
              color: text400,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: body,
              color: text400,
            ),
          ),
        ],
      ),
    );
  }
}
