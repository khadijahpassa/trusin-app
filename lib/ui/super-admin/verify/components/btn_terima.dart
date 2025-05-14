import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/controllers/verify_controller.dart';

class TerimaButton extends StatefulWidget {
  final String requestId;
  const TerimaButton({super.key, required this.requestId});

  @override
  State<TerimaButton> createState() => _TerimaButtonState();
}

class _TerimaButtonState extends State<TerimaButton> {
  final controller = Get.find<VerifyController>();

  // 🔥 SIMPAN INI UNTUK CONVERT STATUS KE LABEL YANG RAMAH USER
  final Map<String, String> statusLabelMap = {
    'approved': 'Terima',
    'rejected': 'Tolak',
  };

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      String? rawStatus = controller.selectedStatuses[widget.requestId];
      String label = rawStatus != null
          ? statusLabelMap[rawStatus] ?? "Pilih"
          : "Pilih";

      return SizedBox(
        width: 139,
        height: 48,
        child: Row(
          children: [
            // Tombol untuk SUBMIT status
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  final selected = controller.selectedStatuses[widget.requestId];
                  if (selected != null) {
                    await controller.submitStatusChange(widget.requestId, selected);
                  } else {
                    Get.snackbar("Gagal", "Belum ada pilihan status.");
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF245EDC),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: descText,
                    ),
                  ),
                ),
              ),
            ),

            // Tombol untuk munculin dropdown
            PopupMenuButton<String>(
              onSelected: (value) {
                final statusMap = {
                  'Terima': 'approved',
                  'Tolak': 'rejected',
                };
                controller.selectedStatuses[widget.requestId] = statusMap[value]!;
              },
              itemBuilder: (context) => const [
                PopupMenuItem(value: 'Terima', child: Text('Terima')),
                PopupMenuItem(value: 'Tolak', child: Text('Tolak')),
              ],
              color: Colors.white,
              offset: const Offset(0, 48),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: Container(
                width: 40,
                height: 48,
                decoration: const BoxDecoration(
                  color: Color(0xFF1E4FC0),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
              ),
            ),
          ],
        ),
      );
    });
  }
}
