import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trusin_app/bloc/auth/auth_cubit.dart';
import 'package:trusin_app/bloc/register/supervisor/register_supervisor_bloc.dart';
import 'package:trusin_app/firebase_options.dart';
import 'package:trusin_app/ui/general/auth/cs/register_screen_cs.dart';
import 'package:trusin_app/ui/general/auth/forgot_password_screen.dart';
import 'package:trusin_app/ui/general/auth/login_screen.dart';
import 'package:trusin_app/ui/general/auth/role_selection_screen.dart';
import 'package:trusin_app/ui/general/auth/supervisor/register_screen_supervisor.dart';
import 'package:trusin_app/ui/onboarding/onboarding_screen.dart';
import 'package:trusin_app/ui/superadmin/dashboard_superadmin.dart';


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
      },
    );
  }
}