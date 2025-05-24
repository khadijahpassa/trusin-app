import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/controllers/quotation_controller.dart';

class PaymentInstruction extends StatelessWidget {
   PaymentInstruction({super.key});

  final controller = Get.find<QuotationController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: secondary100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Instruksi Pembayaran",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: text400,
            ),
          ),
          const SizedBox(height: 16),

          buildTextField(
            label: "Bank",
            controller: controller.bank,
            validator: (value) {
              if (value == null || value.isEmpty)
                return 'Bank gak boleh kosong';
              return null;
            },
          ),
          buildTextField(
            label: "A/N",
            controller: controller.receiver,
            validator: (value) {
              if (value == null || value.isEmpty)
                return 'Nama Penerima gak boleh kosong';
              return null;
            },
          ),
          buildTextField(
            label: "No. Rekening",
            controller: controller.rekening,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty)
                return 'Nomor Rekening gak boleh kosong';
              if (!RegExp(r'^[0-9]+$').hasMatch(value)) return 'Isi dengan angka';
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: caption)),
          const SizedBox(height: 6),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            style: const TextStyle(fontSize: body),
            validator: validator,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 3,
                horizontal: 12,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: text100),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: primary400, width: 2),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: text100),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
