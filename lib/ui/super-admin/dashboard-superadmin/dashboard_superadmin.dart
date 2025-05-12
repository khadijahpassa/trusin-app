import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/ui/super-admin/dashboard-superadmin/components/appbar.dart';
import 'package:trusin_app/ui/super-admin/dashboard-superadmin/components/bottom_navbar.dart';
import 'package:trusin_app/ui/super-admin/dashboard-superadmin/components/dashboard_card.dart';
import 'package:trusin_app/ui/super-admin/dashboard-superadmin/components/ringkasan_statistik.dart';

class DashboardSuperadmin extends StatelessWidget {
  const DashboardSuperadmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarSuperadmin(),
      body: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RingkasanStatistik(),
            SizedBox(height: defaultPadding),
            Expanded(child: StatistikComponents())
          ],
        ),
      ),
    );
  }
}