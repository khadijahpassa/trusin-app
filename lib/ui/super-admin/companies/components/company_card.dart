import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/ui/super-admin/companies/components/detail_button.dart';

class CompanyCardList extends StatelessWidget {
  const CompanyCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 15,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 12, 
                horizontal: 16
              ),
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
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'PT. Indotex',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primary500,
                            ),
                          ),
                          Text(
                            'Nama Supervisor',
                            style: TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ],
                  ),
                  DetailompanyCardButton()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
