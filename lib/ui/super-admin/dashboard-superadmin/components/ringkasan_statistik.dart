import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';

class RingkasanStatistik extends StatelessWidget {
  const RingkasanStatistik({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Ringkasan Statistik",
          style: TextStyle(
            fontSize: heading1, 
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Pantau perkembangan perusahaan & user yang sudah terdaftar.",
          style: TextStyle(
            fontSize: descText,
            fontWeight: FontWeight.w300
          ),
        ),
      ],
    );
  }
}
