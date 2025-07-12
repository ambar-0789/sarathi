import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/patient_screen.dart';
import 'screens/guardian_screen.dart';

void main() {
  runApp(const SaarthiApp());
}

class SaarthiApp extends StatelessWidget {
  const SaarthiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SaarthiApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/patient': (context) => const PatientScreen(),
        '/guardian': (context) => const GuardianScreen(),
      },
    );
  }
}
