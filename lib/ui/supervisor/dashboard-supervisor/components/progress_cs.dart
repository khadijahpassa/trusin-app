import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/controllers/cs_list_controller.dart';
import 'package:trusin_app/models/cs_list_model.dart';
import 'package:trusin_app/controllers/lead_list_controller.dart';

class ProgressCS extends StatelessWidget {
  final csData = Get.find<CSListController>();
  final csListController = Get.find<CSListController>();
  final leadController = Get.find<LeadListController>();

  ProgressCS({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Lihat Progress CS',
          style: TextStyle(fontSize: heading2, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Container(
          height: 350,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: primary100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              TextField(
                onChanged: (value) => csData.setSearchQuery(value),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Ketik nama CS...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              Expanded(
                child: Obx(() {
                  if (csData.csList.isEmpty) {
                    return Center(child: Text("Belum Ada CS yang terdaftar"));
                  } else {
                    return ListView.builder(
                      itemCount: csData.filteredCsList.length,
                      itemBuilder: (context, index) {
                        final cs = csData.filteredCsList[index];

                        // Hitung status dari list reactive leadController
                        final data = leadController.calculateStatusCount();
                        final newCount = data['New Customer'] ?? 0;
                        final wonCount = data['Won'] ?? 0;
                        final statusInfo =
                            "$newCount New Customer \n$wonCount Won";

                        return _buildCSCard(
                          context,
                          cs,
                          statusInfo,
                          'assets/images/customer_service.png',
                        );
                      },
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCSCard(
    BuildContext context,
    CSModel cs,
    String status,
    String avatar,
  ) {
    return Card(
        color: secondary100,
        child: Padding(
                padding: const EdgeInsets.all(12.0), // padding luar card
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(
                        avatar.isNotEmpty ? avatar : 'assets/images/role_cs.png',
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(cs.name, style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text(status, style: TextStyle(fontSize: caption)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0), // padding khusus tombol
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary400,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8), // padding dalam tombol
                        ),
                        onPressed: () {
                          final csController = Get.find<CSListController>();
                          csController.selectedCS.value = cs;
                          Get.toNamed('/detail-cs');
                        },
                        child: Text(
                          'Detail',
                          style: TextStyle(color: secondary100, fontSize: caption),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
  }
}
