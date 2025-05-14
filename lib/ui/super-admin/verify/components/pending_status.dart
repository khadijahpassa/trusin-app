import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trusin_app/const.dart';

class PendingStatus extends StatelessWidget {
  final String status;

  const PendingStatus({required this.status, super.key});

  @override
  Widget build(BuildContext context) {
    // biar statusnya lowercase semua
    final lowerStatus = status.toLowerCase();

    // Konfigurasi berdasarkan statusnya
    late Color backgroundColor;
    late Color textColor;
    late String iconPath;
    late String label;

    switch (lowerStatus) {
      case 'pending':
        backgroundColor = warningLight100;
        textColor = warningLight600;
        iconPath = 'assets/icons/pending.svg';
        label = 'Pending';
        break;
      case 'rejected':
        backgroundColor = error100;
        textColor = error500;
        iconPath = 'assets/icons/close.svg'; 
        label = 'Tolak';
        break;
      case 'approved':
        backgroundColor = success100;
        textColor = success600;
        iconPath = 'assets/icons/check.svg';
        label = 'Terima';
        break;
      default:
        backgroundColor = Colors.grey[200]!;
        textColor = Colors.grey[600]!;
        iconPath = 'assets/icons/question.svg';
        label = 'Tidak diketahui';
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding / 2,
        vertical: defaultPadding / 3,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            iconPath,
            width: 18,
            color: textColor,
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: descText,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
