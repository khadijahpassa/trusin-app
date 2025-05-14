import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/model/company_request.dart';
import 'package:trusin_app/ui/super-admin/companies-detail/companies_detail.dart';

class DetailompanyCardButton extends StatelessWidget {
  final CompanyRequest data;
  const DetailompanyCardButton({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary300, // Warna tombol (solid)
        foregroundColor: Colors.white, // Warna teks/icon
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => CompanyDetailScreen(data: data,))
        );
      },
      child: Text(
        'Detail',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: caption,
        )
      ),
    );
  }
}
    