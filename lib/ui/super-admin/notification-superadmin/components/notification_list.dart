import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/ui/super-admin/notification-superadmin/components/notification_card.dart';

class NotificationList extends StatelessWidget {
  const NotificationList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: defaultPadding,
          horizontal: 10
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NotifikasiCard(
              title: 'Verifikasi Baru 🚀',
              subtitle: 'Ada 5 perusahaan baru menunggu verifikasi.',
              dateTime: 'Feb 18, 01:00 PM',
            ),
            SizedBox(height: defaultPadding),
            NotifikasiCard(
              title: 'Permintaan Verifikasi',
              subtitle: 'PT. Indotex meminta persetujuan',
              dateTime: 'Feb 18, 01:00 PM',
            ),
          ],
        ),
      ),
    );
  }
}