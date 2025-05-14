import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:trusin_app/controllers/auth_controller.dart';
import 'package:trusin_app/controllers/register_cs_controller.dart';
import 'package:trusin_app/controllers/register_supervisor_controller.dart';
import 'package:trusin_app/controllers/verify_controller.dart';
import 'package:trusin_app/firebase_options.dart';
import 'package:trusin_app/ui/general/auth/cs/register_screen_cs.dart';
import 'package:trusin_app/ui/general/auth/forgot_password_screen.dart';
import 'package:trusin_app/ui/general/auth/login_screen.dart';
import 'package:trusin_app/ui/general/auth/supervisor/register_screen_supervisor.dart';
import 'package:trusin_app/ui/general/auth/waiting_approval_screen.dart';
import 'package:trusin_app/ui/onboarding/onboarding_screen.dart';
import 'package:trusin_app/ui/state-management/date_provider.dart';
import 'package:trusin_app/ui/super-admin/dashboard-superadmin/components/bottom_navbar.dart';
import 'package:trusin_app/ui/supervisor/dashboard-supervisor/dashboard_sv_screen.dart';
import 'package:trusin_app/ui/supervisor/detail-cs-supervisor/detail_cs_screen.dart';
import 'package:trusin_app/ui/supervisor/detail-lead-supervisor/detail_lead_screen.dart';
import 'package:trusin_app/ui/supervisor/notification-supervisor/notif_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.put(AuthController());
  Get.put(RegisterSupervisorController());
  Get.put(RegisterCsController());
  Get.put(VerifyController());
  
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
        primarySwatch: Colors.blue
      ),
      initialRoute: '/',  // Route pertama yang dibuka
      getPages: [
        GetPage(name: '/', page: ()=> OnboardingScreen()),
        GetPage(name: '/login', page: ()=> LoginScreen()),
        GetPage(name: '/forgot-password', page: ()=> ForgotPasswordScreen()),
        GetPage(name: '/register-cs', page: ()=> RegisterCSScreen()),
        GetPage(name: '/register-supervisor', page: ()=> RegisterSupervisorScreen()),
        GetPage(name: '/waiting-approval', page: ()=> WaitingApprovalScreen()),
        GetPage(name: '/supervisor-home', page: ()=> DashboardSvScreen()),
        GetPage(name: '/superadmin-home', page: ()=> BottomNavbar()),
        GetPage(name: '/detail-cs', page: ()=> DetailCsScreen()),
        GetPage(name: '/notification', page: ()=> NotifScreen()),
        GetPage(name: '/waiting-approval', page: ()=> DetailLeadScreen()),
        // '/role-selection': (context) => const RoleSelectionScreen(),
      ],
    );
  }
}