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
    .where((e) => e.status == 'pending' || e.status == 'rejected')
    .toList();

      print('✅ Filtered list: ${filteredList.length}');
      for (var item in filteredList) {
        print('📋 ${item.companyName} | ${item.status}');
      }

      if (filteredList.isEmpty) {
        return const Center(child: Text('Tidak ada data'));
      }

      return ListView.builder(
        itemCount: filteredList.length,
        itemBuilder: (context, index) {
          final item = filteredList[index];
          return RequestCard(data: item);
        },
      );
    });
  }
}
