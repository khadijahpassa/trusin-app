import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';

class LeadTextField extends StatelessWidget {
  final bool isDate;
  final TextEditingController controller;
  final String? Function(String?)? validator; 

  const LeadTextField({
    super.key,
    this.isDate = false,
    required this.controller,
    this.validator, 
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        readOnly: isDate,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.black,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: primary200, 
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none, 
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: defaultPadding),
        ),  
        validator: validator, // masukin validator ke TextFormField
      ),
    );
  }
}