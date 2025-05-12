import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/ui/super-admin/companies-detail/companies_detail.dart';

class DetailompanyCardButton extends StatelessWidget {
  const DetailompanyCardButton({super.key});

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
          MaterialPageRoute(builder: (context) => CompanyDetailScreen())
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
    