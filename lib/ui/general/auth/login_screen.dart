import 'package:flutter/material.dart';
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
                        SizedBox(height: 150),
                        Text(
                          'Udah Punya Akun? Langsung Masuk Aja!',
                          style: TextStyle(
                            color: primary400,
                            fontSize: heading1,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Login dulu, biar makin sat-set!',
                          style: TextStyle(
                            color: text400,
                            fontSize: descText,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: 80),
                        TextFieldInput(
                            textEditingController: usernameController,
                            hintText: "Nama Pengguna",
                            iconPath: "assets/icons/username.svg"
                        ),
                        TextFieldInput(
                            textEditingController: passwordController,
                            hintText: "Kata Sandi",
                            iconPath: "assets/icons/password.svg"
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    PrimaryButton(
                      text: 'Masuk', 
                      onPressed: (){}
                    ),
                    SizedBox(height: defaultPadding),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/role-selection');
                      },
                      child: Text.rich(
                        TextSpan(
                          text: "Belum punya akun? ",
                          style: TextStyle(
                            color: primary600,
                            fontSize: heading3,
                          ),
                          children: [
                            TextSpan(
                              text: "Daftar dulu yuk!",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: heading3,
                                decoration: TextDecoration.underline, 
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ]
                )
              ],
            ),
           
      )),
    );
  }
}
