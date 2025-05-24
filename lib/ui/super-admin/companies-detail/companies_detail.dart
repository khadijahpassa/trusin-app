import 'package:flutter/material.dart';
import 'package:trusin_app/models/company_request.dart';
import 'package:trusin_app/ui/supervisor/detail-cs-supervisor/components/app_bar.dart';

class CompanyDetailScreen extends StatelessWidget {
  final CompanyRequest data;
  const CompanyDetailScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              data.companyName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _InfoColumn(
                    title: 'Name',
                    value: data.supervisorName,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _InfoColumn(
                    title: 'Nomor Telepon',
                    value: data.phone,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
                  child: _InfoColumn(
                    title: 'Alamat Email',
                    value: data.email,
                  ),
                ),
          ],
        ),
      ),
    );
  }
}

class _InfoColumn extends StatelessWidget {
  final String title;
  final String value;

  const _InfoColumn({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 12, color: Colors.black87,fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}