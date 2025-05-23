import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/controllers/quotation_controller.dart';
import 'package:trusin_app/models/product_model.dart';
import 'package:trusin_app/models/quotation_model.dart';
import 'package:trusin_app/ui/customer-services/quotation/quotation-result/components/result_bottom_nav.dart';
import 'package:trusin_app/ui/customer-services/quotation/quotation-result/components/result_footer.dart';
import 'package:trusin_app/ui/customer-services/quotation/quotation-result/components/result_header.dart';
import 'package:trusin_app/ui/customer-services/quotation/quotation-result/components/result_table.dart';
import 'package:trusin_app/ui/customer-services/quotation/quotation_home_screen.dart';

class ResultScreen extends StatefulWidget {
  final String quotationId;
  final String fromCompany;
  final String fromPhone;
  final String fromSocialMedia;
  final String fromAddress;
  final String toCompany;
  final String toSeller;
  final String toPhone;
  final String terms;
  final String bank;
  final String receiver;
  final String rekening;
  final Uint8List? logo;
  final DateTime? selectedDate;
  final List<ProductModel> products;

  const ResultScreen({
    super.key,
    required this.quotationId,
    required this.fromCompany,
    required this.fromPhone,
    required this.fromSocialMedia,
    required this.fromAddress,
    required this.toCompany,
    required this.toSeller,
    required this.toPhone,
    required this.terms,
    required this.bank,
    required this.receiver,
    required this.rekening,
    required this.products,
    this.logo,
    this.selectedDate,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final controller = Get.find<QuotationController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: Text(
            "Quotation Preview",
            style: TextStyle(fontSize: heading3, fontWeight: FontWeight.w700),
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => QuotationHomeScreen()),
                (Route<dynamic> route) =>
                    false, 
              );
            },
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: RepaintBoundary(
                  key: controller.previewContainerKey,
                  child: Container(
                    color: Colors.white, // Container putih
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ResultHeader(
                          logo: widget.logo,
                          fromCompany: widget.fromCompany,
                          fromAddress: widget.fromAddress,
                          fromPhone: widget.fromPhone,
                          fromSocialMedia: widget.fromSocialMedia,
                          selectedDate: widget.selectedDate,
                          toSeller: widget.toSeller,
                        ),
                        const SizedBox(height: 24),
                        ResultTable(products: widget.products),
                        const SizedBox(height: 24),
                        ResultFooter(
                          products: widget.products,
                          terms: widget.terms,
                          bank: widget.bank,
                          receiver: widget.receiver,
                          rekening: widget.rekening,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            ResultBottomNav(
              quotation: QuotationModel(
                id: widget.quotationId,
                fromCompany: widget.fromCompany,
                fromPhone: widget.fromPhone,
                fromSocialMedia: widget.fromSocialMedia,
                fromAddress: widget.fromAddress,
                toCompany: widget.toCompany,
                toSeller: widget.toSeller,
                toPhone: widget.toPhone,
                terms: widget.terms,
                bank: widget.bank,
                receiver: widget.receiver,
                rekening: widget.rekening,
                logoImagePath: null,
                selectedDate: widget.selectedDate,
              ),
              products: widget.products,
              previewContainer: controller.previewContainerKey,
            )
          ],
        ),
      ),
    );
  }
}