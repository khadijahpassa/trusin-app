import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/models/product_model.dart';

class ResultFooter extends StatelessWidget {
  final List<ProductModel> products;
  final String terms;
  final String bank;
  final String receiver;
  final String rekening;

  const ResultFooter({
    super.key,
    required this.products,
    required this.terms,
    required this.bank,
    required this.receiver,
    required this.rekening,
  });

  String formatCurrency(num value) {
    final formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 2);
    return formatter.format(value);
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = products.fold<double>(
      0,
      (sum, item) =>
          sum + ((item.price * item.quantity) * (1 - item.discount / 100)),
    );

    final totalDiscount = products.fold<double>(
      0,
      (sum, item) =>
          sum + ((item.price * item.quantity) * (item.discount / 100)),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Untaxed Amount: ${formatCurrency(totalPrice + totalDiscount)}",
                style: TextStyle(
                  fontSize: caption,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 230, // Atur panjang divider sesuai kebutuhan
                  child: Divider(height: 5),
                ),
              ),
              Text(
                "- Discount: ${formatCurrency(totalDiscount)}",
                style: TextStyle(
                  fontSize: caption,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 230,
                  child: Divider(height: 5),
                ),
              ),
              Text(
                "Total: ${formatCurrency(totalPrice)}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: caption,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text("Payment Terms:",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: caption)),
        Text(terms),
        const SizedBox(height: 8),
        Text("BANK: $bank", style: TextStyle(fontSize: caption)),
        Text("A/N: $receiver",  style: TextStyle(fontSize: caption)),
        Text("No. Rekening: $rekening",  style: TextStyle(fontSize: caption)),
        const SizedBox(height: 24),
        const Divider(),
        const Center(child: Text("Page: 1 / 1")),
      ],
    );
  }
}
