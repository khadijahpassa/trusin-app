import 'package:flutter/material.dart';

class ButtonSubmit extends StatefulWidget {
  
  const ButtonSubmit({super.key});

  @override
  State<ButtonSubmit> createState() => _ButtonSubmitState();
}

class _ButtonSubmitState extends State<ButtonSubmit> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Lebar penuh
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            print('Submit lead sukses!');
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF235FDA), // Warna biru persis
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Radius membulat penuh
          ),
          padding: EdgeInsets.symmetric(vertical: 16), // Tinggi tombol
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        child: const Text(
          'Tambah Lead',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}