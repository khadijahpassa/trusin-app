import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';

class RoleCard extends StatelessWidget {
  final String role;
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  const RoleCard({
    Key? key,
    required this.role,
    required this.imagePath,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(.2),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? primary500 : Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.asset(imagePath, width: 120),
            ),
            const SizedBox(height: 8),
            Text(
              role,
              style: const TextStyle(fontSize: descText, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
