import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/controllers/lead_list_controller.dart';
import 'package:trusin_app/ui/customer-services/add-lead-cs/add_lead_screen.dart';
import 'package:trusin_app/ui/customer-services/detail-lead-cs/detail_lead_screen.dart';

class ProgressCustomerService extends StatefulWidget {
  const ProgressCustomerService({super.key});

  @override
  State<ProgressCustomerService> createState() =>
      _ProgressCustomerServiceState();
}

class _ProgressCustomerServiceState extends State<ProgressCustomerService>
    with TickerProviderStateMixin {
  late TabController _tabController;

  final List<String> status = [
    'New Customer',
    'Follow Up',
    'Send Quotation',
    'Won',
    'Rejected',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: status.length, vsync: this);

    // Panggil init controller SETELAH widget muncul
    WidgetsBinding.instance.addPostFrameCallback((_) {
      leadListController.init(); // ⬅️ panggil di sini
    });
  }

  final leadListController = Get.find<LeadListController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Daftar Leads",
          style: TextStyle(
            fontSize: heading3,
            fontWeight: FontWeight.bold,
          ),
        ),
        TabBar(
          controller: _tabController,
          labelColor: primary400,
          unselectedLabelColor: Colors.grey,
          indicatorColor: primary400,
          isScrollable: true,
          tabs: status.map((status) => Tab(text: status)).toList(),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children:
                status.map((status) => _CustomerList(status: status)).toList(),
          ),
        ),
      ],
    );
  }
}

Widget _buildStatusOption(BuildContext context, lead, String newStatus) {
  return Container(
  decoration: BoxDecoration(
    color: secondary200,
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(20), // ini yang bikin radius di atas doang
    ),
  ),
  child: ListTile(
    title: Text('Pindahkan ke "$newStatus"'),
    onTap: () async {
      Navigator.pop(context);
      final controller = Get.find<LeadListController>();
      await controller.updateStatus(lead.id, newStatus);
    },
  ),
);
}

class _CustomerList extends StatelessWidget {
  final String status;
  const _CustomerList({required this.status});

  @override
  Widget build(BuildContext context) {
    final leadListController = Get.find<LeadListController>();

    return Obx(() {
      if (leadListController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final filteredList = leadListController.leadList
          .where((lead) => lead.status == status)
          .toList();

      return Container(
        color: primary100,
        child: Stack(
          children: [
            filteredList.isEmpty
                ? Center(
                    child: Text("Tidak ada data untuk status $status"),
                  )
                : ListView.builder(
                    itemCount: filteredList.length,
                    padding: const EdgeInsets.only(bottom: 60),
                    itemBuilder: (context, index) {
                      final lead = filteredList[index];
                      final nama = lead.name;
                      final judul = lead.title;
                      final tanggal = lead.createdOn ?? DateTime.now();
                      final formattedDate =
                          "${tanggal.day}/${tanggal.month}/${tanggal.year}";

                      return GestureDetector(
                        onTap: () {
                          Get.to(() => DetailLeadCsScreen(), arguments: lead);
                        },
                        onLongPress: () {
                          final allStatuses = [
                            'New Customer',
                            'Follow Up',
                            'Send Quotation',
                            'Won',
                            'Rejected',
                          ];

                          final availableStatuses = allStatuses
                              .where((s) => s != lead.status)
                              .toList();

                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return SafeArea(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: availableStatuses
                                      .map((status) => _buildStatusOption(
                                          context, lead, status))
                                      .toList(),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                              top: 10, right: 10, left: 10),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: secondary100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                judul,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                nama,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 12),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: warningLight100,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.hourglass_empty,
                                        size: 16, color: Colors.black54),
                                    const SizedBox(width: 4),
                                    Text(formattedDate,
                                        style: const TextStyle(
                                            color: Colors.black54)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

            // Tombol Tambah (selalu muncul)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                color: primary100,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 30,
                      decoration: BoxDecoration(
                        color: primary300,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AddLeadCuseScreen(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          minimumSize: Size.zero,
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.add, color: secondary100, size: 20),
                            const SizedBox(width: 4),
                            Text(
                              "Tambah",
                              style: TextStyle(
                                color: secondary100,
                                fontSize: body,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
