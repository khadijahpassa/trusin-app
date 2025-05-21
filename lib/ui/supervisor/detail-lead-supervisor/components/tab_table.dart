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
              tabs: const [
                Tab(text: "Lead Age Audit"),
                Tab(text: "Product for Quotation"),
              ],
              labelColor: primary400,
              indicatorColor: primary400,
            ),
          ),
          const SizedBox(height: 10),
          const SizedBox(
            height: 250,
            child: TabBarView(
              children: [
                _LeadAgeAuditTable(),
                _ProductQuotationTable(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LeadAgeAuditTable extends StatelessWidget {
  const _LeadAgeAuditTable();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          TableHeader(['Stage', 'Date In', 'Day Out']),
          TableRowItem(['Won', '26/02/25', '20/02/25']),
          TableRowItem(['Kirim Invoice', '25/02/25', '20/02/25']),
          TableRowItem(['Kirim Invoice', '25/02/25', '20/02/25']),
          TableRowItem(['Kirim Quotation', '20/02/25', '20/02/25']),
          TableRowItem(['Follow Up', '18/02/25', '20/02/25']),
          TableRowItem(['New Customer', '17/02/25', '18/02/25']),
        ],
      ),
    );
  }
}

class _ProductQuotationTable extends StatelessWidget {
  const _ProductQuotationTable();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          TableHeader(['Product', 'Ordered QTY', 'Unit Price']),
          TableRowItem(['Gorden Polo34', '2pcs', '75,000.00']),
        ],
      ),
    );
  }
}

class TableHeader extends StatelessWidget {
  final List<String> titles;
  const TableHeader(this.titles, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: primary300,
        borderRadius: BorderRadius.circular(6),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: titles
            .map(
              (title) => Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
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
}

class TableRowItem extends StatelessWidget {
  final List<String> values;
  const TableRowItem(this.values, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.indigo[50],
        borderRadius: BorderRadius.circular(6),
      ),
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
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
