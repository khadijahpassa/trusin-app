import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';

class NotifikasiCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String dateTime;

  const NotifikasiCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 13),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFF1F5FF), // Biru muda
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: descText,
                    color: Color(0xFF1E3A8A), // Biru navy
                  ),
                ),
              ),
              Text(
                dateTime,
                style: TextStyle(
                  fontSize: caption,
                  color: Colors.blueGrey,
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: body,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
