import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:trusin_app/const.dart';

class DateFieldWithStatus extends StatelessWidget {
  final DateTime combinedDateTime;
  final String selectedCategory;
  final void Function()? onTap;

  const DateFieldWithStatus({
    super.key,
    required this.combinedDateTime,
    required this.selectedCategory,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('d MMMM yyyy', 'id_ID').format(combinedDateTime);
    final formattedTime = DateFormat('HH:mm').format(combinedDateTime);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Field tanggal & waktu
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: secondary100,
              border: Border.all(color: text100),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  formattedDate,
                  style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w600,
                    color: text400,
                  ),
                ),
                const SizedBox(width: 12),
                const Icon(Icons.access_time, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  formattedTime,
                  style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w600,
                    color: text400,
                  ),
                ),
                const Spacer(),
                SvgPicture.asset(
                  'assets/icons/dropdown.svg',
                  height: 16,
                  width: 16,
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 8),

        // Baris status / selectedCategory di bawah field
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            selectedCategory,
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
