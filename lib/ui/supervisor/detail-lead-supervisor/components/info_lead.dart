import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';

class InfoLead extends StatelessWidget implements PreferredSizeWidget {
  const InfoLead({super.key});

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
                content: "0123456789"
              ),
            ),
            Expanded(
              child: InfoItem(
                label: "Sumber",
                content:  "WhatsApp"
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        Row(
          children: const [
            Expanded(
              child: InfoItem(
                label: "Alamat Email",
                content: "yamaha@gacor.com"
              ),
            ),
            Expanded(
              child: InfoItem(
                label: "Dibuat Pada",
                content: "23/06/25",
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        Row(
          children: const [
            Expanded(
              child: InfoItem(
                label: "Alamat",
                content: "Jonggol, Bogor"
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
