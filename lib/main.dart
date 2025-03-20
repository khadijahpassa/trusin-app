import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trusin_app/ui/general/auth/login_screen.dart';
import 'package:trusin_app/ui/general/auth/role_selection_screen.dart';
import 'package:trusin_app/ui/onboarding/onboarding_screen.dart';


void main() {
  runApp(MyApp());
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

      ),
      initialRoute: '/',  // Route pertama yang dibuka
      routes: {
        '/': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/role-selection': (context) => const RoleSelectionScreen(),
      },
    );
  }
}