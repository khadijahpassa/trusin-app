import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/controllers/quotation_controller.dart';

class FromInput extends StatelessWidget {
  FromInput({super.key});
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
            "Dari",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: text400,
            ),
          ),
          const SizedBox(height: 16),
          buildTextField(
            label: "Nama Perusahaan atau Website",
            controller: controller.fromCompany,
            validator: (value) {
              if (value == null || value.isEmpty)
                return 'Nama Perusahaan gak boleh kosong';
              return null;
            },
          ),
          buildTextField(
            label: "Nomor Telepon",
            controller: controller.fromNumber,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty)
                return 'Nomor Telepon gak boleh kosong';
              if (!RegExp(r'^[0-9]+$').hasMatch(value)) return 'Mohon masukan dengan angka';
              return null;
            },
          ),
          buildTextField(
            label: "Username Sosial Media",
            controller: controller.fromSocial,
            validator: (value) {
              if (value == null || value.isEmpty)
                return 'Username gak boleh kosong';
              return null;
            },
          ),
          buildTextField(
            label: "Alamat Perusahaan",
            controller: controller.fromAddress,
            validator: (value) {
              if (value == null || value.isEmpty)
                return 'Alamat gak boleh kosong';
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
            validator: validator,
            keyboardType: keyboardType,
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
                borderSide:
                    const BorderSide(color: text100), // warna saat normal
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                    color: primary400, width: 2), // warna saat aktif
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
