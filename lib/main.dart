import 'package:flutter/material.dart';
import 'package:temenin_isoman_mobileapp/screens/home_screen.dart';
import 'package:temenin_isoman_mobileapp/screens/login_screen.dart';
import 'package:tips_and_tricks/common/styles.dart';
import 'package:tips_and_tricks/main.dart';

void main() {
  runApp(const TemeninIsomanApp());
}

class TemeninIsomanApp extends StatelessWidget {
  const TemeninIsomanApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temenin Isoman',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
      routes: {
        LoginScreen.routeName: (context) => const LoginScreen(),
        TipsAndTricks.routeName : (context) => const TipsAndTricks(),
      },
    );
  }
}