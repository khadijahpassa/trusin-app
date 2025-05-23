import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';

class RankCard extends StatelessWidget {
  const RankCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: primary100,
        borderRadius: BorderRadius.vertical(top: Radius.circular(34)),
      ),
      child: ListView(
        padding: const EdgeInsets.only(top: 27, left: 16, right: 16),
        children: [
          _buildCustomerItem(
            number: '04',
            name: 'Nisbar Membara',
            detail: '10 New Customer | 7 Won',
            csavatar: 'assets/images/customer_service.png',
          ),
          const SizedBox(height: 8),
          _buildCustomerItem(
            number: '05',
            name: 'Bani Baihaqi',
            detail: '8 New Customer | 7 Won',
            csavatar: 'assets/images/customer_service.png',
          ),
          const SizedBox(height: 8),
          _buildCustomerItem(
            number: '06',
            name: 'Putri Cantika',
            detail: '8 New Customer | 6 Won',
            csavatar: 'assets/images/customer_service.png',
          ),
          const SizedBox(height: 8),
          _buildCustomerItem(
            number: '07',
            name: 'Abu Marcelo',
            detail: '3 New Customer | 3 Won',
            csavatar: 'assets/images/customer_service.png',
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerItem({
    required String number,
    required String name,
    required String detail,
    required String csavatar,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Text(
            number,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: primary500
            ),
          ),
          const SizedBox(width: 12),
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(csavatar.toString()),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  detail,
                  style: const TextStyle(
                    fontSize: 12,
                    color: text500,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primary500,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {},
            child: const Text(
              'Detail',
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
