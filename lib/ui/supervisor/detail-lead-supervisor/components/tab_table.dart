import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';

class TabTable extends StatelessWidget {
  const TabTable({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TabBar(
              tabs: [
                Tab(text: "Lead Age Audit"),
                Tab(text: "Product for Quotation"),
              ],
              labelColor: primary400,
              indicatorColor: primary400,
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 250,
            child: TabBarView(
              children: [
                _buildTabContent(),
                _buildTabContent(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTableHeader(['Stage', 'Date In', 'Day Out']),
          _buildTableRow(['Follow Up', '18/02/25', '20/02/25']),
          _buildTableRow(['New Customer', '17/02/25', '18/02/25']),
          SizedBox(height: 30),
          _buildTableHeader(['Product', 'Ordered QTY', 'Unit Price']),
          _buildTableRow(['Gorden Polo34', '2pcs', '75,000.00']),
        ],
      ),
    );
  }

  Widget _buildTableHeader(List<String> titles) {
    return Container(
      decoration: BoxDecoration(
        color: primary300,
        borderRadius: BorderRadius.circular(6),
      ),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: titles
            .map(
              (title) => Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildTableRow(List<String> values) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.indigo[50],
        borderRadius: BorderRadius.circular(6),
      ),
      margin: EdgeInsets.only(top: 5),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: values
            .map(
              (value) => Expanded(
                child: Text(
                  value,
                  style: TextStyle(
                    color: text400,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
