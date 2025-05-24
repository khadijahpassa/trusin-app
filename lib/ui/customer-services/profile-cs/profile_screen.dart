import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/controllers/auth_controller.dart';
import 'package:trusin_app/ui/general/components/profile/change_password_form.dart';
import 'package:trusin_app/ui/general/components/profile/text_field_input.dart';

class ProfileScreenSupervisor extends StatefulWidget {
  ProfileScreenSupervisor({super.key});

  @override
  State<ProfileScreenSupervisor> createState() =>
      _ProfileScreenSupervisorState();
}

class _ProfileScreenSupervisorState extends State<ProfileScreenSupervisor> {
  bool isEditing = false;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final companyController = TextEditingController();
  final passwordController = TextEditingController();

  late final AuthController authController;

  @override
  void initState() {
    super.initState();
    authController = Get.find<AuthController>();
    final current = authController.currentUser.value;

    if (current != null) {
      nameController.text = current.name;
      usernameController.text = current.username;
      emailController.text = current.email;
      phoneController.text = current.phone;
      companyController.text = current.company;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    companyController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void resetForm() {
    final current = authController.currentUser.value;

    nameController.text = current?.name ?? '';
    usernameController.text = current?.username ?? '';
    emailController.text = current?.email ?? '';
    phoneController.text = current?.phone ?? '';
    companyController.text = current?.company ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding, vertical: 24),
        child: Column(
          children: [
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Obx(() => _buildHeader(
                          value: authController.currentUser.value?.name ?? '',
                          controller: nameController,
                    )),
                    SizedBox(height: defaultPadding),
                    Text("Personal Information",
                        style: TextStyle(
                            fontSize: heading2, fontWeight: FontWeight.bold)),
                    SizedBox(height: 16),
                    Obx(() => buildField(
                          svgPath: "assets/icons/username.svg",
                          value:
                              authController.currentUser.value?.username ?? '',
                          controller: usernameController,
                        )),
                    SizedBox(height: 16),
                    Obx(() => buildField(
                          svgPath: "assets/icons/email.svg",
                          value: authController.currentUser.value?.email ?? '',
                          controller: emailController,
                        )),
                    SizedBox(height: 16),
                    Obx(() => buildField(
                          svgPath: "assets/icons/phone.svg",
                          value: authController.currentUser.value?.phone ?? '',
                          controller: phoneController,
                        )),
                    SizedBox(height: 16),
                    Obx(() => buildField(
                          svgPath: "assets/icons/building.svg",
                          value:
                              authController.currentUser.value?.company ?? '',
                          controller: companyController,
                        )),
                    SizedBox(height: 16),
                    _buildPasswordSection(context),
                    SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            isEditing ? _buildEditButtons() : _buildLogoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader({
    required String value,
    required TextEditingController controller,
  }) {
    final current = authController.currentUser.value;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage:
                  AssetImage('assets/images/supervisor_avatar.png'),
              radius: 40,
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isEditing
                    ? TextFieldInput(
                        controller: controller,
                        enabled: true,
                      )
                    : Text(value.isNotEmpty ? value : '-',
                        style: TextStyle(
                            fontSize: heading2, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(current?.role ?? '', style: TextStyle(fontSize: body)),
              ],
            ),
          ],
        ),
        IconButton(
          icon: Icon(Icons.edit, color: isEditing ? primary400 : text300),
          onPressed: () {
            setState(() {
              isEditing = !isEditing;
              final current = authController.currentUser.value;
              nameController.text = current?.name ?? '';
              usernameController.text = current?.username ?? '';
              emailController.text = current?.email ?? '';
              phoneController.text = current?.phone ?? '';
              companyController.text = current?.company ?? '';
            });
          },
        )
      ],
    );
  }

  Widget buildField({
    required String svgPath,
    required String value,
    required TextEditingController controller,
  }) {
    return isEditing
        ? TextFieldInput(
            svgIconPath: svgPath,
            controller: controller,
            enabled: true,
          )
        : Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: secondary100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  svgPath,
                  width: 24,
                  height: 24,
                  color: primary500,
                ),
                SizedBox(width: 12),
                Text(value.isNotEmpty ? value : '-',
                    style: TextStyle(fontSize: 16)),
              ],
            ),
          );
  }

  Widget _buildPasswordSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: secondary100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset("assets/icons/password.svg",
                  width: 24, height: 24, color: primary500),
              SizedBox(width: 12),
              Text('•••••••••••', style: TextStyle(fontSize: 16)),
            ],
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios_outlined),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                ),
                builder: (_) {
                  return DraggableScrollableSheet(
                    initialChildSize: 0.6,
                    minChildSize: 0.4,
                    maxChildSize: 0.95,
                    expand: false,
                    builder: (context, scrollController) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(25)),
                        ),
                        padding: EdgeInsets.all(20),
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: ChangePasswordForm(),
                        ),
                      );
                    },
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildEditButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                isEditing = false;
                resetForm();
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: text300),
              ),
            ),
            child: Text("Batal",
                style: TextStyle(fontSize: descText, color: Colors.black)),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              final current = authController.currentUser.value;

              final nameChanged = nameController.text != (current?.name ?? '');
              final usernameChanged =
                  usernameController.text != (current?.username ?? '');
              final emailChanged =
                  emailController.text != (current?.email ?? '');
              final phoneChanged =
                  phoneController.text != (current?.phone ?? '');
              final companyChanged =
                  companyController.text != (current?.company ?? '');
              if (!nameChanged &&
                  !usernameChanged &&
                  !emailChanged &&
                  !phoneChanged &&
                  !companyChanged) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Gak ada data yang berubah, bor.')),
                );
                return;
              }
              if ((nameChanged && nameController.text.isEmpty) ||
                  (usernameChanged && usernameController.text.isEmpty) ||
                  (emailChanged && emailController.text.isEmpty) ||
                  (phoneChanged && phoneController.text.isEmpty) ||
                  (companyChanged && companyController.text.isEmpty)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content:
                          Text('Form yang diubah harus diisi semua, bor!')),
                );
                return;
              }
              authController.updateUser(
                name: nameController.text,
                username: usernameController.text,
                email: emailController.text,
                phone: phoneController.text,
                company: companyController.text,
              );
              setState(() => isEditing = false);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primary500,
              padding: EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: Text("Simpan",
                style: TextStyle(fontSize: descText, color: Colors.white)),
          ),
        ),
      ],
    );
  }

  Widget _buildLogoutButton() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              authController.logout();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              padding: EdgeInsets.symmetric(vertical: 25),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: Text("Logout",
                style: TextStyle(fontSize: descText, color: Colors.white)),
          ),
        ),
      ],
    );
  }
}
