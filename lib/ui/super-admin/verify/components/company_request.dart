import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/ui/super-admin/verify/components/request_card.dart';

class CompanyRequest extends StatelessWidget {
  const CompanyRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) => buildRequestCard(context)
    );
  }
}