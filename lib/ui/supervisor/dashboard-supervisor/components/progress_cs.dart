import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/controllers/auth_controller.dart';
import 'package:trusin_app/controllers/cs_list_controller.dart';
import 'package:trusin_app/controllers/lead_list_controller.dart';
import 'package:trusin_app/model/cs_list_model.dart';

class ProgressCS extends StatelessWidget {
  final csData = Get.find<CSListController>();
  final csListController = Get.find<CSListController>();
  final authController = Get.find<AuthController>();
  final leadController = Get.find<LeadListController>();

  ProgressCS({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      csListController;
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Lihat Progress CS',
          style: TextStyle(fontSize: heading2, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Container(
          height: 400,
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
              SizedBox(height: 12),
              Expanded(
                child: Obx(() {
                  if (csData.csList.isEmpty) {
                    return Center(child: Text("Belum Ada CS yang terdaftar"));
                  } else {
                    return ListView.builder(
                      itemCount: csData.filteredCsList.length,
                      itemBuilder: (context, index) {
                        final cs = csData.filteredCsList[index];
                        return FutureBuilder<Map<String, int>>(
                          future: leadController.getStatusCountByCS(cs.id),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                  child: CircularProgressIndicator());
                            }
                            if (snapshot.hasError || !snapshot.hasData) {
                              return _buildCSCard(
                                  context, cs, "Gagal load data", "ini avatar");
                            }

                            final data = snapshot.data!;
                            final newCount = data['New Customer'] ?? 0;
                            final wonCount = data['Won'] ?? 0;
                            final statusInfo =
                                "$newCount New Customer | $wonCount Won";

                            return _buildCSCard(
                                context, cs, statusInfo, "ini avatar");
                          },
                        );
                      },
                    );
                  }
                }),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCSCard(
      BuildContext context, CSModel cs, String status, String avatar) {
    return Card(
      color: secondary100,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(
              avatar.isNotEmpty ? avatar : 'assets/images/role_cs.png'),
        ),
        title: Text(cs.name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(status, style: TextStyle(fontSize: caption),),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: primary400,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6))),
          onPressed: () {
            final csController = Get.find<CSListController>();
            csController.selectedCS.value = cs;
            Get.toNamed('/detail-cs');
          },
          child: Text(
            'Detail',
            style: TextStyle(color: secondary100, fontSize: body),
          ),
        ),
      ),
    );
  }
}
