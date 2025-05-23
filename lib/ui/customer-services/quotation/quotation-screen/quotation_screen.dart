import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/controllers/quotation_controller.dart';
import 'package:trusin_app/controllers/product_controller.dart'; // Import the product controller
import 'package:trusin_app/models/product_model.dart';
import 'package:trusin_app/models/quotation_model.dart';
import 'package:trusin_app/ui/customer-services/quotation/quotation-screen/components/appbar.dart';
import 'package:trusin_app/ui/customer-services/quotation/quotation-screen/components/canban_product.dart';
import 'package:trusin_app/ui/customer-services/quotation/quotation-screen/components/logo_picker.dart';
import 'package:trusin_app/ui/customer-services/quotation/quotation-screen/components/from_input.dart';
import 'package:trusin_app/ui/customer-services/quotation/quotation-screen/components/product_summary.dart';
import 'package:trusin_app/ui/customer-services/quotation/quotation-screen/components/to_input.dart';
import 'package:trusin_app/ui/customer-services/quotation/quotation-screen/components/terms_input.dart';
import 'package:trusin_app/ui/customer-services/quotation/quotation-screen/components/payment_instruction.dart';
import 'package:trusin_app/ui/customer-services/quotation/quotation-screen/components/date_field.dart';
import 'package:trusin_app/ui/customer-services/quotation/quotation-result/result_screen.dart';
import 'package:trusin_app/ui/customer-services/quotation/quotation_home_screen.dart';

class QuotationScreen extends StatefulWidget {
  final QuotationModel? quotationData;
  final List<ProductModel>? productList;
  QuotationScreen({super.key, this.quotationData, this.productList});

  @override
  State<QuotationScreen> createState() => _QuotationScreenState();
}

class _QuotationScreenState extends State<QuotationScreen> {
  final QuotationController controller = Get.put(QuotationController());

  final ProductController productController = Get.find();

  var selectedDateTime = Rx<DateTime?>(null);

  // var logoErrorText = Rx<DateTime?>(null);
  var logoErrorText = RxnString();

  // atau data dari controller
  final String selectedCategory = "Follow Up";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Obx(() => DateFieldWithStatus(
                    combinedDateTime: controller.selectedDateTime.value,
                    selectedCategory: controller.selectedCategory.value,
                    onTap: controller.showDateTimePicker,
                  )),

              const SizedBox(height: 20),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LogoPicker(),
                  Obx(() {
                    if (logoErrorText.value != null) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 6, left: 4),
                        child: Text(
                          logoErrorText.value!,
                          style: const TextStyle(color: error500, fontSize: 12),
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  })
                ],
              ),

              const SizedBox(height: 20),

              FromInput(),
              const SizedBox(height: 16),

              ToInput(),
              const SizedBox(height: 16),

              ProductList(quotationId: controller.currentQuotationId.value),
              const SizedBox(height: 16),

              TermsInput(),
              const SizedBox(height: 16),

              PaymentInstruction(),
              const SizedBox(height: 16),

              ProductSummary(),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        logoErrorText.value = null;
                        final isFormValid = _formKey.currentState!.validate();
                        final isLogoValid = controller.logoImage.value != null;
                        final isproductValid =
                            controller.logoImage.value != null;

                        if (!isLogoValid) {
                          logoErrorText.value = 'Logo harus dipilih';
                        }
                        if (isFormValid && isLogoValid) {
                          final quotation = controller.getQuotationModel(
                              id: controller.currentQuotationId.value);
                          controller.submitQuotationToFirebase();

                          // Navigasi ke ResultScreen
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
                                    ? File(quotation.logoImagePath!)
                                        .readAsBytesSync()
                                    : null,
                                selectedDate: quotation.selectedDate,
                                products: productController
                                    .productList, // ⬅️ tambahkan ini
                              ));
                        } else {
                          Get.snackbar(
                            "Validasi Gagal",
                            "Mohon Lengkapi semua data yang diperlukan.",
                            backgroundColor: error600,
                            colorText: Colors.white,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary400,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                        ),
                        child: const Text(
                          "Generate Quotation",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // action invoice
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary400,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: const Text(
                          "Generate Invoice",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
