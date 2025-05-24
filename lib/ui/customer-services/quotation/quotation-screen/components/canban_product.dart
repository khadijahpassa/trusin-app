import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trusin_app/controllers/product_controller.dart';
import 'package:trusin_app/ui/customer-services/quotation/add_product_screen.dart';
import 'package:trusin_app/ui/customer-services/quotation/quotation-screen/components/list_canban_product.dart';
import 'package:trusin_app/ui/customer-services/quotation/edit_product.dart';
import 'package:trusin_app/const.dart';

class ProductList extends StatelessWidget {
  final String quotationId;

  ProductList({Key? key, required this.quotationId}) : super(key: key);

  final controller = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: secondary100, // abu muda
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Product',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: text400,
            ),
          ),
          const SizedBox(height: 16),

          Obx(() {
            return controller.productList.isEmpty
                ? const Text("Belum ada produk ditambahkan.")
                : Column(
                    children: controller.productList.map((product) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: ProductCard(
                          product: product,
                          onEdit: () {
                            // Kirim quotationId juga ke EditProduct
                            Get.to(() => EditProduct(
                              product: product,
                              quotationId: quotationId,
                            ));
                          },
                          onDelete: () {
                            controller.deleteProduct(product.id);
                          },
                        ),
                      );
                    }).toList(),
                  );
          }),

          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: () async {
               await Get.to(() => AddProductScreen(quotationId: quotationId));
                controller.fetchProducts();
              },
              icon: const Icon(Icons.add, color: primary400,),
              label: const Text("Tambah", style: TextStyle(color: primary400),),
              style: ElevatedButton.styleFrom(
                backgroundColor: primary100,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}