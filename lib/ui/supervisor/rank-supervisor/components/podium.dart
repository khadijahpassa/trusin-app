import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/ui/supervisor/rank-supervisor/components/podium_widget.dart';

Widget builPodium(BuildContext context) {
  return SizedBox(
    height: 305, // tinggi area podium
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        // Podium 3 - kanan
        Positioned(
          right: 38,
          bottom: 0,
          child: PodiumWidget(
            image: 'assets/images/customer_service.png',
            name: 'Setiawan',
            wonText: '8 Won',
            rank: '3',
            podiumHeight: 119, 
            podiumColor: primary300,
          ),
        ),
        // Podium 2 - kiri
        Positioned(
          left: 28,
          bottom: 0,
          child: PodiumWidget(
            image: 'assets/images/customer_service.png',
            name: 'Agung Gunawan',
            wonText: '10 Won',
            rank: '2',
            podiumHeight: 154, 
            podiumColor: primary300,
          ),
        ),
        // Podium 1 - tengah
        Positioned(
          bottom: 0,
          child: PodiumWidget(
            image: 'assets/images/customer_service.png',
            name: 'Marlinda',
            wonText: '20 Won',
            rank: '1',
            podiumHeight: 184, 
            podiumColor: primary500,
          ),
        ),
      ],
    ),
  );
}
