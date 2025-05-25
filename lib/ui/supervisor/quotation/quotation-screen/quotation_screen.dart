import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trusin_app/controllers/quotation_controller.dart';
import 'package:trusin_app/controllers/product_controller.dart'; // Import the product controller
import 'package:trusin_app/models/product_model.dart';
import 'package:trusin_app/models/quotation_model.dart';
import 'package:trusin_app/ui/customer-services/quotation/quotation-screen/components/generate_button.dart';
import 'package:trusin_app/ui/customer-services/dashboard-cs/components/bottom_navbar_cs.dart';
import 'package:trusin_app/ui/customer-services/quotation/quotation-screen/components/canban_product.dart';
import 'package:trusin_app/ui/customer-services/quotation/quotation-screen/components/logo_picker.dart';
import 'package:trusin_app/ui/customer-services/quotation/quotation-screen/components/from_input.dart';
import 'package:trusin_app/ui/customer-services/quotation/quotation-screen/components/product_summary.dart';
import 'package:trusin_app/ui/customer-services/quotation/quotation-screen/components/to_input.dart';
import 'package:trusin_app/ui/customer-services/quotation/quotation-screen/components/terms_input.dart';
import 'package:trusin_app/ui/customer-services/quotation/quotation-screen/components/payment_instruction.dart';
import 'package:trusin_app/ui/customer-services/quotation/quotation-screen/components/date_field.dart';

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
  var logoErrorText = RxnString();

  // atau data dari controller
  final String selectedCategory = "Follow Up";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: const Text("Quotation Preview"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => BottomNavbarCS()),
              (Route<dynamic> route) => false,
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => DateFieldWithStatus(
                    combinedDateTime: controller.selectedDateTime.value,
                    onTap: controller.showDateTimePicker,
                  )),
              const SizedBox(height: 20),
              LogoPicker(logoErrorText: logoErrorText),
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
              GenerateButton(
                formKey: _formKey,
                logoErrorText: logoErrorText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
