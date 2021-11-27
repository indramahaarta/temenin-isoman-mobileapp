import 'package:flutter/material.dart';
import 'package:temenin_isoman_mobileapp/screens/login_screen.dart';

void main() {
  runApp(TemeninIsomanApp());
}

class TemeninIsomanApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => const LoginScreen(),
      },
    );
  }
}