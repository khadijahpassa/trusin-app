import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/ui/general/auth/components/primary_button.dart';

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    const Text(
                      "Daftar Dulu, Biar Bisa Lanjut!",
                      style: TextStyle(
                        fontSize: heading1,
                        fontWeight: FontWeight.w700,
                        color: primary400,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Pilih peran yang sesuai, mau jadi Supervisor biar bisa mantau atau CS buat ngurusin leads.",
                      style: TextStyle(fontSize: descText, color: text400),
                    ),
                    const SizedBox(height: 50),

                    // Role Selection 
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Supervisor Card
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedRole = "Supervisor";
                            });
                          },
                          child: Container(
                            width: double.infinity, // Biar full width
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(.2),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: selectedRole == "Supervisor" ? primary500 : Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Image.asset("assets/images/role_supervisor.png", width: 160),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  "Supervisor/Manager/Owner",
                                  style: TextStyle(
                                    fontSize: heading2, 
                                    fontWeight: FontWeight.w600
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "atau", 
                          style: TextStyle(
                            fontSize: heading3, 
                            color: text400
                            )
                          ),
                        const SizedBox(height: 16),

                        // Customer Service Card
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedRole = "Customer Service";
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(.2),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: selectedRole == "Customer Service" ? primary500 : Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Image.asset("assets/images/role_cs.png", width: 160),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  "Customer Service",
                                  style: TextStyle(
                                    fontSize: heading2, 
                                    fontWeight: FontWeight.w600
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 70),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Tombol Lanjutkan (tetap di bawah)
            Column(
              children: [
                PrimaryButton(
                  text: 'Lanjutkan', 
                  onPressed: selectedRole == null ? null : (){}
                ),
                SizedBox(height: defaultPadding),
                GestureDetector(
                  onTap: () {
                    // Aksi saat teks diklik
                  },
                  child: const Text.rich(
                    TextSpan(
                      text: "Udah punya akun? ",
                      style: TextStyle(fontSize: heading3, color: primary600),
                      children: [
                        TextSpan(
                          text: "Masuk aja!",
                          style: TextStyle(
                            fontSize: heading3,
                            color: primary600,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ],
        ),
      ),

    );
  }
}
