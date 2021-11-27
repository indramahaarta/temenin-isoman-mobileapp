import 'package:flutter/material.dart';
import 'package:temenin_isoman_mobileapp/screens/login_screen.dart';

void main() {
  runApp(const TemeninIsomanApp());
}

class TemeninIsomanApp extends StatelessWidget {
  const TemeninIsomanApp({Key? key}) : super(key: key);

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