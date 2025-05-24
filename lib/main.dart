import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:trusin_app/controllers/auth_controller.dart';
import 'package:trusin_app/controllers/cs_list_controller.dart';
import 'package:trusin_app/controllers/lead_list_controller.dart';
import 'package:trusin_app/controllers/product_controller.dart';
import 'package:trusin_app/controllers/quotation_controller.dart';
import 'package:trusin_app/controllers/register_cs_controller.dart';
import 'package:trusin_app/controllers/register_supervisor_controller.dart';
import 'package:trusin_app/controllers/verify_controller.dart';
import 'package:trusin_app/firebase_options.dart';
import 'package:trusin_app/ui/customer-services/dashboard-cs/components/bottom_navbar_cs.dart';
import 'package:trusin_app/ui/general/auth/cs/register_screen_cs.dart';
import 'package:trusin_app/ui/general/auth/forgot_password_screen.dart';
import 'package:trusin_app/ui/general/auth/login_screen.dart';
import 'package:trusin_app/ui/general/auth/supervisor/register_screen_supervisor.dart';
import 'package:trusin_app/ui/general/auth/waiting_approval_screen.dart';
import 'package:trusin_app/ui/onboarding/onboarding_screen.dart';
import 'package:trusin_app/ui/state-management/date_provider.dart';
import 'package:trusin_app/ui/super-admin/dashboard-superadmin/components/bottom_navbar_superadmin.dart';
import 'package:trusin_app/ui/supervisor/dashboard-supervisor/components/bottom_navbar_supervisor.dart';
import 'package:trusin_app/ui/supervisor/detail-cs-supervisor/detail_cs_screen.dart';
import 'package:trusin_app/ui/supervisor/notification-supervisor/notif_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Inisialisasi Format Lokal (Wajib untuk DateFormat dengan 'id_ID')
  await initializeDateFormatting('id_ID', null); // ⬅️ Tambahkan baris ini


  Get.put(AuthController());
  Get.put(RegisterSupervisorController());
  Get.put(RegisterCsController());
  Get.put(CSListController());
  Get.put(LeadListController());
  Get.put(VerifyController());
  Get.put(ProductController());
  Get.put(QuotationController());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DateProvider())
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trusin',
      theme: ThemeData(
        fontFamily: 'PlusJakartaSans',
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
      home: AuthWrapper(), // 👈 ganti initialRoute jadi home wrapper
      getPages: [
        GetPage(name: '/', page: () => OnboardingScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/forgot-password', page: () => ForgotPasswordScreen()),
        GetPage(name: '/register-cs', page: () => RegisterCSScreen()),
        GetPage(name: '/register-supervisor', page: () => RegisterSupervisorScreen()),
        GetPage(name: '/waiting-approval', page: () => WaitingApprovalScreen()),
        GetPage(name: '/supervisor-home', page: () => BottomNavbarSupervisor()),
        GetPage(name: '/superadmin-home', page: () => BottomNavbarSuperadmin()),
        GetPage(name: '/cs-home', page: () => BottomNavbarCS()),
        GetPage(name: '/detail-cs', page: () => DetailCsScreen()),
        GetPage(name: '/notification', page: () => NotifScreen()),
      ],
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(), // pantau login/logout
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasData) {
          // User sudah login → arahkan ke bottom navbar sesuai role
          // Untuk sementara bisa diarahkan ke CS
          return BottomNavbarCS();
        } else {
          // Belum login → arahkan ke login
          return LoginScreen();
        }
      },
    );
  }
}

