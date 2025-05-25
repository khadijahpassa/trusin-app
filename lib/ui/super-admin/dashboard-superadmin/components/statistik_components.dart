import 'package:flutter/material.dart';
import 'package:trusin_app/service/statistik_service.dart';
import 'package:trusin_app/ui/super-admin/dashboard-superadmin/components/statistikcard.dart';

class StatistikComponents extends StatefulWidget {
  const StatistikComponents({super.key});

  @override
  State<StatistikComponents> createState() => _StatistikComponentsState();
}

class _StatistikComponentsState extends State<StatistikComponents> {
  final service = StatistikService();

  @override
  Widget build(BuildContext context) {
    Stream<int> perusahaanStream(String status) {
      return service.getTotalPerusahaanByStatus(status);
    }

    return GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2, // jumblah column
        crossAxisSpacing: 12, // jarak antar kotak
        mainAxisSpacing: 12, 
        childAspectRatio: 1.2, // mengatur lebar/tinggi
        children: [
          StreamBuilder<int>(
            stream: perusahaanStream('approved'),
            builder: (context, snapshot) {
              final count = snapshot.data ?? 0;
              return StatistikCard(
                icon: Image.asset('assets/images/Perusahaan-Terdaftar.png', width: 30),
                count: count,
                title: 'Perusahaan Terdaftar',
                color: Colors.blue,
              );
            },
          ),
          StreamBuilder<int>(
            stream: perusahaanStream('pending'),
            builder: (context, snapshot) {
              final count = snapshot.data ?? 0;
              return StatistikCard(
                icon: Image.asset('assets/images/Perusahaan-Pending.png', width: 30),
                count: count,
                title: 'Perusahaan Pending',
                color: Colors.blue,
              );
            },
          ),

          StreamBuilder<int>(
            stream: perusahaanStream('rejected'),
            builder: (context, snapshot) {
              final count = snapshot.data ?? 0;
              return StatistikCard(
                icon: Image.asset('assets/images/Perusahaan-Ditolak.png', width: 30),
                count: count,
                title: 'Perusahaan Ditolak',
                color: Colors.blue,
              );
            },
          ),
          StreamBuilder<int>(
            stream: service.getTotalSupervisorAndCS(),
            builder: (context, snapshot) {
              final count = snapshot.data ?? 0;
              return StatistikCard(
                icon: Image.asset('assets/images/supervisor-cs.png', width: 30),
                count: count,
                title: 'Supervisor & CS',
                color: Colors.blue,
              );
            },
          ),
        ],
    );
  }
}
