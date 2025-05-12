import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';

class TerimaButton extends StatelessWidget {
  const TerimaButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      child: PopupMenuButton<String>(
        onSelected: (value) {
          // Logika pindah halaman
          if (value == 'Terima') {
            Navigator.pushNamed(context, '/setujuPage');
          } else if (value == 'Tolak') {
            Navigator.pushNamed(context, '/revisiPage');
          } 
        },
        color: Colors.white,
        offset: const Offset(0, 60), // biar dropdown muncul di bawah button
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 'Terima',
            child: Text('Terima'),
          ),
          const PopupMenuItem(
            value: 'Tolak',
            child: Text('Tolak'),
          ),
        ],
        child: Container(
          width: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xFF245EDC),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 43,
                  vertical: 12,
                ),
                child: Text(
                  'Terima',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: descText,
                  ),
                ),
              ),
              Container(
                height: 48,
                width: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFF1E4FC0),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}