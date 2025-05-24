import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/controllers/lead_list_controller.dart';
import 'package:trusin_app/models/lead_list_model.dart';
import 'package:trusin_app/ui/general/components/detail-lead/activity_list.dart';
import 'package:trusin_app/ui/general/components/detail-lead/app_bar.dart';
import 'package:trusin_app/ui/general/components/detail-lead/date.dart';
import 'package:trusin_app/ui/general/components/detail-lead/info_lead.dart';
import 'package:trusin_app/ui/general/components/detail-lead/profile_lead.dart';
import 'package:trusin_app/ui/general/components/detail-lead/tab_table.dart';

class DetailLeadSvScreen extends StatefulWidget {
  final LeadListController leadListController = Get.find();
   DetailLeadSvScreen({super.key});

  @override
  State<DetailLeadSvScreen> createState() => _DetailLeadSvScreenState();
}

class _DetailLeadSvScreenState extends State<DetailLeadSvScreen> {

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
                    width: 150,
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
