import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/controllers/cs_list_controller.dart';
import 'package:trusin_app/model/cs_list_model.dart';
import 'package:trusin_app/ui/supervisor/detail-cs-supervisor/components/app_bar.dart';
import 'package:trusin_app/ui/supervisor/detail-cs-supervisor/components/data.dart';
import 'package:trusin_app/ui/supervisor/detail-cs-supervisor/components/info_cs.dart';
import 'package:trusin_app/ui/supervisor/detail-cs-supervisor/components/profile_cs.dart';
import 'package:trusin_app/ui/supervisor/detail-cs-supervisor/components/progress_lead.dart';

class DetailCsScreen extends StatefulWidget {
  const DetailCsScreen({super.key});

  @override
  State<DetailCsScreen> createState() => _DetailCsScreenState();
}

class _DetailCsScreenState extends State<DetailCsScreen> {
  @override
  Widget build(BuildContext context) {
    final CSModel? cs = Get.find<CSListController>().selectedCS.value;
    // final cs = Get.arguments;
    if (cs == null) {
      return Scaffold(
        body: Center(child: Text('Data CS tidak ditemukan')),
      );
    }
    final CSModel csModel = cs as CSModel;
    return Scaffold(
      appBar: Appbar(),
      backgroundColor: secondary100,
      body: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "CS Performance",
                  style: TextStyle(
                      fontSize: heading1, fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(height: 20),
            ProfileCs(cs: cs),
            SizedBox(height: 25),
            InfoCs(cs: cs),
            SizedBox(height: 25),
            Data(csId: cs.id),
            SizedBox(height: 30),
            Expanded(
                child: ProgressLeads(
              csId: cs.id,
            ))
          ],
        ),
      ),
    );
  }
}
