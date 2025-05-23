import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/models/lead_list_model.dart';

class InfoLead extends StatelessWidget implements PreferredSizeWidget {
  final LeadModel lead;
  const InfoLead({super.key, required this.lead});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children:[
            Expanded(
              child: InfoItem(
                label: "Nomor Telepon",
                content: lead.phone
              ),
            ),
            Expanded(
              child: InfoItem(
                label: "Sumber",
                content:  lead.source
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
                content: lead.email
              ),
            ),
            Expanded(
              child: InfoItem(
                label: "Dibuat Pada",
                content: DateFormat('dd / MMM / yyyy').format(lead.createdOn),
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
                content: lead.address
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
