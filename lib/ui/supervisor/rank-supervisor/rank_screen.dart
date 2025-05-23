import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/ui/supervisor/rank-supervisor/components/appbar.dart';
import 'package:trusin_app/ui/supervisor/rank-supervisor/components/podium.dart';
import 'package:trusin_app/ui/supervisor/rank-supervisor/components/rank_card.dart';

class CSRankScreen extends StatelessWidget {
  const CSRankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: Column(
        children: [
          const SizedBox(height: defaultPadding),
          Expanded(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: builPodium(context)
                ),
                Positioned.fill(
                  top: 300, // ini supaya podium keliatan setengah
                  child: RankCard()
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}