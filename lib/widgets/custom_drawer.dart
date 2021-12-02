import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:temenin_isoman_mobileapp/common/styles.dart';
import 'package:temenin_isoman_mobileapp/screens/login_screen.dart';
import 'package:tips_and_tricks/main.dart';

Widget customDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      children: <Widget>[
        DrawerHeader(
          child: SingleChildScrollView(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(60.0),
                      ),
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 100,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: Center(
                      child: Text(
                        'Temenin Isoman',
                        style: AppTheme.myTextTheme.bodyText1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        ListTile(
          title: const Text(
            "Home Page",
          ),
          leading: const Icon(Icons.home),
          onTap: () {},
        ),
        ListTile(
          title: const Text("Bed Capacity"),
          leading: const Icon(Icons.bed),
          onTap: () {},
        ),
        ListTile(
          title: const Text("Checklist"),
          leading: const Icon(Icons.checklist),
          onTap: () {},
        ),
        ListTile(
          title: const Text("Deteksi Mandiri"),
          leading: const Icon(Icons.sick_outlined),
          onTap: () {},
        ),
        ListTile(
          title: const Text("Emergency Contact"),
          leading: const Icon(Icons.warning),
          onTap: () {},
        ),
        ListTile(
          title: const Text("Happy Notes"),
          leading: const Icon(Icons.note_rounded),
          onTap: () {},
        ),
        ListTile(
          title: const Text("Tips And Tricks"),
          leading: const Icon(Icons.lightbulb_outline),
          onTap: () {
            Navigator.pushNamed(
              context,
              TipsAndTricks.routeName,
            );
          },
        ),
        ListTile(
          title: const Text(
            "About Us",
          ),
          leading: const Icon(Icons.info),
          onTap: () {},
        ),
        const Divider(
          thickness: 1.0,
        ),
        ListTile(
          title: const Text("Login"),
          leading: const Icon(Icons.login),
          onTap: () {
            Navigator.pushNamed(
              context,
              LoginScreen.routeName,
            );
          },
        ),
      ],
    ),
  );
}
