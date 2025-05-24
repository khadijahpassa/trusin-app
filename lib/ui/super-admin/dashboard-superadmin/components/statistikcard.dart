import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';

class StatistikCard extends StatelessWidget {
  final Widget icon;
  final int count;
  final String title;
  final Color color;

  const StatistikCard({
    super.key,
    required this.icon,
    required this.count,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 183,
      height: 500,
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: lightBlue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 30, 
                height: 30, 
                child: icon
              ), 
              const SizedBox(width: 10),
              Text(
                count.toString(),
                style: const TextStyle(
                  fontSize: heading1,
                  fontWeight: FontWeight.w700,
                  color: Colors.black, // angka hitam
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: descText,
                  fontWeight: FontWeight.w600,
                  color: primary500, 
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
