import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:trusin_app/bloc/auth/auth_cubit.dart';
import 'package:trusin_app/bloc/register/supervisor/register_supervisor_bloc.dart';
import 'package:trusin_app/firebase_options.dart';
import 'package:trusin_app/ui/general/auth/cs/register_screen_cs.dart';
import 'package:trusin_app/ui/general/auth/forgot_password_screen.dart';
import 'package:trusin_app/ui/general/auth/login_screen.dart';
import 'package:trusin_app/ui/general/auth/role_selection_screen.dart';
import 'package:trusin_app/ui/general/auth/supervisor/register_screen_supervisor.dart';
import 'package:trusin_app/ui/onboarding/onboarding_screen.dart';
import 'package:trusin_app/ui/state-management/date_provider.dart';
import 'package:trusin_app/ui/superadmin/dashboard_superadmin.dart';
import 'package:trusin_app/ui/supervisor/dashboard-supervisor/dashboard_sv_screen.dart';
import 'package:trusin_app/ui/supervisor/detail-cs-supervisor/detail_cs_screen.dart';
import 'package:trusin_app/ui/supervisor/detail-lead-supervisor/detail_lead_screen.dart';
import 'package:trusin_app/ui/supervisor/notification-supervisor/notif_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => RegisterSupervisorBloc()),
        ChangeNotifierProvider(create: (_) => DateProvider())
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trusin',
      theme: ThemeData(
        fontFamily: 'PlusJakartaSans', 
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue
      ),
      initialRoute: '/',  // Route pertama yang dibuka
      routes: {
        '/': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/forgot-password': (context) => ForgotPasswordScreen(),
        '/role-selection': (context) => const RoleSelectionScreen(),
        '/register-cs': (context) => RegisterCSScreen(),
        '/register-supervisor': (context) => RegisterSupervisorScreen(),
        '/supervisor-home': (contextr) => DashboardSuperadmin(),
        '/superadmin-home': (context) => DashboardSuperadmin(),
        '/detail-cs' : (context) => const DetailCsScreen(),
        '/notification' : (context) => const NotifScreen(),
        '/detail-lead' : (context) => const DetailLeadScreen(),
        '/dashboard-supervisor' : (context) => const DashboardSvScreen(),
      },
    );
  }
}