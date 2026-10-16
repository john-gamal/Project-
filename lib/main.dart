import 'package:flutter/material.dart';
import 'package:project/screens/login.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      color: Colors.deepPurple,
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
