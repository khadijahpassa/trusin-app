import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trusin_app/bloc/auth/auth_cubit.dart';
import 'package:trusin_app/bloc/register/supervisor/register_supervisor_bloc.dart';
import 'package:trusin_app/bloc/register/supervisor/register_supervisor_event.dart';
import 'package:trusin_app/bloc/register/supervisor/register_supervisor_state.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/ui/general/auth/components/company_dropdown.dart';
import 'package:trusin_app/ui/general/auth/components/primary_button.dart';
import 'package:trusin_app/ui/general/auth/components/text_field.dart';
import 'package:trusin_app/ui/general/auth/supervisor/components/company_type_dropdown.dart';
import 'package:trusin_app/ui/general/auth/supervisor/components/supervisor_type_dropdown.dart';
import 'package:trusin_app/ui/general/auth/waiting_approval_screen.dart';

class RegisterSupervisorScreen extends StatefulWidget {
  const RegisterSupervisorScreen({super.key});

  @override
  RegisterSupervisorScreenState createState() => RegisterSupervisorScreenState();
}

class RegisterSupervisorScreenState extends State<RegisterSupervisorScreen> {
  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentPage = ValueNotifier(0); // Track page index

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? selectedRole;
  String? selectedCompany;
  bool isSupervisor = true;
  bool isNewCompanySelected = false; 

  // company regist punya
  final _companyNameController = TextEditingController();
  String? selectedCompanyType;
  String? companyTypeSelection;
 
  @override
  void dispose() {
    _pageController.dispose();
    _currentPage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: ini cara pake BLoC gimana ya Allah
    return BlocListener<RegisterSupervisorBloc, RegisterSupervisorState>(
    listener: (context, state) {
      if (state is RegisterSupervisorSuccess) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => WaitingApprovalScreen()),
        );
      }
    },
      child: Scaffold(
        appBar: AppBar(
          leading: ValueListenableBuilder<int>(
            valueListenable: _currentPage,
            builder: (context, page, child) {
              // Kalau di halaman _buildCompanyRegist, sembunyikan indikator
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
                    Navigator.pop(context); // Kembali ke screen sebelumnya
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
              // Kalau di halaman _buildCompanyRegist, sembunyikan indikator
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
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            _currentPage.value = index; // Update indikator halaman
          },
          children: [
            _buildStep1(),
            _buildStep2(),
            _buildCompanyRegist(),
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
                      'Daftar sebagai Supervisor/Manager/Owner',
                      style: TextStyle(
                        color: primary400,
                        fontSize: heading2,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Masukin data diri dulu, biar nanti prosesnya lancar.',
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
                    RoleDropdown(
                      roleSelection: selectedRole, 
                      onChanged: (newRole) {
                        setState(() {
                          selectedRole = newRole; 
                        });
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
                      _pageController.animateToPage(
                      2, // Indeks halaman buildCompanyRegist
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear,
                    );
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: defaultPadding),
                    Text(
                      'Tinggal Selangkah Lagi!',
                      style: TextStyle(
                        color: primary400,
                        fontSize: heading2,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Pendaftaranmu butuh persetujuan admin dulu. Tunggu sebentar, ya!',
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

                    TextFieldInput(
                      textEditingController: passwordController,
                      hintText: "Kata Sandi",
                      iconPath: "assets/icons/password.svg",
                      isPass: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) return "Kata sandi gak boleh kosong";
                        if (value.length < 6) return "Minimal 6 karakter";
                        return null;
                      },
                    ),

                    TextFieldInput(
                      textEditingController: confirmPasswordController,
                      iconPath: "assets/icons/password.svg",
                      isPass: true,
                      hintText: "Konfirmasi Kata Sandi",
                      validator: (value) {
                        if (value == null || value.isEmpty) return "Konfirmasi kata sandi gak boleh kosong";
                        if (value != passwordController.text) return "Kata sandi kurang cocok 🤨";
                        return null;
                      }, 
                    ),
                    SizedBox(height: defaultPadding)
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

                    final authCubit = context.read<AuthCubit>();
                    final isAvailable = await authCubit.checkUsernameAvailability(usernameController.text);

                    if (!isAvailable) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Username udah digunakan')),
                      );
                      return;
                    }

                    // Kalau semua valid, baru submit ke backend
                    context.read<RegisterSupervisorBloc>().add(RegisterSupervisorSubmitted(
                      name: nameController.text,
                      email: emailController.text,
                      phone: phoneController.text,
                      username: usernameController.text,
                      password: passwordController.text,
                      company: isNewCompanySelected
                              ? _companyNameController.text
                              : selectedCompany!,
                      companyType: companyTypeSelection!, 
                      displayRole: selectedRole!
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
  
  Widget _buildCompanyRegist() {
    return Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Perusahaan Belum Terdaftar? Daftarin Dulu!',
                        style: TextStyle(
                          color: primary400,
                          fontSize: heading2,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Kalau perusahaan kamu belum ada di sistem, tinggal masukin datanya di sini ya.',
                        style: TextStyle(
                          color: text400,
                          fontSize: body,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 30),
                      TextFieldInput(
                        textEditingController: _companyNameController, 
                        hintText: 'Nama Perusahaan', 
                        iconPath: 'assets/icons/building.svg',
                        validator: (value) {
                          if(value == null || value.isEmpty) {
                            return "Nama perusahaan harus diisi";
                          }
                          return null; 
                         },
                      ),
                      CompanyTypeDropdown(
                        companyTypeSelection: companyTypeSelection,
                        onChanged: (newValue) {
                          setState(() {
                            companyTypeSelection = newValue;
                          });
                        },
                      ), 
                    ],
                  )
                ),
              ),
            ),
            Column(
            children: [
              PrimaryButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Pindah ke RegisterSupervisorScreen dan langsung ke Step 2
                      _pageController.animateToPage(
                      1, // Indeks halaman buildCompanyRegist
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear,
                    );
                  }
                }, text: 'Lanjutkan',
              ),
            ],
          ),
          ],
        ),
      );
  }
}
