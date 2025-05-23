import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:trusin_app/const.dart';

class ChartPipelineLeads extends StatefulWidget {
  const ChartPipelineLeads({super.key});

  @override
  _ChartPipelineLeadsState createState() => _ChartPipelineLeadsState();
}

class _ChartPipelineLeadsState extends State<ChartPipelineLeads> {
  final List<Color> chartColors = [
    Color(0xFFFBA524),
    Color(0xFF692AE6),
    Color(0xFF3E88F0),
    Color(0xFF2759CD),
    Color(0xFFFFD101),
  ];

  @override
  Widget build(BuildContext context) {
    final List<ChartData> data = [
      ChartData('Send Quotation', 30),
      ChartData('Warm Leads', 42),
      ChartData('Follow Up', 54),
      ChartData('Won', 20),
      ChartData('New Customer', 76),
    ];

    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: primary100,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 150,
              height: 150,
              child: SfCircularChart(
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <CircularSeries>[
                  DoughnutSeries<ChartData, String>(
                    dataSource: data,
                    xValueMapper: (ChartData data, _) => data.label,
                    yValueMapper: (ChartData data, _) => data.value,
                    pointColorMapper: (ChartData data, int index) =>
                        chartColors[index],
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                    innerRadius: '50%',
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: List.generate(data.length, (index) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: chartColors[index],
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text('${data[index].label}: ${data[index].value}', style: TextStyle(fontSize: caption)),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  final String label;
  final int value;

  ChartData(this.label, this.value);
}
