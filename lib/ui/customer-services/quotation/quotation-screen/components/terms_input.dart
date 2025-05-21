import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/controllers/quotation_controller.dart';

class TermsInput extends StatelessWidget {
  TermsInput({super.key});
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
            "Syarat dan Ketentuan",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: text400,
            ),
          ),
          const SizedBox(height: 16),
          Text("Syarat dan Ketentuan",
              style: const TextStyle(fontSize: caption)),
          const SizedBox(height: 6),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty)
                return 'Syarat dan ketentuan gak boleh kosong';
              return null;
            },
            controller: controller.terms,
            style: const TextStyle(fontSize: body),
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
                borderSide: const BorderSide(
                  color: primary400,
                  width: 2,
                ),
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
