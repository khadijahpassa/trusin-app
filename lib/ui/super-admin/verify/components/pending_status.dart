import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trusin_app/const.dart';

class PendingStatus extends StatelessWidget {
  final String status;

  const  PendingStatus({required this.status, super.key});

  @override
  Widget build(BuildContext context) {
    // biar statusnya lowercase semua
    final lowerStatus = status.toLowerCase();

    // Konfigurasi berdasarkan statusnya
    late Color backgroundColor;
    late Color textColor;
    late Widget iconWidget;
    late String label;

    if (lowerStatus == 'rejected') {
      backgroundColor = error100;
      textColor = error500;
      iconWidget = const Icon(Icons.close_rounded, color: error500, size: body);
      label = 'Tolak';
    } else {
      backgroundColor = warningLight100;
      textColor = warningLight600;
      iconWidget = SvgPicture.asset('assets/icons/pending.svg', color: warningLight600, width: 18);
      label = 'Pending';
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding / 3,
        vertical: defaultPadding / 3,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          iconWidget,
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: caption,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ]
      ),
    );
  }
}
