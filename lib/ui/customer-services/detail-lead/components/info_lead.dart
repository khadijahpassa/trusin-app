import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/models/lead_model.dart';

class InfoLead extends StatelessWidget implements PreferredSizeWidget {
  final LeadModel lead;

  const InfoLead({super.key, required this.lead});

  @override
  Size get preferredSize => const Size.fromHeight(140);

  @override
  Widget build(BuildContext context) {
    final formattedDate = lead.createdOn != null
        ? "${lead.createdOn!.day}/${lead.createdOn!.month}/${lead.createdOn!.year}"
        : 'Tanggal Tidak Tersedia';

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: InfoItem(
                label: "Nomor Telepon",
                content: lead.phone ?? "Tidak tersedia",
              ),
            ),
            Expanded(
              child: InfoItem(
                label: "Sumber",
                content: lead.source ?? "Tidak tersedia",
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: InfoItem(
                label: "Alamat Email",
                content: lead.email ?? "Tidak tersedia",
              ),
            ),
            Expanded(
              child: InfoItem(
                label: "Dibuat Pada",
                content: formattedDate,
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: InfoItem(
                label: "Alamat",
                content: lead.address ?? "Tidak tersedia",
              ),
            ),
          ],
        ),
      ],
    );
  }
}


// Widget reusable buat tiap info (title + content)
class InfoItem extends StatelessWidget {
  final String label;
  final String content;

  const InfoItem({
    super.key,
    required this.label,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label, 
          style: TextStyle(
            fontSize: caption
          )
        ),
        Text(
          content,
          style: TextStyle(
            fontSize: descText,
            fontWeight: FontWeight.w600
          ),
        )
      ],
    );
  }
}