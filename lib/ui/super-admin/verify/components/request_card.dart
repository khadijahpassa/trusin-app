import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/models/company_request.dart';
import 'package:trusin_app/ui/super-admin/verify/components/btn_hubungi.dart';
import 'package:trusin_app/ui/super-admin/verify/components/btn_terima.dart';
import 'package:trusin_app/ui/super-admin/verify/components/pending_status.dart';

class RequestCard extends StatelessWidget {
  const RequestCard({super.key, required this.data});

  final CompanyRequest data;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: defaultPadding / 2),
      elevation: 0,
      color: lightBlue,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  data.companyName,
                    style: TextStyle(
                    fontSize: descText,
                    color: primary500,
                    fontWeight: FontWeight.bold
                  )
                ),
                Spacer(),
                PendingStatus(status: data.status), 
              ],
            ),
            Text(
              data.supervisorName,
              style: TextStyle(fontSize: body, color: text400),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Tombol Hubungi
                Expanded(child: HubungiButton(data: data,)),
                SizedBox(width: 10),
                // Tombol Terima
                Expanded(child: TerimaButton(requestId: data.id))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
