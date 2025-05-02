import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trusin_app/const.dart';

class Periode extends StatefulWidget {
  const Periode({super.key});

  @override
  _PeriodeState createState() => _PeriodeState();
}

class _PeriodeState extends State<Periode> {
  String? selectedPeriod;

  final List<String> periode = [
    "03 Feb 2025",
    "Bulan Ini",
    "Tahun Ini"
  ];

  @override
  void initState() {
    super.initState();
    // Set default value dengan waktu sekarang (realtime)
    selectedPeriod = DateFormat('dd MMM yyyy').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Data Peluang CS",
          style: TextStyle(fontSize: heading1, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                decoration: BoxDecoration(
                  color: primary300,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 15, color: Colors.white), // Style umum
                    children: [ // Anak-anak teksnya
                      TextSpan(
                        text: "Periode : ",
                        style: TextStyle(fontWeight: FontWeight.bold), // Ini yang di-bold
                      ),
                      TextSpan(
                        text: selectedPeriod //nampilin waktu real time (defaultnya). 
                        // Tidak dikasih style = dia ikut style umum
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 5), 
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: secondary100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: null,
                  hint: Text("Pilih Periode"),
                  icon: Icon(Icons.arrow_drop_down),
                  underline: SizedBox(), // hapus garis bawah
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedPeriod = newValue!;
                    });
                  },
                  items: periode.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
