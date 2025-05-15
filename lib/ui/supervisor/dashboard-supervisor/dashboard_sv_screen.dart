import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/controllers/auth_controller.dart';
import 'package:trusin_app/ui/supervisor/dashboard-supervisor/components/chart_pipeline_leads.dart';
import 'package:trusin_app/ui/supervisor/dashboard-supervisor/components/chart_revenue.dart';
import 'package:trusin_app/ui/supervisor/dashboard-supervisor/components/header.dart';
import 'package:trusin_app/ui/supervisor/dashboard-supervisor/components/button_add_cs.dart';
import 'package:trusin_app/ui/supervisor/dashboard-supervisor/components/progress_cs.dart';

class DashboardSvScreen extends StatefulWidget {
  const DashboardSvScreen({super.key});

  @override
  State<DashboardSvScreen> createState() => _DashboardSvScreenState();
}

class _DashboardSvScreenState extends State<DashboardSvScreen> {
  @override
  void initState() {
    super.initState();
    final authController = Get.find<AuthController>();
    authController.fetchCurrentUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: Column(children: [
                Header(),
                SizedBox(height: defaultPadding),
                ButtonAddCs(),
                SizedBox(height: defaultPadding),
                ProgressCS(),
                SizedBox(height: defaultPadding),
                ChartRevenue(),
                SizedBox(height: defaultPadding),
                ChartPipelineLeads()
              ])),
        ));
  }
}
