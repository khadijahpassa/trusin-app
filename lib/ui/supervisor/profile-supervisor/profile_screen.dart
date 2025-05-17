import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/controllers/auth_controller.dart';
import 'package:trusin_app/model/user_model.dart';
import 'package:trusin_app/ui/supervisor/profile-supervisor/component/appbar.dart';
import 'package:trusin_app/ui/supervisor/profile-supervisor/component/change_password_form.dart';
import 'package:trusin_app/ui/supervisor/profile-supervisor/component/form_input.dart';

class ProfileScreenSupervisor extends StatefulWidget {
  ProfileScreenSupervisor({super.key});

  @override
  State<ProfileScreenSupervisor> createState() =>
      _ProfileScreenSupervisorState();
}

class _ProfileScreenSupervisorState extends State<ProfileScreenSupervisor> {
  bool isEditing = false;
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final companyController = TextEditingController();
  final passwordController = TextEditingController();

  late final AuthController authController;
  late final UserModel? user;

  @override
  void initState() {
    super.initState();
    authController = Get.find<AuthController>();
    user = authController.currentUser.value;

    if (user != null) {
      usernameController.text = user?.username ?? '-tu';
      emailController.text = user?.email ?? '';
      phoneController.text = user?.phone ?? '';
      companyController.text = user?.company ?? '';
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    companyController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void resetForm() {
    usernameController.text = user?.username ?? '';
    emailController.text = user?.email ?? '';
    phoneController.text = user?.phone ?? '';
    companyController.text = user?.company ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(),
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
                    // Header Avatar + Name + Role
                    _buildHeader(),
                    SizedBox(height: defaultPadding),
                    Text("Personal Information",
                        style: TextStyle(
                            fontSize: heading2, fontWeight: FontWeight.bold)),
                    SizedBox(height: 16),

                    // Profile Fields
                    Obx( () =>
                      buildField(
                        svgPath: "assets/icons/username.svg",
                        value:authController.currentUser.value?.username ?? '',
                        controller: usernameController,
                      ),
                    ),
                    SizedBox(height: 16),
                    Obx( () =>
                      buildField(
                        svgPath: "assets/icons/email.svg",
                        value:authController.currentUser.value?.email ?? '',
                        controller: emailController,
                      ),
                    ),
                    SizedBox(height: 16),
                    Obx( () =>
                      buildField(
                        svgPath: "assets/icons/phone.svg",
                        value:authController.currentUser.value?.phone ?? '',
                        controller: phoneController,
                      ),
                    ),
                    SizedBox(height: 16),
                    Obx( () =>
                      buildField(
                        svgPath: "assets/icons/building.svg",
                        value:authController.currentUser.value?.company ?? '',
                        controller: companyController,
                      ),
                    ),
                    SizedBox(height: 16),
                    // Password Change
                    _buildPasswordSection(context),
                    SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // Button Bawah
            isEditing ? _buildEditButtons() : _buildLogoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
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
                Text(user?.name ?? '',
                    style: TextStyle(
                        fontSize: heading2, fontWeight: FontWeight.bold)),
                Text(user?.role ?? '', style: TextStyle(fontSize: body)),
              ],
            ),
          ],
        ),
        IconButton(
            icon: Icon(Icons.edit, color: isEditing ? primary400 : text300),
            onPressed: () {
              setState(() {
                isEditing = !isEditing;
                // reset controller.text ke data lama biar muncul di textfield
                usernameController.text = user?.username ?? '';
                emailController.text = user?.email ?? '';
                phoneController.text = user?.phone ?? '';
                companyController.text = user?.company ?? '';
              });
            })
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
              padding: EdgeInsets.symmetric(vertical: 25),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: text300),
              ),
            ),
            child: Text("Batal",
                style: TextStyle(fontSize: heading3, color: Colors.black)),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              final usernameChanged =
                  usernameController.text != (user?.username ?? '');
              final emailChanged = emailController.text != (user?.email ?? '');
              final phoneChanged = phoneController.text != (user?.phone ?? '');
              final companyChanged =
                  companyController.text != (user?.company ?? '');
              // Kalau gak ada yang berubah, jangan simpan
              if (!usernameChanged &&
                  !emailChanged &&
                  !phoneChanged &&
                  !companyChanged) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Gak ada data yang berubah, bor.')),
                );
                return;
              }
              // Kalau ada yang berubah, tapi ada yang kosong (dan dia pengen diubah)
              if ((usernameChanged && usernameController.text.isEmpty) ||
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
              // Aman? Yaudah simpan
              authController.updateUser(
                username: usernameController.text,
                email: emailController.text,
                phone: phoneController.text,
                company: companyController.text,
              );
              setState(() => isEditing = false);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primary500,
              padding: EdgeInsets.symmetric(vertical: 25),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: Text("Simpan", style: TextStyle(fontSize: heading3, color: Colors.white)),
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
            // onPressed: () => authController.logout(),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => ProfileScreenSupervisor()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              padding: EdgeInsets.symmetric(vertical: 25),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: Text("Logout",
                style: TextStyle(fontSize: heading3, color: Colors.white)),
          ),
        ),
      ],
    );
  }
}
