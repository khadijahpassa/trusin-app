import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trusin_app/firebase_options.dart';
import 'package:trusin_app/ui/super-admin/companies/companies_superadmin.dart';
import 'package:trusin_app/ui/super-admin/dashboard-superadmin/components/bottom_navbar.dart';
import 'package:trusin_app/ui/super-admin/dashboard-superadmin/dashboard_superadmin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
        primarySwatch: Colors.blue
      ),
      initialRoute: '/',  // Route pertama yang dibuka
      routes: {
        '/': (context) => BottomNavbar(),
        '/superadmin-dashboard': (context) => DashboardSuperadmin(),
        '/superadmin-companies' : (context) => CompaniesSuperadmin(),
        '/superadmin-verify' : (context) => CompaniesSuperadmin(),
        '/superadmin-notification' : (context) => CompaniesSuperadmin(),
      },
    );
  }
}