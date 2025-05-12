import 'package:flutter/material.dart';
import 'package:trusin_app/ui/super-admin/notification-superadmin/components/appbar.dart';
import 'package:trusin_app/ui/super-admin/notification-superadmin/components/notification_card.dart';
import 'package:trusin_app/ui/super-admin/notification-superadmin/components/notification_list.dart';

class NotificationSuperadmin extends StatelessWidget {
  const NotificationSuperadmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(),
      body: NotificationList(),
    );
  }
}