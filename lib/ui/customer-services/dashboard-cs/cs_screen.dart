import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/controllers/auth_controller.dart';
import 'package:trusin_app/controllers/lead_list_controller.dart';
import 'package:trusin_app/models/user_model.dart';
import 'package:trusin_app/ui/customer-services/dashboard-cs/components/data.dart';
import 'package:trusin_app/ui/customer-services/dashboard-cs/components/header.dart';
import 'package:trusin_app/ui/customer-services/dashboard-cs/components/progress_cs.dart';

class DashboardCsScreen extends StatefulWidget {
  const DashboardCsScreen({super.key});

  @override
  State<DashboardCsScreen> createState() => _DashboardCsScreenState();
}

class _DashboardCsScreenState extends State<DashboardCsScreen> {
  @override
  void initState() {
    super.initState();

    final authController = Get.find<AuthController>();

    // Tunggu sampai currentUser ada isinya (data sudah loaded)
    ever(authController.currentUser, (UserModel? user) {
      if (user != null) {
        final csId = user.id;
        if (csId.isNotEmpty) {
          Get.find<LeadListController>().scheduleRemindersForCS(csId);
        }
      }
    });

    // Kalau belum pernah fetch, trigger fetch sekarang
    if (authController.currentUser.value == null) {
      authController.fetchCurrentUserData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondary100,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Header(),
              Row(
                children: [
                  Text(
                    "Beranda",
                    style: TextStyle(
                      fontSize: heading1,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              Data(),
              SizedBox(height: 35),
              Expanded(
                child: ProgressCustomerService()
              )
            ],
          ),
        ),
      ),
    );
  }
}
