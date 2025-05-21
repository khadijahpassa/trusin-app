import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/models/lead_model.dart';
import 'package:trusin_app/ui/customer-services/detail-lead/components/activity_list.dart';
import 'package:trusin_app/ui/customer-services/detail-lead/components/date.dart';
import 'package:trusin_app/ui/customer-services/detail-lead/components/info_lead.dart';
import 'package:trusin_app/ui/customer-services/detail-lead/components/profile_lead.dart';
import 'package:trusin_app/ui/customer-services/detail-lead/components/tab_table.dart';

class DetailLeadScreen extends StatelessWidget {
  final LeadModel lead;

  DetailLeadScreen({super.key, required this.lead});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(lead.name)),
      backgroundColor: secondary100,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Judul: ${lead.name}",
                  style: TextStyle(
                    fontSize: heading1,
                    fontWeight: FontWeight.bold,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ProfileLead(),
                  SizedBox(width: 5),
                  SizedBox(
                    width: 170,
                    child: Date(),
                  )
                ],
              ),
              SizedBox(height: 30),
              InfoLead(lead: lead),
              SizedBox(height: 25),
              TabTableLead(),
              SizedBox(height: 25),
              ActivityListLead()
            ],
          ),
        ),
      ),
    );
  }
}
