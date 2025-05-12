import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trusin_app/const.dart';

class PendingStatus extends StatelessWidget {
  const PendingStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding/2, vertical: defaultPadding/3),
      decoration: BoxDecoration(
        color: warningLight100,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/pending.svg',
            width: 18,
            color: warningLight600,
          ),
          SizedBox(width: 5),
          Text(
            'Pending',
            style: TextStyle(
                fontSize: descText,
                color: warningLight600,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
