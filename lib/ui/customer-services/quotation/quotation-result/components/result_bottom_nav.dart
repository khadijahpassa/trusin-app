import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:trusin_app/controllers/quotation_controller.dart';
import 'package:trusin_app/models/product_model.dart';
import 'package:trusin_app/models/quotation_model.dart';
import 'package:trusin_app/ui/customer-services/quotation/quotation-screen/quotation_screen.dart';

class ResultBottomNav extends StatefulWidget {
  final QuotationModel quotation;
  final List<ProductModel> products;
  final GlobalKey previewContainer;

  const ResultBottomNav({
    super.key,
    required this.quotation,
    required this.products,
    required this.previewContainer,
  });

  @override
  State<ResultBottomNav> createState() => _ResultBottomNavState();
}

class _ResultBottomNavState extends State<ResultBottomNav> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuotationController>();

    Widget actionItem({
      required String iconPath,
      required String label,
      required VoidCallback onTap,
    }) {
      return GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              iconPath,
              height: 28,
              width: 28,
              colorFilter:
                  const ColorFilter.mode(Colors.black87, BlendMode.srcIn),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      );
    }

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          actionItem(
            iconPath: 'assets/icons/download_quotation.svg',
            label: 'Unduh',
            onTap: () => controller.downloadQuotationAsPDF(
                widget.previewContainer, widget.quotation),
          ),
          actionItem(
            iconPath: 'assets/icons/share_quotation.svg',
            label: 'Bagikan',
            onTap: () async {
              final imageBytes =
                  await controller.captureImage(widget.previewContainer);
              if (imageBytes != null) {
                final dateStr = widget.quotation.selectedDate != null
                    ? "${widget.quotation.selectedDate!.year}-${widget.quotation.selectedDate!.month.toString().padLeft(2, '0')}-${widget.quotation.selectedDate!.day.toString().padLeft(2, '0')}"
                    : "no_date";
                final fileName =
                    "${widget.quotation.toSeller}_${dateStr}_quotation.pdf"
                        .replaceAll(' ', '_');

                await controller.shareQuotationAsPDF(imageBytes, fileName);
              }
            },
          ),
          actionItem(
            iconPath: 'assets/icons/edit_quotation.svg',
            label: 'Edit',
            onTap: () {
              controller.editQuotation(widget.quotation, widget.products);
              Future.delayed(const Duration(milliseconds: 300), () {
                Get.off(QuotationScreen());
              });
            },
          ),
        ],
      ),
    );
  }
}
