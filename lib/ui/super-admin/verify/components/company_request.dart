import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trusin_app/controllers/verify_controller.dart';
import 'package:trusin_app/ui/super-admin/verify/components/request_card.dart';

class CompanyRequestCard extends StatelessWidget {
  final controller = Get.find<VerifyController>(); // ambil controllernya

  CompanyRequestCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final filteredList = controller.requestList
    .where((e) {
      if (controller.selectedStatuses.isEmpty) return true;
      return controller.selectedStatuses.containsKey(e.status.toLowerCase());
    })
    .toList();

    print('🔍 filteredList: ${filteredList.map((e) => '${e.companyName} (${e.status})').toList()}');

      if (filteredList.isEmpty) {
        return const Center(child: Text('Tidak ada data'));
      }

      return ListView.builder(
        itemCount: filteredList.length,
        itemBuilder: (_, i) {
          final item = filteredList[i];
          return RequestCard(data: item);
        },
      );
    });
  }
}
