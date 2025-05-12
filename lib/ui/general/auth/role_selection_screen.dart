import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/ui/general/auth/components/primary_button.dart';
import 'package:trusin_app/ui/general/auth/components/role_card.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({Key? key}) : super(key: key);

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  String? selectedRole; // Variabel buat nyimpen peran yang dipilih

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 70),
                      const Text(
                        "Daftar Dulu, Biar Bisa Lanjut!",
                        style: TextStyle(
                          fontSize: heading2,
                          fontWeight: FontWeight.w700,
                          color: primary400,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Pilih peran yang sesuai, mau jadi Supervisor biar bisa mantau atau CS buat ngurusin leads.",
                        style: TextStyle(fontSize: body, color: text400),
                      ),
                      const SizedBox(height: 30),
        
                      // Role Selection 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Supervisor Card
                          RoleCard(
                            imagePath: "assets/images/role_supervisor.png",
                            role: "Supervisor/Manager/Owner",
                            isSelected: selectedRole == "Supervisor",
                            onTap: () {
                              setState(() {
                                selectedRole = "Supervisor";
                              });
                            },
                          ),
        
                          const SizedBox(height: 10),
                          const Text("atau", style: TextStyle(fontSize: descText, color: text400)),
                          const SizedBox(height: 10),
                          
                          // CS Card
                          RoleCard(
                            imagePath: "assets/images/role_cs.png",
                            role: "Daftarkan Customer Service",
                            isSelected: selectedRole == "Customer Service",
                            onTap: () {
                              setState(() {
                                selectedRole = "Customer Service";
                              });
                            },
                          ),
                          SizedBox(height: 40),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
        
              // fixed di bawah
              Column(
                children: [
                  PrimaryButton(
                    text: 'Lanjutkan', 
                    onPressed: selectedRole == null
                      ? null
                      : () {
                          if (selectedRole == "Supervisor") {
                            Get.toNamed('/register-supervisor');
                          } else if (selectedRole == "Customer Service") {
                            Get.toNamed('/register-cs');
                          }
                        },
                  ),
                  SizedBox(height: defaultPadding),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/login');
                    },
                    child: const Text.rich(
                      TextSpan(
                        text: "Udah punya akun? ",
                        style: TextStyle(fontSize: descText, color: primary600),
                        children: [
                          TextSpan(
                            text: "Masuk aja!",
                            style: TextStyle(
                              fontSize: descText,
                              color: primary600,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                ],
              ),
            ],
          ),
        ),
      ),

    );
  }
}
