import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class Progress extends StatefulWidget {
  const Progress({super.key});

  @override
  State<Progress> createState() => _ProgressState();
}

class _ProgressState extends State<Progress> with TickerProviderStateMixin {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Progress CS Hajjah",
          style: TextStyle(
            fontSize: heading3,
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 10),
        TabBar(
          controller: _tabController,
          labelColor: primary400,
          // unselectedLabelColor: Colors.grey,
          indicatorColor: primary400,
          isScrollable: true,
          tabs: status.map((status) => Tab(text: status)).toList(),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: status.map((status) => _CustomerList(status: status)).toList(),
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
    // Ini bagian aslinya pake Firebase
    /*
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('customer')
          .where('status', isEqualTo: status)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('Belum ada data'));
        }

        final docs = snapshot.data!.docs;

        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final data = docs[index];
            final nama = data['nama'] ?? '-';
            final judul = data['judul'] ?? '-';
            final tanggal = data['tanggal'] ?? '-';

            return //... Card seperti di bawah
          },
        );
      },
    );
    */

    // Ganti pake data dummy
    final dummyData = [
      {
        'nama': 'Nenek Alkhansa',
        'judul': 'Rencana pembelian gorden klinik rumah sakit',
        'tanggal': '20 Feb',
      },
      {
        'nama': 'Pak Sugeng',
        'judul': 'Butuh estimasi harga pemasangan teralis',
        'tanggal': '18 Feb',
      },
      {
        'nama': 'Bu Siti',
        'judul': 'Survey lokasi proyek pagar sekolah',
        'tanggal': '15 Feb',
      },
    ];

    return Container(
      color: primary100,
      child: ListView.builder(
        itemCount: dummyData.length,
        itemBuilder: (context, index) {
          final data = dummyData[index];
          final nama = data['nama']!;
          final judul = data['judul']!;
          final tanggal = data['tanggal']!;
      
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/detaillead');
            },
            child: Container(
              margin: const EdgeInsets.only(top: 10, right: 10, left : 10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: secondary100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nama,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    judul,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.yellow.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.hourglass_empty, size: 16, color: Colors.black54),
                        const SizedBox(width: 4),
                        Text(tanggal, style: const TextStyle(color: Colors.black54)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
