import 'package:flutter/material.dart';

class PodiumWidget extends StatelessWidget {
  final String image;
  final String name;
  final String wonText;
  final String rank;
  final double podiumHeight;
  final Color podiumColor;

  const PodiumWidget({
    super.key,
    required this.image,
    required this.name,
    required this.wonText,
    required this.rank,
    required this.podiumHeight, 
    required this.podiumColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Avatar
        CircleAvatar(
          radius: 28,
          backgroundImage: AssetImage(image),
        ),
        const SizedBox(height: 8),
        // Name
        Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        // Won badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFD5F3DD),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            wonText,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Podium
        Container(
          height: podiumHeight,
          width: 100,
          decoration: BoxDecoration(
            color: podiumColor,
            borderRadius: BorderRadius.circular(16),
          ),
          alignment: Alignment.center,
          child: Text(
            rank,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
