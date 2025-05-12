import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';

class Data extends StatelessWidget implements PreferredSizeWidget {
  const Data({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
Widget build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Row(
        children: [
          Expanded(
            child: _buildBox(
              count: '16',
              label: 'New Customer',
              color: lightBlue,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _buildBox(
              count: '30',
              label: 'Follow Up',
              color: warningLight100,
            ),
          ),
        ],
      ),
      const SizedBox(height: 10),
      Row(
        children: [
          Expanded(
            child: _buildBox(
              count: '17',
              label: 'Send Quotation',
              color: secondary600,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _buildBox(
              count: '70',
              label: 'Won',
              color: success100,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _buildBox(
              count: '1',
              label: 'Rejected',
              color: error100,
            ),
          ),
        ],
      ),
    ],
  );
}

Widget _buildBox({
  required String count,
  required String label,
  required Color color,
}) {
  return Container(
    height: 80,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          count,
          style: const TextStyle(
            fontSize: heading1,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: body,
            color: Colors.black87,
          ),
        ),
      ],
    ),
  );
}

}

