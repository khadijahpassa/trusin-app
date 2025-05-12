import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/ui/general/auth/components/primary_button.dart';
import 'package:trusin_app/ui/general/auth/components/text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      String email = emailController.text;
      print("Kirim reset password ke $email");
    }
  }

  // kalo udah nyambung ke firebase
  /*
  void _submit() async {
    if (_formKey.currentState!.validate()) {
      String email = emailController.text;

      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Email reset password telah dikirim!")),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Gagal mengirim email: ${e.toString()}")),
        );
      }
    }
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded), 
          onPressed: () { Navigator.pop(context); },
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Lupa Kata Sandi Ya?',
                style: TextStyle(
                  fontSize: heading1,
                  fontWeight: FontWeight.w700,
                  color: primary500
                ),
              ),
              SizedBox(height: 10),
              const Text(
                "Masukkan email kamu untuk reset kata sandi.",
                style: TextStyle(fontSize: descText),
              ),
              const SizedBox(height: 10),
              TextFieldInput(
                textEditingController: emailController,
                hintText: "Alamat Email",
                iconPath: "assets/icons/email.svg",
                inputType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email gak boleh kosong";
                  } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                      .hasMatch(value)) {
                    return "Masukkan email yang valid";
                  }
                  return null;
                },
              ),
              const SizedBox(height: defaultPadding),
              PrimaryButton(
                onPressed: _submit,
                text: 'Kirim',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
