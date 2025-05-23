import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';
import 'customer.dart';

class CustomerCard extends StatelessWidget {
  final Customer customer;

  const CustomerCard({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    final bool isWon = customer.status == 'Won';
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0x212759CD),
            blurRadius: 12.70,
            offset: Offset(0, 2),
            spreadRadius: 0,
            )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(customer.csAvatar),
            radius: 20,
          ),
          const SizedBox(height: 10),
          Text(
            customer.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.circle,
                color: isWon ? Colors.green : Colors.amber,
                size: 8,
              ),
              const SizedBox(width: 10),
              Text(
                customer.status,
                style: TextStyle(
                  fontSize: 14,
                  color: isWon ? Colors.green : Colors.amber,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Divider(
              color: Color(0xFFD7DFF8),
              thickness: 2,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(customer.csAvatar),
                radius: 15,
              ),
              const SizedBox(width: 8),
              Text(
                customer.csName,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
