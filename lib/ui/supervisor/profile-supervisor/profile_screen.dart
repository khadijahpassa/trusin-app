import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/controllers/auth_controller.dart';
import 'package:trusin_app/ui/supervisor/notification-supervisor/components/appbar.dart';
import 'package:trusin_app/ui/supervisor/profile-supervisor/component/form_input.dart';

class ProfileScreenSupervisor extends StatefulWidget {
  ProfileScreenSupervisor({super.key});

  @override
  State<ProfileScreenSupervisor> createState() => _ProfileScreenSupervisorState();
}

class _ProfileScreenSupervisorState extends State<ProfileScreenSupervisor> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final companyController = TextEditingController();
  final passwordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final AuthController authController = Get.find<AuthController>();
    final user = authController.currentUser.value;

    // Kasih data awal ke textfield
    usernameController.text = user?.name ?? '';
    emailController.text = user?.email ?? '';
    phoneController.text = user?.phone ?? '';
    companyController.text = user?.company ?? '';
    passwordController.text = ''; // kosongin untuk keamanan

    return Scaffold(
      appBar: Appbar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding,
          vertical: 24,
        ),
        child: Column(
          children: [
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    // Header
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(
                            'assets/images/supervisor_avatar.png',
                          ),
                          radius: 40,
                        ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              authController.currentUser.value?.name ?? '',
                              style: TextStyle(
                                fontSize: heading2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(authController.currentUser.value?.role ?? '',
                                style: TextStyle(fontSize: body)),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: defaultPadding),
                    Text(
                      "Personal Information",
                      style: TextStyle(
                        fontSize: heading2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),

                    // Form Fields
                    TextFieldInput(
                        hintText: "Username",
                        svgIconPath: "assets/icons/username.svg",
                        isRequired: true,
                        controller: usernameController),
                    SizedBox(height: 16),
                    TextFieldInput(
                      hintText: "Kata Sandi",
                      svgIconPath: "assets/icons/password.svg",
                      isRequired: true,
                      controller: passwordController,
                    ),
                    SizedBox(height: 16),
                    TextFieldInput(
                      hintText: "yourname@gmail.com",
                      svgIconPath: "assets/icons/email.svg",
                      isRequired: true,
                      controller: emailController,
                    ),
                    SizedBox(height: 16),
                    TextFieldInput(
                      hintText: "Masukan nomor kamu",
                      svgIconPath: "assets/icons/phone.svg",
                      isRequired: true,
                      controller: phoneController,
                    ),
                    SizedBox(height: 16),
                    TextFieldInput(
                      hintText: "Perusahaan",
                      svgIconPath: "assets/icons/building.svg",
                      isRequired: true,
                      controller: companyController,
                    ),
                    SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // Logout Button at Bottom
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ProfileScreenSupervisor()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors
                      .red, // ← pakai `backgroundColor` untuk versi baru Flutter
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: heading3,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}