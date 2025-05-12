import 'package:flutter/material.dart';
import 'package:trusin_app/ui/super-admin/dashboard-superadmin/components/statistikcard.dart';

class StatistikComponents extends StatelessWidget {
  const StatistikComponents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2, // jumblah column
        crossAxisSpacing: 12, // jarak antar kotak
        mainAxisSpacing: 12, 
        childAspectRatio: 1.2, // mengatur lebar/tinggi
        children: [
          StatistikCard(
            icon: Image.asset(
              'assets/images/Perusahaan-Terdaftar.png', 
              width: 30,
            ),
            count: 120,
            title: 'Perusahaan Terdaftar',
            color: Colors.blue,
          ),
          StatistikCard(
            icon: Image.asset(
              'assets/images/Perusahaan-Pending.png', 
              width: 30,
            ),
            count: 15,
            title: 'Perusahaan Pending',
            color: Colors.blue,
          ),
          StatistikCard(
            icon: Image.asset(
              'assets/images/Perusahaan-Ditolak.png', 
              width: 30,
            ),
            count: 15,
            title: 'Perusahaan Ditolak',
            color: Colors.blue,
          ),
          StatistikCard(
            icon: Image.asset(
              'assets/images/supervisor-cs.png', 
              width: 30,
            ),
            count: 350,
            title: 'Supervisor & CS',
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
