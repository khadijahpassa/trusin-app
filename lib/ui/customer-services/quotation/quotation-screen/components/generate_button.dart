import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/controllers/quotation_controller.dart';
import 'package:trusin_app/controllers/product_controller.dart';
import 'package:trusin_app/ui/customer-services/quotation/quotation-result/result_screen.dart';

class GenerateButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final RxnString logoErrorText;

  GenerateButton({
    required this.formKey,
    required this.logoErrorText,
    super.key,
  });

  final QuotationController controller = Get.find();
  final ProductController productController = Get.find();

  void _handleSubmitQuotation() {
    logoErrorText.value = null;
    final isFormValid = formKey.currentState!.validate();
    final isLogoValid = controller.logoImage.value != null;

    if (!isLogoValid) {
      logoErrorText.value = 'Logo harus dipilih';
    }

    if (isFormValid && isLogoValid) {
      final quotation = controller.getQuotationModel(
        id: controller.currentQuotationId.value,
      );
      controller.submitQuotationToFirebase();

      Get.to(() => ResultScreen(
            quotationId: quotation.id,
            fromCompany: quotation.fromCompany,
            fromPhone: quotation.fromPhone,
            fromSocialMedia: quotation.fromSocialMedia,
            fromAddress: quotation.fromAddress,
            toCompany: quotation.toCompany,
            toSeller: quotation.toSeller,
            toPhone: quotation.toPhone,
            terms: quotation.terms,
            bank: quotation.bank,
            receiver: quotation.receiver,
            rekening: quotation.rekening,
            logo: quotation.logoImagePath != null
                ? File(quotation.logoImagePath!).readAsBytesSync()
                : null,
            selectedDate: quotation.selectedDate,
            products: productController.productList,
          ));
    } else {
      Get.snackbar(
        "Validasi Gagal",
        "Mohon Lengkapi semua data yang diperlukan.",
        backgroundColor: error600,
        colorText: Colors.white,
      );
    }
  }

  void _handleSubmitInvoice() {
    _handleSubmitQuotation();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Generate(
          text: "Generate Quotation",
          onPressed: _handleSubmitQuotation,
        ),
        const SizedBox(width: 12),
        Generate(
          text: "Generate Invoice",
          onPressed: _handleSubmitInvoice,
        ),
      ],
    );
  }
}

class Generate extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const Generate({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: primary400,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
