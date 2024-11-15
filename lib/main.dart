import 'package:devswipe/Sign_in_pages/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Pixeboy',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 24, color: Colors.black),
          bodyMedium: TextStyle(fontSize: 18, color: Colors.black),
          bodySmall: TextStyle(fontSize: 16, color: Colors.black),
        ),
      ),
      home: const LoginPage(),
    );
  }
}
