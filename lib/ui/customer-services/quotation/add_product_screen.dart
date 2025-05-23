import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/controllers/product_controller.dart';
import 'package:trusin_app/models/product_model.dart';

class AddProductScreen extends StatelessWidget {
  final _nameController = TextEditingController();
  final _descProductController = TextEditingController();
  final _qtyController = TextEditingController();
  final _priceController = TextEditingController();
  final _dicountController = TextEditingController();

  final controller = Get.find<ProductController>();
  final String quotationId;

  AddProductScreen({Key? key, required this.quotationId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tambah Produk")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField("Nama Product", _nameController),
            const SizedBox(height: 16),
            _buildTextField("Deskripsi Produk", _descProductController),
            const SizedBox(height: 16),
            _buildTextField("Quantity", _qtyController),
            const SizedBox(height: 16),
            _buildTextField("Harga Per Unit", _priceController),
            const SizedBox(height: 16),
            _buildTextField("Diskon (persen)", _dicountController),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final name = _nameController.text.trim();
                final quantity = int.tryParse(_qtyController.text) ?? 0;
                final totalPrice = int.tryParse(_priceController.text) ?? 0;
                final descProduct = _descProductController.text.trim();
                final discount = int.tryParse(_dicountController.text) ?? 0;

                if (name.isNotEmpty && quantity > 0 && totalPrice > 0) {
                  final newProduct = ProductModel(
                    id: '',
                    name: name,
                    quantity: quantity,
                    price: totalPrice,
                    descProduct: descProduct,
                    discount: discount,
                    handledBy: quotationId,
                  );
                  await controller.addProduct(newProduct);
                  Get.back();
                } else {
                  Get.snackbar("Error", "Isi semua field dengan benar");
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primary400,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 22),
              ),
              child: Text(
                "Tambah Produk",
                style: TextStyle(fontSize: heading3, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: caption)),
        SizedBox(
          height: 8,
        ),
        Container(
          decoration: BoxDecoration(
            color: secondary300,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextFormField(
            controller: controller,
            style: const TextStyle(fontSize: caption),
            decoration: InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: primary400, width: 2),
              ),
              contentPadding: const EdgeInsets.all(12),
            ),
          ),
        ),
      ],
    );
  }
}
