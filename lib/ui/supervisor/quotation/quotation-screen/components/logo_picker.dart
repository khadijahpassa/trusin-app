import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:trusin_app/const.dart';
import 'package:trusin_app/controllers/quotation_controller.dart';

class LogoPicker extends StatelessWidget {
  final QuotationController controller = Get.find();
  final RxnString logoErrorText; 

  LogoPicker({super.key, required this.logoErrorText});

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      controller.logoImage.value = File(image.path);
      logoErrorText.value = null; 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final image = controller.logoImage.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DottedBorder(
            color: primary200,
            strokeWidth: 2,
            dashPattern: [8, 6],
            borderType: BorderType.RRect,
            radius: const Radius.circular(12),
            child: Container(
              width: double.infinity,
              height: 150,
              alignment: Alignment.center,
              child: image == null
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/input-img.svg',
                          fit: BoxFit.contain,
                          height: 30,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Upload Gambar Logo Perusahaan",
                          style: TextStyle(
                            color: primary200,
                            fontSize: body,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: _pickImage,
                          style: TextButton.styleFrom(
                            backgroundColor: primary400,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            "Pilih Dari File Kamu",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: body,
                            ),
                          ),
                        )
                      ],
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.file(
                          image,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          path.basename(image.path),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          if (logoErrorText.value != null)
            Padding(
              padding: const EdgeInsets.only(top: 6, left: 4),
              child: Text(
                logoErrorText.value!,
                style: const TextStyle(color: error500, fontSize: 12),
              ),
            ),
        ],
      );
    });
  }
}

