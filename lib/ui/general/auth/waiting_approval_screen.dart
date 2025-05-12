import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/ui/general/auth/components/primary_button.dart';

class WaitingApprovalScreen extends StatelessWidget {
  const WaitingApprovalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 60, bottom: 10, left: 10, right: 10),
                        child: Image.asset('assets/images/waiting_approval.png'),
                      ),
                      SizedBox(height: defaultPadding),
                      Text(
                        'Lagi Dicek Nih!',
                        style: TextStyle(
                          color: primary400,
                          fontSize: heading1,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: defaultPadding),
                      Text(
                        'Admin lagi ngecek pendaftaran kamu. Duduk santai dulu aja 😌',
                        style: TextStyle(
                          color: text400,
                          fontSize: heading3,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  PrimaryButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushReplacementNamed(context, "/login");
                    },
                    text: 'Ke Halaman Login',
                  ),
                ],
              )
            ],
          ),
        )
      ),
    );
  }
}