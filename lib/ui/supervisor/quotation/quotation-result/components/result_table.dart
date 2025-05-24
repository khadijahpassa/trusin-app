import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trusin_app/models/product_model.dart';

class ResultTable extends StatelessWidget {
  final List<ProductModel> products;

  const ResultTable({super.key, required this.products});

  String formatCurrency(num value) {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 2);
    return formatter.format(value);
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      columnWidths: const {
        0: FractionColumnWidth(0.10),
        1: FractionColumnWidth(0.20),
        2: FractionColumnWidth(0.12),
        3: FractionColumnWidth(0.21),
        4: FractionColumnWidth(0.12),
        5: FractionColumnWidth(0.25),
      },
      children: [
        TableRow(
          decoration: const BoxDecoration(color: Color(0xFFEFEFEF)),
          children: [
            tableCell("No.", isHeader: true),
            tableCell("Product", isHeader: true),
            tableCell("Qty", isHeader: true),
            tableCell("Unit Price", isHeader: true),
            tableCell("Disc", isHeader: true),
            tableCell("Price", isHeader: true),
          ],
        ),
        ...products.asMap().entries.map((entry) {
          final index = entry.key + 1;
          final item = entry.value;
          final subtotal = item.price * item.quantity;
          final afterDiscount = subtotal * (1 - item.discount / 100);
          return TableRow(
            children: [
              tableCell('$index'),
              tableCell(item.name),
              tableCell('${item.quantity}'),
              tableCell(formatCurrency(item.price)),
              tableCell('${item.discount.toStringAsFixed(1)}%'),
              tableCell(formatCurrency(afterDiscount)),
            ],
          );
        }).toList(),
      ],
    );
  }

  Widget tableCell(String text, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: isHeader ? 8 : 7,
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
