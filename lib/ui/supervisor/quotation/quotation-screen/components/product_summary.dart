import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trusin_app/controllers/product_controller.dart';

class ProductSummary extends StatelessWidget {
  final ProductController productController = Get.find<ProductController>();

  ProductSummary({super.key});

  String formatCurrency(int value) {
    return value.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final totalQuantity =
          productController.getTotalQuantity(productController.productList);
      final totalPrice =
          productController.getTotalPrice(productController.productList);

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Jumlah produk:", style: TextStyle(fontSize: 16)),
                Text('$totalQuantity', style: const TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total harga:", style: TextStyle(fontSize: 16)),
                Text(
                  formatCurrency(totalPrice),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      );
    });
  }
}
