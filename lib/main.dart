import 'package:butche_app/pages/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ButcheApp());
}

class ButcheApp extends StatelessWidget {
  const ButcheApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'butche',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        bottomNavigationBarTheme:
            const BottomNavigationBarThemeData(selectedItemColor: Colors.white),
      ),
      home: const MyLoginPage(),
    );
  }
}
