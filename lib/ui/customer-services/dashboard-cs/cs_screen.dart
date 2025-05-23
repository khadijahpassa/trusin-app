import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/ui/customer-services/dashboard-cs/components/data.dart';
import 'package:trusin_app/ui/customer-services/dashboard-cs/components/header.dart';
import 'package:trusin_app/ui/customer-services/dashboard-cs/components/progress_cs.dart';

class DashboardCsScreen extends StatelessWidget {
 const DashboardCsScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondary100,
      body: Padding(
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
    );
  }
}