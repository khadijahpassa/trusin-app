import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/ui/customer-services/add-lead-cs/components/date.dart';
import 'package:trusin_app/ui/customer-services/add-lead-cs/components/dropdown_status.dart';
import 'package:trusin_app/ui/customer-services/add-lead-cs/components/input_lead.dart';
import 'package:trusin_app/ui/customer-services/add-lead-cs/components/label.dart';
import 'package:intl/intl.dart';

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

  String? selectedStatus;
  final String? currentUid = FirebaseAuth.instance.currentUser?.uid;

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

  DateTime? _parseDateTime(String input) {
    try {
      return DateFormat('dd-MM-yyyy HH:mm').parseStrict(input);
    } catch (e) {
      return null;
    }
  }

  Future<void> _showDateDialog(
    TextEditingController controller, String label) async {
  final result = await showDialog(
    context: context,
    builder: (context) => const Date(),
  );

  if (result != null) {
    final selectedDate = result['selectedDate'] as DateTime;
    final selectedTime = result['selectedTime'] as TimeOfDay;
    final selectedCategory = result['selectedCategory'] as String;

    // Konversi TimeOfDay ke DateTime
    final fullDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    // Format jadi 'dd-MM-yyyy HH:mm'
    final formatted = DateFormat('dd-MM-yyyy HH:mm').format(fullDateTime);

    setState(() {
      controller.text = formatted;
    });

    print('Kategori $label: $selectedCategory');
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
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Nama product wajib diisi' : null,
                  ),
                  LabelForm(label: 'Customer'),
                  LeadTextField(
                    controller: _customerController,
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Nama customer wajib diisi' : null,
                  ),
                  LabelForm(label: 'No Telepon'),
                  LeadTextField(
                    controller: _phoneController,
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        if (!RegExp(r'^\d+$').hasMatch(value)) {
                          return 'Nomor telepon hanya boleh angka';
                        }
                        if (value.length < 10 || value.length > 15) {
                          return 'Nomor telepon harus 10-15 digit';
                        }
                      }
                      return null;
                    },
                  ),
                  LabelForm(label: 'Alamat Email'),
                  LeadTextField(
                    controller: _emailController,
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                          return 'Format email salah';
                        }
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
                    onTap: () => _showDateDialog(_createdOnController, 'dibuat'),
                    child: AbsorbPointer(
                      child: LeadTextField(
                        controller: _createdOnController,
                        validator: (value) =>
                            value == null || value.isEmpty ? 'Tanggal wajib diisi' : null,
                      ),
                    ),
                  ),

                  LabelForm(label: 'Jadwalkan Pengingat'),
                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: () => _showDateDialog(_reminderDateController, 'pengingat'),
                    child: AbsorbPointer(
                      child: LeadTextField(
                        controller: _reminderDateController,
                        validator: (value) => null,
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
                  final csDoc = await FirebaseFirestore.instance
                      .collection('users')
                      .doc(currentUid)
                      .get();

                  final companyName = csDoc.data()?['company'] ?? 'Unknown';

                  final createdOn = _parseDateTime(_createdOnController.text.trim());
                  final reminderDate = _parseDateTime(_reminderDateController.text.trim());

                  if (createdOn == null) {
                    throw Exception('Format tanggal "Dibuat Pada" tidak valid');
                  }

                  await FirebaseFirestore.instance.collection('customers').add({
                    'name': _customerController.text.trim(),
                    'phone': _phoneController.text.trim(),
                    'address': _addressController.text.trim(),
                    'email': _emailController.text.trim(),
                    'source': _sourceController.text.trim(),
                    'createdOn': Timestamp.fromDate(createdOn),
                    'reminderDate':
                        reminderDate != null ? Timestamp.fromDate(reminderDate) : null,
                    'createdBy': currentUid ?? 'Unknown',
                    'companyName': companyName,
                    'status': selectedStatus ?? 'New Customer',
                    'title': _titleController.text.trim(),
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Lead berhasil ditambahkan!')),
                  );

                  _customerController.clear();
                  _phoneController.clear();
                  _emailController.clear();
                  _addressController.clear();
                  _sourceController.clear();
                  _createdOnController.clear();
                  _reminderDateController.clear();
                  _titleController.clear();
                  setState(() {
                    selectedStatus = null;
                  });
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.toString())),
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
