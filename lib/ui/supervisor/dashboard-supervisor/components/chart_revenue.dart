import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:trusin_app/const.dart';

class ChartRevenue extends StatefulWidget {
  const ChartRevenue({super.key});

  @override
  State<ChartRevenue> createState() => _ChartRevenueState();
}

class _ChartRevenueState extends State<ChartRevenue> {
  String selectedFilter = 'Per-bulan';

  @override
  Widget build(BuildContext context) {
    final List<ChartDataRevenue> data = [
      ChartDataRevenue('Jan', 30),
      ChartDataRevenue('Feb', 42),
      ChartDataRevenue('Mar', 54),
      ChartDataRevenue('Apr', 20),
      ChartDataRevenue('Mei', 76),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Revenue Overview',
              style: TextStyle(
                fontSize: heading3, 
                fontWeight: FontWeight.bold
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: secondary100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade400),
                ),
              child: DropdownButton<String>(
                icon: Icon(Icons.arrow_drop_down),
                underline: SizedBox(), // hapus garis bawah
                value: selectedFilter,
                items: ['Per-bulan', 'Per-tahun', 'Per-minggu', 'Maret', 'April', 'Mei']
                    .map((String value) => DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        ))
                    .toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedFilter = newValue!;
                  });
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        SfCartesianChart( //ini widget utama
          primaryXAxis: CategoryAxis(), //ini ngasih tau bahwa si sumbu x (horizontal)pake kategori, bukan angka (ex. jan, feb)
          tooltipBehavior: TooltipBehavior(enable: true), //tooltip aktif biar klo di hover/tap  chart nya bakal muncul info
          series: <CartesianSeries>[ //ini data disimpen disini, 
            ColumnSeries<ChartDataRevenue, String>( //ColumnSeries itu type chart nya, ada bar, line, pie, dll
              dataSource: data,
              xValueMapper: (ChartDataRevenue data, _) => data.label,
              yValueMapper: (ChartDataRevenue data, _) => data.value,
              dataLabelSettings: const DataLabelSettings(isVisible: true),
              color: primary400,
            )
          ],
        ),
      ],
    );
  }
}

class ChartDataRevenue {
  final String label;
  final int value;

  ChartDataRevenue(this.label, this.value);
}
