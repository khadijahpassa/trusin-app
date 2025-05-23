import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trusin_app/const.dart';

class CustomDropdownField extends StatelessWidget {
  final String label;
  final List<String> items;
  final String? value;
  final void Function(String?) onChanged;

  const CustomDropdownField({
    super.key,
    required this.label,
    required this.items,
    this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      onChanged: onChanged,
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
        contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      ),  
      icon: SvgPicture.asset('assets/icons/dropdown.svg'), 
      dropdownColor: Colors.white, // Warna dropdown saat dibuka
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/role_cs.png'),
                radius: 20,
              ),
              SizedBox(width: defaultPadding),
              Text(item),
            ],
          ),
        );
      }).toList(),
    );
  }
}