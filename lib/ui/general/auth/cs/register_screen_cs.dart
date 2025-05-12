import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trusin_app/bloc/auth/auth_cubit.dart';
import 'package:trusin_app/bloc/register/cs/register_cs_bloc.dart';
import 'package:trusin_app/bloc/register/cs/register_cs_event.dart';
import 'package:trusin_app/const.dart';
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
  final TextEditingController phoneController = TextEditingController();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? selectedCompany;
  bool isSupervisor = true;
  bool isNewCompanySelected = false; 
 
  @override
  void dispose() {
    _pageController.dispose();
    _currentPage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCsBloc(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded), 
            onPressed: () { Navigator.pop(context); },
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
            _buildStep2(),
          ],
        ),
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
                      'Daftar sebagai Customer Service',
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
                          } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                              .hasMatch(value)) {
                            return "Masukkan email yang valid";
                          }
                          return null;
                        },
                        
                    ),
                    TextFieldInput(
                        textEditingController: phoneController,
                        hintText: "No. Telepon",
                        iconPath: "assets/icons/phone.svg",
                        inputType: TextInputType.number,
                        validator: (value) {
                          // format no telp Indonesia
                          final regex = RegExp(r'^(?:\+62|62|0)[2-9][0-9]{7,11}$');
                          
                          if (value == null || value.trim().isEmpty) {
                            return "No. telepon gak boleh kosong";
                          }  
                          if (!regex.hasMatch(value)) {
                            return "Format nomor gak valid";
                          }  
                          return null;
                        },
              
                    ),
                    CompanyDropdown(
                      selectedCompany: selectedCompany,
                      onChanged: (newValue) {
                        setState(() {
                          selectedCompany = newValue;
                          isNewCompanySelected = (newValue == "Perusahaan Belum Terdaftar");
                        });
                      },
                      isSupervisor: isSupervisor,
                      onNewCompanySelected: (isNew) => setState(() => isNewCompanySelected = isNew),
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
                  if (_formKey.currentState!.validate()) { // Cek validasi form
                    if (isNewCompanySelected) {
                      Navigator.pushNamed(context, '/register-company');
                    } else {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut
                      );
                    }
                  }
                }, text: 'Lanjutkan',
              ),
            ],
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: defaultPadding),
                    Text(
                      'Daftar sebagai Customer Service',
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
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        return TextFieldInput(
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Username gak boleh kosong";
                            }
                            if (value.length < 6) {
                              return "Username minimal 6 karakter";
                            }
                            if (state == AuthState.usernameTaken) {
                              return "Username udah digunakan";
                            }
                            return null;
                          },
                          onEditingComplete: () {
                            context.read<AuthCubit>().checkUsernameAvailability(usernameController.text);
                            _formKey.currentState!.validate(); // Validasi setelah cek username
                          }, 
                          textEditingController: usernameController, 
                          hintText: 'Username', 
                          iconPath: 'assets/icons/username.svg',
                        );
                      },
                    ),
                
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: [
              PrimaryButton(
                  onPressed: () async {
                    // Cek validasi form dulu
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }

                    // Cek username availability sebelum submit
                    final authCubit = context.read<AuthCubit>();
                    authCubit.checkUsernameAvailability(usernameController.text);

                    await Future.delayed(Duration(milliseconds: 500)); // Tunggu hasil validasi

                    if (authCubit.state == AuthState.usernameTaken) {
                      return; // Jangan lanjut kalau username udah dipakai
                    }

                    // Kalau semua valid, baru submit ke backend
                    context.read<RegisterCsBloc>().add(RegisterCsSubmitted(
                      name: nameController.text,
                      email: emailController.text,
                      phone: phoneController.text,
                      username: usernameController.text,
                      password: passwordController.text,
                      company: selectedCompany!,
                    ));
                  },
                text: 'Kirim Permintaan',
              ),
            ],
          )
        ],
      ),
    );
  }
}
