import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/ui/general/auth/components/primary_button.dart';
import 'package:trusin_app/ui/general/auth/components/text_field.dart';
import 'package:trusin_app/controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AuthController authController =
        Get.find<AuthController>(); // Registrasi controller

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 40),
                      Text(
                        'Udah Punya Akun? Langsung Masuk Aja!',
                        style: TextStyle(
                          color: primary400,
                          fontSize: heading2,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Login dulu, biar makin sat-set!',
                        style: TextStyle(
                          color: text400,
                          fontSize: body,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 70),
                      TextFieldInput(
                        textEditingController: usernameController,
                        hintText: "Username atau Email",
                        iconPath: "assets/icons/username.svg",
                      ),
                      TextFieldInput(
                        textEditingController: passwordController,
                        hintText: "Kata Sandi",
                        iconPath: "assets/icons/password.svg",
                        isPass: true,
                      ),
                      // Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Get.toNamed('/forgot-password');
                          },
                          child: const Text("Lupa Kata Sandi?",
                              style: TextStyle(color: primary600)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Button dan Daftar
              Obx(() {
                return Column(
                  children: [
                    PrimaryButton(
                      text: authController.authState.value == AuthState.loading
                          ? "Tunggu ya..."
                          : "Masuk",
                      onPressed:
                          authController.authState.value == AuthState.loading
                              ? null
                              : () {
                                  authController.login(
                                    usernameController.text,
                                    passwordController.text,
                                    
                                  );
                                },
                    ),
                    SizedBox(height: defaultPadding),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/register-supervisor');
                      },
                      child: Text.rich(
                        TextSpan(
                          text: "Belum punya akun? ",
                          style:
                              TextStyle(color: primary600, fontSize: descText),
                          children: [
                            TextSpan(
                              text: "Daftar dulu yuk!",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: descText,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }),
              // Navigasi setelah login berhasil
              Obx(() {
                if (authController.authState.value == AuthState.authenticated) {
                  WidgetsBinding.instance.addPostFrameCallback((_) async {
                    await authController.fetchCurrentUserData(); //untuk data itu diambil dan bisa ditampilkan di UI
                    final role = authController.currentRole.value;
                    if (role == 'superadmin') {
                      Get.offAllNamed('/superadmin-home');
                    } else if (role == 'supervisor') {
                      Get.offAllNamed('/supervisor-home');
                    } else {
                      Get.offAllNamed('/cs-home');
                    }
                  });
                }
                return SizedBox.shrink(); // Menunggu navigasi
              }),
            ],
          ),
        ),
      ),
    );
  }
}
