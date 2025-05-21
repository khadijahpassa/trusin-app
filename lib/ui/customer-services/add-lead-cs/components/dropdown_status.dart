import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';

class StatusDropdown extends StatefulWidget {
  final String initialValue;
  final Function(String) onChanged;

  const StatusDropdown({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<StatusDropdown> createState() => _StatusDropdownState();
}

class _StatusDropdownState extends State<StatusDropdown> {
  late String selectedStatus;

  final List<String> statusOptions = [
    'New Customer',
    'Follow Up',
    'Send Quotation',
    'Won',
    'Rejected',
  ];

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedStatus,
      icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.blue),
      decoration: InputDecoration(
          filled: true,
          fillColor: primary200, 
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none, 
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: defaultPadding),
        ), 
      style: const TextStyle(color: primary500, fontWeight: FontWeight.w600),
      dropdownColor: Colors.white,
      items: statusOptions.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {
        if (newValue != null) {
          setState(() => selectedStatus = newValue);
          widget.onChanged(newValue);
        }
      },
    );
  }
}
