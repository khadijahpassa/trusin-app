import 'package:flutter/material.dart';
import 'package:trusin_app/ui/supervisor/customer-supervisor/components/appbar.dart';
import 'components/customer.dart';
import 'components/customer_card.dart';
import 'components/filter_chips.dart';

class CustomerrCardGridScreen extends StatelessWidget {
  final List<Customer> customers = [
    Customer(
      name: 'Nenek Alkhansa',
      status: 'Won',
      csName: 'CS Hajjah',
      csAvatar: 'assets/images/role_cs.png',
    ),
    Customer(
      name: 'Ariana Granola',
      status: 'Follow Up',
      csName: 'CS Hajjah',
      csAvatar: 'assets/images/role_cs.png',
    ),
    Customer(
      name: 'Paul King',
      status: 'Follow Up',
      csName: 'CS Hajjah',
      csAvatar: 'assets/images/role_cs.png',
    ),
    Customer(
      name: 'Sabrina Carpenter',
      status: 'Won',
      csName: 'CS Nisbar',
      csAvatar: 'assets/images/role_cs.png',
    ),
  ];

  CustomerrCardGridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const FilterChips(),
            const SizedBox(height: 29),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 4 / 5,
                ),
                itemCount: customers.length,
                itemBuilder: (context, index) {
                  return CustomerCard(customer: customers[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}