import 'package:flutter/material.dart';

Future<void> showDeleteConfirmationDialog(
  BuildContext context,
  VoidCallback onDelete,
) async {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: const EdgeInsets.all(24),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/delete-popup.png', // Ganti sesuai path gambarmu
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
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Batal
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // ✅ Tutup popup
                },
                child: const Text(
                  "Batal deh",
                  style: TextStyle(color: Colors.blue),
                ),
              ),

              // Hapus
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // ✅ Tutup popup dulu
                  onDelete(); // ✅ Lanjut hapus
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("Hapus"),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
