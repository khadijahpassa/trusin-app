import 'package:flutter/material.dart';
import 'package:trusin_app/ui/customer-services/add-lead-cs/components/add_new_lead.dart';
import 'package:trusin_app/ui/customer-services/add-lead-cs/components/appbar.dart';

class AddLeadCuseScreen extends StatefulWidget {
  const AddLeadCuseScreen({super.key});

  @override
  State<AddLeadCuseScreen> createState() => _AddLeadCuseScreenState();
}

class _AddLeadCuseScreenState extends State<AddLeadCuseScreen> {
  String selectedStatus = 'New Customer';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCs(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              AddNewLead(),
            ],
          ),
        ),
      ),
    );
  }
}
