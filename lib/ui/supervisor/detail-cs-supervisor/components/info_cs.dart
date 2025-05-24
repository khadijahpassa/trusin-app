import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/models/cs_list_model.dart';

class InfoCs extends StatelessWidget implements PreferredSizeWidget {
  final CSModel cs;
  const InfoCs({super.key, required this.cs});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: InfoItem(
                label: "Nomor Telepon",
                content: Text(
                  cs.phone.isNotEmpty ? cs.phone : '-',
                  style: const TextStyle(
                    fontSize: body,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
            ),
            Expanded(
              child: InfoItem(
                label: "Alamat Email",
                content: Text(
                  cs.email.isNotEmpty ? cs.email : '-',
                  style: const TextStyle(
                    fontSize: body,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Widget reusable buat tiap info (title + content)
class InfoItem extends StatelessWidget {
  final String label;
  final Widget content;

  const InfoItem({
    super.key,
    required this.label,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: caption)),
        content,
      ],
    );
  }
}

// Widget buat nampilin password yang bisa di-toggle (sensor atau gak)
class PasswordView extends StatefulWidget {
  final String password;
  const PasswordView({super.key, required this.password});

  @override
  State<PasswordView> createState() => _PasswordViewState();
}

class _PasswordViewState extends State<PasswordView> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            _obscure ? '•' * widget.password.length : widget.password,
            style: const TextStyle(
                    fontSize: descText,
                    fontWeight: FontWeight.w600
                  ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        IconButton(
          icon: Icon(
            _obscure ? Icons.visibility_off : Icons.visibility,
            size: 20,
          ),
          onPressed: () {
            setState(() {
              _obscure = !_obscure;
            });
          },
        ),
      ],
    );
  }
}
