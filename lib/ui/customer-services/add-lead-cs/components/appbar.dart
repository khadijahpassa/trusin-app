import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/ui/customer-services/dashboard-cs/cs_screen.dart';

class AppbarCs extends StatelessWidget implements PreferredSizeWidget {
  const AppbarCs({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        forceMaterialTransparency: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios, 
            color: Colors.black
          ),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DashboardCsScreen()));
          },
        ),
        title: Container(
          margin: EdgeInsets.only(left: defaultPadding),
          child: Text(
            "Tambah Lead Baru",
            style: TextStyle(
              fontSize: heading2,
              fontWeight: FontWeight.w700
            ),
          ),
        ),
      ),
    );
  }
}