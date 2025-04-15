import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trusin_app/bloc/auth/auth_cubit.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/ui/general/auth/components/primary_button.dart';
import 'package:trusin_app/ui/general/auth/components/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                            hintText: "Nama Pengguna",
                            iconPath: "assets/icons/username.svg",
                        ),
                        TextFieldInput(
                            textEditingController: passwordController,
                            hintText: "Kata Sandi",
                            iconPath: "assets/icons/password.svg",
                            isPass: true,
                        ),
                        // navigasi ke dashboard masing-masing role ada di sini
                        BlocListener<AuthCubit, AuthState>(
                            listener: (context, state) {
                            if (state == AuthState.authenticated) {
                              final role = context.read<AuthCubit>().currentRole;
                              if (role == 'superadmin') {
                                Navigator.pushReplacementNamed(context, '/superadmin-home');
                              } else if (role == 'supervisor') {
                                Navigator.pushReplacementNamed(context, '/supervisor-home');
                              } else {
                                Navigator.pushReplacementNamed(context, '/cs-home');
                              }
                            } else if (state == AuthState.pendingApproval) {
                              Navigator.pushReplacementNamed(context, '/waiting-approval');
                            } else if (state == AuthState.failure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Username atau password salah!')),
                              );
                            }
                          },
                          child: BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            if (state == AuthState.failure) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  'Username atau password salah!',
                                  style: TextStyle(color: error500),
                                ),
                              );
                            }
                            return SizedBox.shrink();
                          },
                         ),
                        ),

                      // Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/forgot-password');
                          },
                          child: const Text(
                            "Lupa Kata Sandi?", 
                            style: TextStyle(color: primary600)
                          ),
                        ),
                      ),

                      ],
                    ),
                  ),
                ),
                BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      PrimaryButton(
                        text: state == AuthState.loading ? "Tunggu ya..." : "Masuk",
                        onPressed: state == AuthState.loading
                            ? null
                            : () {
                                context.read<AuthCubit>().login(
                                  usernameController.text,
                                  passwordController.text,
                                );
                              },
                      ),
                      SizedBox(height: defaultPadding),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/role-selection');
                        },
                        child: Text.rich(
                          TextSpan(
                            text: "Belum punya akun? ",
                            style: TextStyle(color: primary600, fontSize: descText),
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
                },
              )
              ],
            ),
           
      )),
    );
  }
}
