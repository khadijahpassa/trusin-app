import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';

Future<void> showDeleteConfirmationDialog(
  BuildContext context,
  VoidCallback onDelete,
) async {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: const EdgeInsets.all(24),
      content: Column(
        
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/delete-popup.png', 
            height: 120,
          ),
          const SizedBox(height: 16),
          const Text(
            "Hapus Produk",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            "Kamu yakin ingin menghapus produk ini?\nData yang dihapus gak bisa dibalikin.",
            textAlign: TextAlign.center,
            style: TextStyle(color: text400),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Batal
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); 
                },
                child: const Text(
                  "Batal deh",
                  style: TextStyle(color: text500),
                ),
              ),

              // Hapus
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); 
                  onDelete(); 
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: error400,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Hapus", style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
