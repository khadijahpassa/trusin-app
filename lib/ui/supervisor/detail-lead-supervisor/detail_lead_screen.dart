import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/controllers/lead_list_controller.dart';
import 'package:trusin_app/model/lead_list_model.dart';
import 'package:trusin_app/ui/supervisor/detail-lead-supervisor/components/activity_list.dart';
import 'package:trusin_app/ui/supervisor/detail-lead-supervisor/components/app_bar.dart';
import 'package:trusin_app/ui/supervisor/detail-lead-supervisor/components/date.dart';
import 'package:trusin_app/ui/supervisor/detail-lead-supervisor/components/info_lead.dart';
import 'package:trusin_app/ui/supervisor/detail-lead-supervisor/components/profile_lead.dart';
import 'package:trusin_app/ui/supervisor/detail-lead-supervisor/components/tab_table.dart';

class DetailLeadScreen extends StatefulWidget {
  final LeadListController leadListController = Get.find();
   DetailLeadScreen({super.key});

  @override
  State<DetailLeadScreen> createState() => _DetailLeadScreenState();
}

class _DetailLeadScreenState extends State<DetailLeadScreen> {

  @override
  Widget build(BuildContext context) {
    final LeadModel lead = Get.arguments as LeadModel;
    return Scaffold(
      appBar: Appbar(),
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
                 lead.title,
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
                  ProfileLead(leadId: lead.id),
                  SizedBox(width: 5),
                  SizedBox(
                    width: 170,
                    child: Date(leadId: lead.id),
                  )
                ],
              ),
              SizedBox(height: 30),
              InfoLead(lead: lead),
              SizedBox(height: 25),
              TabTable(),
              SizedBox(height: 25),
              ActivityList()
            ],
          ),
        ),
      ),
    );
  }
}
