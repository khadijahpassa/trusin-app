import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trusin_app/const.dart';

class HubungiButton extends StatelessWidget {
  const HubungiButton({super.key});

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
      onPressed: () {},
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
