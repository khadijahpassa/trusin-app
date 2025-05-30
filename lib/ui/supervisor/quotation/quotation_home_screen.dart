import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/controllers/product_controller.dart';
import 'package:trusin_app/models/quotation_model.dart';
import 'package:trusin_app/ui/customer-services/quotation/quotation-screen/quotation_screen.dart';

class QuotationSvHomeScreen extends StatelessWidget {
  const QuotationSvHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Get.find<ProductController>();

    return Scaffold(
  appBar: AppBar(
    backgroundColor: Colors.white,
    scrolledUnderElevation: 0,
    automaticallyImplyLeading: false,
    title: Text(
      "Daftar Quotation",
      style: TextStyle(
        fontSize: heading3,
        fontWeight: FontWeight.w700,
      ),
    ),
  ), 
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('quotation').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Belum ada quotation'));
          }

          final quotations = snapshot.data!.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return QuotationModel.fromMap(data);
          }).toList();

          return ListView.builder(
            itemCount: quotations.length,
            itemBuilder: (context, index) {
              final item = quotations[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: secondary200,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        width: 50,
                        height: 55,
                        color: secondary400,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Image.asset(
                            "assets/images/list-img.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      item.toSeller,
                      style: const TextStyle(
                        color: Color(0xFF003399),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      item.toCompany,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      productController.fetchProducts();
                      Get.to(() => QuotationScreen());
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}