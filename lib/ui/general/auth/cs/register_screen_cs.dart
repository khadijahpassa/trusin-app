import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/controllers/auth_controller.dart';
import 'package:trusin_app/controllers/register_cs_controller.dart';
import 'package:trusin_app/ui/general/auth/components/company_dropdown.dart';
import 'package:trusin_app/ui/general/auth/components/primary_button.dart';
import 'package:trusin_app/ui/general/auth/components/text_field.dart';

class RegisterCSScreen extends StatefulWidget {
  @override
  _RegisterCSScreenState createState() => _RegisterCSScreenState();
}

class _RegisterCSScreenState extends State<RegisterCSScreen> {
  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentPage = ValueNotifier(0); // Track page index

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? selectedCompany;
  bool isSupervisor = true;
  bool isNewCompanySelected = false;

  final registerCSController = Get.find<RegisterCsController>();
  final authController = Get.find<AuthController>();

  @override
  void dispose() {
    _pageController.dispose();
    _currentPage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(""),
        actions: [
          ValueListenableBuilder<int>(
            valueListenable: _currentPage,
            builder: (context, pageIndex, child) {
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "${pageIndex + 1}",
                        style: const TextStyle(
                          fontSize: heading3,
                          fontWeight: FontWeight.bold,
                          color: primary300,
                        ),
                      ),
                      const TextSpan(
                        text: "/2",
                        style: TextStyle(
                          fontSize: heading3,
                          fontWeight: FontWeight.bold,
                          color: primary100,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          _currentPage.value = index; // Update indikator halaman
        },
        children: [
          _buildStep1(),
        ],
      ),
    );
  }

  Widget _buildStep1() {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: defaultPadding),
                    Text(
                      'Daftarin Akun untuk Customer Service',
                      style: TextStyle(
                        color: primary400,
                        fontSize: heading2,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Masukin data diri dulu biar bisa lanjut ke tahap berikutnya.',
                      style: TextStyle(
                        color: text400,
                        fontSize: body,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: defaultPadding),
                    TextFieldInput(
                      textEditingController: nameController,
                      hintText: "Nama Lengkap",
                      iconPath: "assets/icons/username.svg",
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Nama lengkap gak boleh kosong";
                        }
                        return null;
                      },
                    ),
                    TextFieldInput(
                      textEditingController: emailController,
                      hintText: "Alamat Email",
                      iconPath: "assets/icons/email.svg",
                      inputType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Alamat email gak boleh kosong";
                        } else if (!RegExp(
                                r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                            .hasMatch(value)) {
                          return "Masukkan email yang valid";
                        }
                        return null;
                      },
                    ),
                    TextFieldInput(
                      textEditingController: passwordController,
                      hintText: "Kata Sandi",
                      iconPath: "assets/icons/password.svg",
                      isPass: true,
                      validator: (value) => value == null || value.isEmpty
                          ? "Kata sandi gak boleh kosong"
                          : value.length < 6
                              ? "Minimal 6 karakter"
                              : null,
                    ),
                    TextFieldInput(
                      textEditingController: confirmPasswordController,
                      iconPath: "assets/icons/password.svg",
                      isPass: true,
                      hintText: "Konfirmasi Kata Sandi",
                      validator: (value) => value != passwordController.text
                          ? "Kata sandi kurang cocok 🤨"
                          : null,
                    ),
                    TextFieldInput(
                      textEditingController: phoneController,
                      hintText: "No. Telepon",
                      iconPath: "assets/icons/phone.svg",
                      inputType: TextInputType.number,
                      validator: (value) {
                        if (value != null && value.trim().isNotEmpty) {
                          final regex =
                              RegExp(r'^(?:\+62|62|0)[2-9][0-9]{7,11}$');
                          if (!regex.hasMatch(value)) {
                            return "Format nomor gak valid";
                          }
                        }
                        return null;
                      },
                    ),
                    CompanyDropdown(
                      selectedCompany: selectedCompany,
                      onChanged: (newValue) {
                        setState(() {
                          selectedCompany = newValue;
                        });
                      },
                      isSupervisor: isSupervisor,
                      onNewCompanySelected: (isNew) =>
                          setState(() => isNewCompanySelected = isNew),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: [
              PrimaryButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) return;

                  registerCSController.registerCS(
                    name: nameController.text,
                    email: emailController.text,
                    password : passwordController.text,
                    phone: phoneController.text.isEmpty
                        ? null
                        : phoneController.text,
                    company: selectedCompany!,

                    
                  );
                },
                text: 'Daftarin CS',
              ),
            ],
          )
        ],
      ),
    );
  }
}