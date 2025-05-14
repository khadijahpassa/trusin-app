import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/controllers/verify_controller.dart';
import 'package:trusin_app/ui/super-admin/verify/components/appbar.dart';
import 'package:trusin_app/ui/super-admin/verify/components/company_request.dart';
import 'package:trusin_app/ui/super-admin/verify/components/status_filter.dart';

class VerifySuperadmin extends StatelessWidget {
  VerifySuperadmin({super.key});
  final controller = Get.find<VerifyController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(),
      body: Column(
        children: [
          SizedBox(height: defaultPadding),
          StatusFilter(),
          SizedBox(height: defaultPadding),
          Expanded(child: CompanyRequestCard())
        ]
      ),
    );
  }
} 