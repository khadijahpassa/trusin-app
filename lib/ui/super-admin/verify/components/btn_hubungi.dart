import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/models/company_request.dart';
import 'package:url_launcher/url_launcher.dart';

class HubungiButton extends StatelessWidget {
  final CompanyRequest data;
  const HubungiButton({super.key, required this.data});

  // fuction private(_)
  void _openWhatsApp(String phoneNumber) async {
    final normalized = phoneNumber.replaceAll(RegExp(r'\D'), ''); // menghapus simbol aneh
    final whatsAppUrl = Uri.parse('https://wa.me/$normalized');
    if (await canLaunchUrl(whatsAppUrl)) {
      await launchUrl(whatsAppUrl, mode: LaunchMode.externalApplication); // externalApplication whatsAppnya langsung
    } else {
      debugPrint('Gagal buka WhatsApp ke $normalized');
    }
  }


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: success100, 
        minimumSize: const Size(180, 48),
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: 23),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () => _openWhatsApp(data.phone),
      child: Row(
        children: [
          Text(
            'Hubungi',
            style: const TextStyle(
              color: success600,
              fontWeight: FontWeight.bold,
              fontSize: descText,
            )
          ),
          SizedBox(width: defaultPadding),
          SvgPicture.asset(
            'assets/icons/whatsapp.svg',
            width: defaultPadding,
          )
        ],
      ),
    );
  }
}
