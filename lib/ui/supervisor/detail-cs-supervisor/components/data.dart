import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/controllers/lead_list_controller.dart';

class Data extends StatelessWidget implements PreferredSizeWidget {
  final String csId;
  const Data({super.key, required this.csId});

  @override
  Size get preferredSize => const Size.fromHeight(170);

  @override
  Widget build(BuildContext context) {
    final leadController = Get.find<LeadListController>();

    return FutureBuilder<Map<String, int>>(
      future: leadController.getStatusCountByCS(csId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return const Text('Error load data');
        }

        final data = snapshot.data!;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildBox(
                    count: '${data['New Customer'] ?? 0}',
                    label: 'New Customer',
                    color: lightBlue,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildBox(
                    count: '${data['Follow Up'] ?? 0}',
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
                    count: '${data['Send Quotation'] ?? 0}',
                    label: 'Send Quotation',
                    color: secondary600,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildBox(
                    count: '${data['Won'] ?? 0}',
                    label: 'Won',
                    color: success100,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildBox(
                    count: '${data['Rejected'] ?? 0}',
                    label: 'Rejected',
                    color: error100,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildBox({
    required String count,
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
          Text(count,
              style: const TextStyle(
                  fontSize: heading1,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          const SizedBox(height: 4),
          Text(label,
              style: const TextStyle(fontSize: body, color: Colors.black87)),
        ],
      ),
    );
  }
}
