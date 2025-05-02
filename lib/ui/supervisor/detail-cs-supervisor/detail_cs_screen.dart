import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/ui/supervisor/detail-cs-supervisor/components/app_bar.dart';
import 'package:trusin_app/ui/supervisor/detail-cs-supervisor/components/data.dart';
import 'package:trusin_app/ui/supervisor/detail-cs-supervisor/components/info_cs.dart';
import 'package:trusin_app/ui/supervisor/detail-cs-supervisor/components/profile_cs.dart';
import 'package:trusin_app/ui/supervisor/detail-cs-supervisor/components/progress_cs.dart';

class DetailCsScreen extends StatefulWidget {
  const DetailCsScreen({super.key});

  @override
  State<DetailCsScreen> createState() => _DetailCsScreenState();
}

class _DetailCsScreenState extends State<DetailCsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(),
      backgroundColor: secondary100,
      body: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "CS Performance",
                  style: TextStyle(
                    fontSize: heading1,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            ProfileCs(),
            SizedBox(height: 25),
            InfoCs(),
            SizedBox(height: 25),
            Data(),
            SizedBox(height: 30),
            Expanded(
              child: Progress()
            )
          ],
        ),
      ),
    );
  }
}