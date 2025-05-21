import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/ui/customer-services/add-lead-cs/components/dropdown_lead.dart';
import 'package:trusin_app/ui/customer-services/add-lead-cs/components/dropdown_status.dart';
import 'package:trusin_app/ui/customer-services/add-lead-cs/components/input_lead.dart';
import 'package:trusin_app/ui/customer-services/add-lead-cs/components/label.dart';

class AddNewLead extends StatefulWidget {
  const AddNewLead({super.key});

  @override
  State<AddNewLead> createState() => _AddNewLeadState();
}

class _AddNewLeadState extends State<AddNewLead> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _customerController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _sourceController = TextEditingController();
  final TextEditingController _createdOnController = TextEditingController();
  final TextEditingController _reminderDateController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  String? selectedCs;
  String? selectedStatus;

  @override
  void dispose() {
    _customerController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _sourceController.dispose();
    _createdOnController.dispose();
    _reminderDateController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.text = picked.toIso8601String().split('T')[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: primary100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  const SizedBox(height: 14),
                  LabelForm(label: 'Title'),
                  LeadTextField(
                    controller: _titleController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama product wajib diisi';
                      }
                      return null;
                    },
                  ),
                  LabelForm(label: 'Customer'),
                  LeadTextField(
                    controller: _customerController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama customer wajib diisi';
                      }
                      return null;
                    },
                  ),
                  LabelForm(label: 'No Telepon'),
                  LeadTextField(
                    controller: _phoneController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'No Telepon wajib diisi';
                      }
                      if (!RegExp(r'^\d+$').hasMatch(value)) {
                        return 'Nomor telepon hanya boleh angka';
                      }
                      if (value.length < 10 || value.length > 15) {
                        return 'Nomor telepon harus 10-15 digit';
                      }
                      return null;
                    },
                  ),
                  LabelForm(label: 'Alamat Email'),
                  LeadTextField(
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email wajib diisi';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return 'Format email salah';
                      }
                      return null;
                    },
                  ),
                  LabelForm(label: 'Alamat'),
                  LeadTextField(controller: _addressController),
                  LabelForm(label: 'Sumber'),
                  LeadTextField(controller: _sourceController),
                  LabelForm(label: 'Dibuat Pada'),
                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: () => _selectDate(context, _createdOnController),
                    child: AbsorbPointer(
                      child: LeadTextField(
                        controller: _createdOnController,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  LabelForm(label: 'Nama CS'),
                  const SizedBox(height: 5),
                  CustomDropdownField(
                    label: 'Nama CS',
                    items: ['Hajjah Mecca', 'Ustad Burhan', 'Kang Dadang'],
                    value: selectedCs,
                    onChanged: (value) {
                      setState(() {
                        selectedCs = value;
                      });
                    },
                  ),
                  const SizedBox(height: 5),
                  LabelForm(label: 'Jadwalkan Pengingat'),
                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: () => _selectDate(context, _reminderDateController),
                    child: AbsorbPointer(
                      child: LeadTextField(
                        controller: _reminderDateController,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  LabelForm(label: 'Status'),
                  StatusDropdown(
                    initialValue: selectedStatus ?? 'New Customer',
                    onChanged: (value) {
                      setState(() {
                        selectedStatus = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                try {
                  await FirebaseFirestore.instance.collection('customers').add({
                    'name': _customerController.text.trim(),
                    'phone': _phoneController.text.trim(),
                    'address': _addressController.text.trim(),
                    'email': _emailController.text.trim(),
                    'source': _sourceController.text.trim(),
                    'createdOn': _createdOnController.text.isNotEmpty
                        ? Timestamp.fromDate(
                            DateTime.parse(_createdOnController.text.trim()))
                        : Timestamp.now(),
                    'reminderDate': _reminderDateController.text.isNotEmpty
                        ? Timestamp.fromDate(
                            DateTime.parse(_reminderDateController.text.trim()))
                        : null,
                    'createdBy': selectedCs ?? 'Unknown',
                    'status': selectedStatus ?? 'New Customer',
                    'title': _titleController.text.trim(),
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Lead berhasil ditambahkan!')),
                  );

                  // Reset form
                  _customerController.clear();
                  _phoneController.clear();
                  _emailController.clear();
                  _addressController.clear();
                  _sourceController.clear();
                  _createdOnController.clear();
                  _reminderDateController.clear();
                  _titleController.clear();
                  setState(() {
                    selectedCs = null;
                    selectedStatus = null;
                  });
                } catch (e) {
                  String errorMessage = 'Gagal menambahkan lead.';
                  if (e is FirebaseException) {
                    errorMessage = e.message ?? errorMessage;
                  } else {
                    errorMessage = e.toString();
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(errorMessage)),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primary400,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            ),
            child: const Text(
              'Tambah Lead',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
