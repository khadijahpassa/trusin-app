import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/controllers/product_controller.dart';
import 'package:trusin_app/models/product_model.dart';

class EditProduct extends StatefulWidget {
  final ProductModel product;
  final String quotationId;  // Tambahkan ini

  const EditProduct({super.key, required this.product, required this.quotationId});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final _nameController = TextEditingController();
  final _descProductController = TextEditingController();
  final _qtyController = TextEditingController();
  final _priceController = TextEditingController();
  final _discountController = TextEditingController();

  final controller = Get.find<ProductController>();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.product.name;
    _descProductController.text = widget.product.descProduct;
    _qtyController.text = widget.product.quantity.toString();
    _priceController.text = widget.product.price.toString();
    _discountController.text = widget.product.discount.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Produk")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField("Nama Produk", _nameController),
            _buildTextField("Deskripsi Produk", _descProductController),
            _buildTextField("Quantity", _qtyController),
            _buildTextField("Harga", _priceController),
            _buildTextField("Diskon", _discountController),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primary400,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 25),
              ),
              onPressed: () async {
                final name = _nameController.text.trim();
                final desc = _descProductController.text.trim();
                final qty = int.tryParse(_qtyController.text) ?? 0;
                final price = int.tryParse(_priceController.text) ?? 0;
                final discount = int.tryParse(_discountController.text) ?? 0;

                if (name.isNotEmpty && qty > 0 && price > 0) {
                  final updatedProduct = ProductModel(
                    id: widget.product.id,
                    name: name,
                    descProduct: desc,
                    quantity: qty,
                    price: price,
                    discount: discount,
                    handledBy: widget.quotationId, // <-- pakai ini
                  );
                  await controller.updateProduct(updatedProduct);
                  Get.back();
                } else {
                  Get.snackbar("Error", "Isi semua field dengan benar");
                }
              },
              child: const Text(
                "Simpan Perubahan",
                style: TextStyle(fontSize: heading3, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController c) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: c,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: secondary300,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

