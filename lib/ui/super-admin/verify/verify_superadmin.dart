import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/ui/super-admin/verify/appbar.dart';
import 'package:trusin_app/ui/super-admin/verify/components/company_request.dart';
import 'package:trusin_app/ui/super-admin/verify/components/status_badge.dart';

class VerifySuperadmin extends StatelessWidget {
  const VerifySuperadmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(),
      body: Column(
        children: [
          SizedBox(height: defaultPadding),
          StatusBadge(),
          SizedBox(height: defaultPadding),
          Expanded(child: CompanyRequest())
        ]
      ),
    );
  }
} 