import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/controllers/auth_controller.dart';
import 'package:trusin_app/controllers/register_supervisor_controller.dart';
import 'package:trusin_app/ui/general/auth/components/company_dropdown.dart';
import 'package:trusin_app/ui/general/auth/components/primary_button.dart';
import 'package:trusin_app/ui/general/auth/components/text_field.dart';
import 'package:trusin_app/ui/general/auth/supervisor/components/company_type_dropdown.dart';
import 'package:trusin_app/ui/general/auth/supervisor/components/supervisor_type_dropdown.dart';
import 'package:trusin_app/ui/general/auth/waiting_approval_screen.dart';

class RegisterSupervisorScreen extends StatefulWidget {
  const RegisterSupervisorScreen({super.key});

  @override
  State<RegisterSupervisorScreen> createState() =>
      _RegisterSupervisorScreenState();
}

class _RegisterSupervisorScreenState extends State<RegisterSupervisorScreen> {
  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentPage = ValueNotifier(0);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController companyNameController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? selectedRole;
  String? selectedCompany;
  String? companyTypeSelection;
  bool isNewCompanySelected = false;
  bool isSupervisor = true;

  final registerSvController = Get.find<RegisterSupervisorController>();
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
        leading: ValueListenableBuilder<int>(
          valueListenable: _currentPage,
          builder: (context, page, child) {
            if (page == 2) return SizedBox.shrink();
            return IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded),
              onPressed: () {
                if (page > 0) {
                  _pageController.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                } else {
                  Get.back();
                }
              },
            );
          },
        ),
        title: const Text(""),
        actions: [
          ValueListenableBuilder<int>(
            valueListenable: _currentPage,
            builder: (context, pageIndex, child) {
              if (pageIndex == 2) return SizedBox.shrink();
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
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (index) => _currentPage.value = index,
        children: [
          _buildStep1(),
          _buildStep2(),
          _buildCompanyRegist(),
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
                    Text('Daftar sebagai Supervisor/Manager/Owner',
                        style: TextStyle(
                            color: primary400,
                            fontSize: heading2,
                            fontWeight: FontWeight.w700)),
                    SizedBox(height: 10),
                    Text('Masukin data diri dulu, biar nanti prosesnya lancar.',
                        style: TextStyle(color: text400, fontSize: body)),
                    SizedBox(height: defaultPadding),
                    TextFieldInput(
                      textEditingController: nameController,
                      hintText: "Nama Lengkap",
                      iconPath: "assets/icons/username.svg",
                      validator: (value) =>
                          value == null || value.trim().isEmpty
                              ? "Nama lengkap gak boleh kosong"
                              : null,
                    ),
                    TextFieldInput(
                      textEditingController: emailController,
                      hintText: "Alamat Email",
                      iconPath: "assets/icons/email.svg",
                      inputType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return "Alamat email gak boleh kosong";
                        if (!RegExp(r"^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$")
                            .hasMatch(value))
                          return "Masukkan email yang valid";
                        return null;
                      },
                    ),
                    TextFieldInput(
                      textEditingController: phoneController,
                      hintText: "No. Telepon",
                      iconPath: "assets/icons/phone.svg",
                      inputType: TextInputType.number,
                      validator: (value) {
                        final regex =
                            RegExp(r'^(?:\+62|62|0)[2-9][0-9]{7,11}$');
                        if (value == null || value.trim().isEmpty)
                          return "No. telepon gak boleh kosong";
                        if (!regex.hasMatch(value))
                          return "Format nomor gak valid";
                        return null;
                      },
                    ),
                    RoleDropdown(
                      roleSelection: selectedRole,
                      onChanged: (newRole) =>
                          setState(() => selectedRole = newRole),
                    ),
                    CompanyDropdown(
                      selectedCompany: selectedCompany,
                      onChanged: (newValue) {
                        setState(() {
                          selectedCompany = newValue;
                          isNewCompanySelected =
                              newValue == "Perusahaan Belum Terdaftar";
                        });
                      },
                      isSupervisor: isSupervisor,
                      onNewCompanySelected: (isNew) =>
                          setState(() => isNewCompanySelected = isNew),
                    ),
                  ],
                ),
              ),
            ),
          ),
          PrimaryButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (isNewCompanySelected) {
                  _pageController.animateToPage(2,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.linear);
                } else {
                  _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                }
              }
            },
            text: 'Lanjutkan',
          ),
        ],
      ),
    );
  }

  Widget _buildStep2() {
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
                    Text('Tinggal Selangkah Lagi!',
                        style: TextStyle(
                            color: primary400,
                            fontSize: heading2,
                            fontWeight: FontWeight.w700)),
                    SizedBox(height: 10),
                    Text(
                        'Pendaftaranmu butuh persetujuan admin dulu. Tunggu sebentar, ya!',
                        style: TextStyle(color: text400, fontSize: body)),
                    SizedBox(height: defaultPadding),
                    TextFieldInput(
                      validator: (value) {
                        if (value == null || value.trim().isEmpty)
                          return "Username gak boleh kosong";
                        if (value.length < 6)
                          return "Username minimal 6 karakter";
                        if (authController.usernameCheckState.value ==
                            UsernameCheckState.taken)
                          return "Username udah digunakan";
                        return null;
                      },
                      onEditingComplete: () async {
                        await authController
                            .checkUsernameAvailability(usernameController.text);
                        _formKey.currentState!.validate();
                      },
                      textEditingController: usernameController,
                      hintText: 'Username',
                      iconPath: 'assets/icons/username.svg',
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
                  ],
                ),
              ),
            ),
          ),
          Obx(() {
            if (registerSvController.isSuccess.value) {
              // reset supaya nggak terus navigasi kalau balik ke halaman ini
              registerSvController.isSuccess.value = false;

              // langsung navigasi ke halaman tunggu persetujuan
              Future.microtask(() {
                Get.offAll(() => WaitingApprovalScreen());
              });
            }

            // Kalau sedang loading (proses pendaftaran), tampilkan loading spinner
            if (registerSvController.isLoading.value) {
              return CircularProgressIndicator();
            }

            // Kalau ada error saat proses pendaftaran, tampilkan pesan error ke user
            if (registerSvController.errorMessage.value.isNotEmpty) {
              return Text(registerSvController.errorMessage.value,
                  style: TextStyle(color: error500));
            }
            
            return PrimaryButton(
              onPressed: () async {
                if (!_formKey.currentState!.validate()) return;
                final isAvailable = await authController
                    .checkUsernameAvailability(usernameController.text);
                if (!isAvailable) {
                  Get.snackbar("Gagal", "Username udah digunakan");
                  return;
                }
                registerSvController.registerSupervisor(
                  name: nameController.text,
                  email: emailController.text,
                  phone: phoneController.text,
                  username: usernameController.text,
                  password: passwordController.text,
                  company: isNewCompanySelected
                      ? companyNameController.text
                      : selectedCompany!,
                  companyType: companyTypeSelection!,
                  displayRole: selectedRole!,
                );
              },
              text: 'Kirim Permintaan',
            );
          }),
        ],
      ),
    );
  }

  Widget _buildCompanyRegist() {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Perusahaan Belum Terdaftar? Daftarin Dulu!',
                        style: TextStyle(
                            color: primary400,
                            fontSize: heading2,
                            fontWeight: FontWeight.w700)),
                    SizedBox(height: 10),
                    Text(
                        'Kalau perusahaan kamu belum ada di sistem, tinggal masukin datanya di sini ya.',
                        style: TextStyle(color: text400, fontSize: body)),
                    SizedBox(height: 30),
                    TextFieldInput(
                      textEditingController: companyNameController,
                      hintText: 'Nama Perusahaan',
                      iconPath: 'assets/icons/building.svg',
                      validator: (value) => value == null || value.isEmpty
                          ? "Nama perusahaan harus diisi"
                          : null,
                    ),
                    CompanyTypeDropdown(
                      companyTypeSelection: companyTypeSelection,
                      onChanged: (newValue) =>
                          setState(() => companyTypeSelection = newValue),
                    ),
                  ],
                ),
              ),
            ),
          ),
          PrimaryButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _pageController.animateToPage(1,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.linear);
              }
            },
            text: 'Lanjutkan',
          ),
        ],
      ),
    );
  }
}
