import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/controllers/cs_list_controller.dart';
import 'package:trusin_app/controllers/lead_list_controller.dart';
import 'package:trusin_app/models/cs_list_model.dart';
import 'package:trusin_app/models/lead_list_model.dart';
import 'package:trusin_app/ui/supervisor/detail-lead-supervisor/detail_lead_screen.dart';

class ProgressLeads extends StatelessWidget {
  final String csId;
  ProgressLeads({super.key, required this.csId});

  final List<String> statusList = [
    'New Customer',
    'Follow Up',
    'Send Quotation',
    'Won',
    'Rejected',
  ];

  @override
  Widget build(BuildContext context) {
    final CSModel? cs = Get.find<CSListController>().selectedCS.value;
    return DefaultTabController(
      length: statusList.length,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Progress CS ${cs?.name ?? '-'}",
            style: TextStyle(fontSize: heading3, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          TabBar(
            labelColor: primary400,
            indicatorColor: primary400,
            isScrollable: true,
            tabs: statusList.map((status) => Tab(text: status)).toList(),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(color: primary100),
              padding: const EdgeInsets.only(top: 5),
              child: TabBarView(
                children: statusList
                    .map((status) => _CustomerList(status: status, csId: csId))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomerList extends StatelessWidget {
  final String status;
  final String csId;

  const _CustomerList({required this.status, required this.csId});

  @override
  Widget build(BuildContext context) {
    final LeadListController leadController = Get.find();

    return FutureBuilder<List<LeadModel>>(
      future: leadController.getLeadsByStatusAndCS(status, csId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return const Center(child: Text('Error load data'));
        }

        final leads = snapshot.data!;
        if (leads.isEmpty) {
          return const Center(child: Text('Belum ada Leads'));
        }

        return ListView.builder(
          itemCount: leads.length,
          itemBuilder: (context, index) {
            final lead = leads[index];
            return GestureDetector(
              onTap: () async {
                Get.to(() => DetailLeadScreen(), arguments: lead);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: secondary100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lead.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: descText,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      lead.name,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: body,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.yellow.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.hourglass_empty,
                              size: 15, color: Colors.black54),
                          const SizedBox(width: 4),
                          Text(
                            DateFormat('dd MMM').format(lead.reminderDate),
                            style: const TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
