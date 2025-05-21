import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/controllers/lead_list_controller.dart';
import 'package:trusin_app/ui/customer-services/add-lead-cs/add_lead_screen.dart';

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
  }
  final leadListController = Get.find<LeadListController>();

  @override
  Widget build(BuildContext context) {
    
     // Ini buat manggil sekali aja setelah widget muncul
    WidgetsBinding.instance.addPostFrameCallback((_) {
      leadListController;
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Peluang CS",
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

class _CustomerList extends StatelessWidget {
  final String status;
  const _CustomerList({required this.status});

  @override
  Widget build(BuildContext context) {
    // Ambil data dari Firestore sesuai dengan status
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('customers')
          .where('status', isEqualTo: status) // filter berdasarkan status
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Terjadi kesalahan'));
        }

        final data = snapshot.data?.docs ?? [];

        return Container(
          color: primary100,
          child: Stack(
            children: [
              ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final customer = data[index];
                  final nama = customer['name'] ?? 'Nama Tidak Tersedia';
                  final judul = customer['title'] ?? 'Judul Tidak Tersedia';
                  final tanggal =
                      customer['createdOn']?.toDate() ?? DateTime.now();
                  final formattedDate =
                      "${tanggal.day}/${tanggal.month}/${tanggal.year}";

                  return GestureDetector(
                    onTap: () {
                      
                      
                    },
                    child: Container(
                      margin:
                          const EdgeInsets.only(top: 10, right: 10, left: 10),
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
                                    style:
                                        const TextStyle(color: Colors.black54)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  color: primary100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 100,
                        height: 30,
                        decoration: BoxDecoration(
                          color: primary300,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
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
                          child: Row(
                            children: [
                              Icon(
                                Icons.add,
                                color: secondary100,
                                size: 20,
                              ),
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
      },
    );
  }
}
