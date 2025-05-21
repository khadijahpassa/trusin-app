import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/models/company_request.dart';
import 'package:trusin_app/ui/super-admin/companies/components/detail_button.dart';

class CompanyCard extends StatelessWidget {
  final CompanyRequest data;
  const CompanyCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding/2),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: secondary200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/building.svg',
                      color: primary500,
                      width: 30,
                      height: 30,
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.companyName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primary500,
                          ),
                        ),
                        Text(
                          data.supervisorName,
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ],
                ),
                DetailompanyCardButton(data: data),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
