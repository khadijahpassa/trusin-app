import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';

class CompanyDetailScreen extends StatelessWidget {
  const CompanyDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondary100,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios , 
            color: Colors.black
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
         title: Text(
          "Detail",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'PT.Indotex',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Expanded(
                  child: _InfoColumn(
                    title: 'Nomor Telepon',
                    value: '045678906789',
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _InfoColumn(
                    title: 'Sumber',
                    value: 'WhatsApp',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Expanded(
                  child: _InfoColumn(
                    title: 'Alamat Email',
                    value: 'yamaha@gacor.com',
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _InfoColumn(
                    title: 'Dibuat Pada',
                    value: '17/02/25',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const _InfoColumn(
              title: 'Alamat',
              value: 'Jonggol, Bogor',
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
          style: const TextStyle(fontSize: 12, color: Colors.black87),
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
