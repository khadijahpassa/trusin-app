import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:trusin_app/const.dart';

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({super.key});

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _isLoading = false;

  Widget _buildPasswordField(
      {required String label, required TextEditingController controller}) {
    return TextField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: secondary200,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  void _submitChangePassword() async {
    final current = _currentController.text.trim();
    final newPass = _newController.text.trim();
    final confirm = _confirmController.text.trim();

    if (current.isEmpty || newPass.isEmpty || confirm.isEmpty) {
      _showSnackbar("Gagal", "Isi semua field, bor!");
      return;
    }

    if (newPass != confirm) {
      _showSnackbar("Gagal", "Password baru dan konfirmasi Tidak sama!");
      return;
    }

    setState(() => _isLoading = true);

    try {
      final user = FirebaseAuth.instance.currentUser!;
      final cred = EmailAuthProvider.credential(
        email: user.email!,
        password: current,
      );

      await user.reauthenticateWithCredential(cred);
      await user.updatePassword(newPass);

      Navigator.pop(context);
      _showSnackbar("Berhasil!", "Password berhasil diganti");
    } on FirebaseAuthException catch (e) {
      var msg = switch (e.code) {
        'wrong-password' => 'Password lama salah!',
        //TODO nnti ini di un komen yhh, skrg butuh pw yg lemah soalnya
        // 'weak-password' => 'Password baru terlalu lemah!',
        _ => 'Error: ${e.message}',
      };
      _showSnackbar("Gagal Ganti Password!", msg);
    } catch (e) {
      _showSnackbar("Gagal", "Gagal ganti password: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // void _showSnackbar(String message) {
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  // }

  void _showSnackbar(String title, String message) {
  Get.snackbar(
    title,
    message,
  );
}


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            "Ganti Password",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 30),
          _buildPasswordField(
            label: "Password Sekarang",
            controller: _currentController,
          ),
          SizedBox(height: 15),
          _buildPasswordField(
            label: "Password Baru",
            controller: _newController,
          ),
          SizedBox(height: 15),
          _buildPasswordField(
            label: "Konfirmasi Password",
            controller: _confirmController,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _isLoading ? null : _submitChangePassword,
            style: ElevatedButton.styleFrom(
              backgroundColor: primary400,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: _isLoading
                ? CircularProgressIndicator(color: Colors.white)
                : Text("Simpan", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
