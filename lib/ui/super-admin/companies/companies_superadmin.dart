import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/ui/super-admin/companies/components/company_card.dart';

class CompaniesSuperadmin extends StatefulWidget {
  const CompaniesSuperadmin({super.key});

  @override
  State<CompaniesSuperadmin> createState() => _CompaniesSuperadminState();
}

class _CompaniesSuperadminState extends State<CompaniesSuperadmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'Accepted Companies', 
            style: TextStyle(
              fontSize: heading3, 
              color: Colors.black,
              fontWeight: FontWeight.bold
            )
          ),
        ),
      ),
      body: CompanyCardList()
    );
  }
}