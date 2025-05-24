import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:trusin_app/const.dart';

class ResultHeader extends StatelessWidget {
  final Uint8List? logo;
  final String fromCompany;
  final String fromAddress;
  final String fromPhone;
  final String fromSocialMedia;
  final DateTime? selectedDate;
  final String toSeller;

  const ResultHeader({
    super.key,
    this.logo,
    required this.fromCompany,
    required this.fromAddress,
    required this.fromPhone,
    required this.fromSocialMedia,
    required this.selectedDate,
    required this.toSeller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (logo != null) Center(child: Image.memory(logo!, height: 60)),
        const SizedBox(height: 12),
        Text(
          fromCompany,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(fromAddress,  style: TextStyle(fontSize: caption)),
        Text("Phone: $fromPhone",  style: TextStyle(fontSize: caption)),
        Text("Social Media: $fromSocialMedia",  style: TextStyle(fontSize: caption)),
        const Divider(height: 32),
        Container(
          color: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(1),
            },
            children: [
              TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      "Date Ordered: ${DateFormat('dd/MM/yyyy HH:mm').format(selectedDate ?? DateTime.now())}",
                      style: const TextStyle(color: Colors.white,  fontSize: caption),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      "Salesperson: $toSeller",
                      style: const TextStyle(color: Colors.white, fontSize: caption),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
