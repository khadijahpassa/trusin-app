import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/ui/super-admin/verify/components/btn_hubungi.dart';
import 'package:trusin_app/ui/super-admin/verify/components/btn_terima.dart';
import 'package:trusin_app/ui/super-admin/verify/components/pending_status.dart';

Card buildRequestCard(BuildContext context) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    margin: EdgeInsets.symmetric(
      horizontal: 16, 
      vertical: defaultPadding/2
    ),
    elevation: 0,
    color: lightBlue,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('PT. Indotex',
                style: TextStyle(
                  fontSize: heading2, 
                  color: primary500,
                  fontWeight: FontWeight.bold
                )
              ),
              Spacer(),
              PendingStatus()
            ],
          ),
          Text(
            'Nama Supervisor',
            style: TextStyle(
              fontSize: descText, 
              color: text400
            ),
          ),
          SizedBox(height: defaultPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Tombol Hubungi
              HubungiButton(),
              // Tombol Terima
              TerimaButton()
            ],
          ),
        ],
      ),
    ),
  );
}
