import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/controllers/auth_controller.dart';
import 'package:trusin_app/controllers/cs_list_controller.dart';
import 'package:trusin_app/model/cs_list_model.dart';

class ProgressCS extends StatelessWidget {
  ProgressCS({super.key});

  final csListController = Get.find<CSListController>();
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    // final company = authController.currentCompany.value;

    // Ini buat manggil sekali aja setelah widget muncul
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
                  if (csListController.csList.isEmpty) {
                    return Center(child: Text("Belum ada data"));
                  }

                  return ListView.builder(
                    itemCount: csListController.csList.length,
                    itemBuilder: (context, index) {
                      final cs = csListController.csList[index];
                      return _buildCSCard(
                        context,
                        cs,
                        "ii detail",
                        "ini avatar"
                      );
                    },
                  );
                }),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCSCard(
      BuildContext context, CSModel cs, String detail, String avatar) {
    return Card(
      color: secondary100,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: avatar.isNotEmpty
              ? AssetImage(avatar) // Gunakan avatar jika ada
              : AssetImage('assets/images/role_cs.png'),
        ),
        title: Text(cs.name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(detail),
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
