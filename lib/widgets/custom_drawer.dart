import 'package:flutter/material.dart';
import 'package:temenin_isoman_mobileapp/common/styles.dart';
import 'package:temenin_isoman_mobileapp/screens/home_screen.dart';
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
                  Center(
                    child: Text(
                      'Temenin Isoman',
                      style: AppTheme.myTextTheme.headline5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        ListTile(
          title: Text(
            "Home Page",
            style: AppTheme.myTextTheme.bodyText1,
          ),
          leading: const Icon(Icons.home),
          onTap: () {
            Navigator.pushNamed(
              context,
              HomeScreen.routeName,
            );
          },
        ),
        ListTile(
          title: Text(
            "Bed Capacity",
            style: AppTheme.myTextTheme.bodyText1,
          ),
          leading: const Icon(Icons.bed),
          onTap: () {},
        ),
        ListTile(
          title: Text(
            "Checklist",
            style: AppTheme.myTextTheme.bodyText1,
          ),
          leading: const Icon(Icons.checklist),
          onTap: () {},
        ),
        ListTile(
          title: Text(
            "Deteksi Mandiri",
            style: AppTheme.myTextTheme.bodyText1,
          ),
          leading: const Icon(Icons.sick_outlined),
          onTap: () {},
        ),
        ListTile(
          title: Text(
            "Emergency Contact",
            style: AppTheme.myTextTheme.bodyText1,
          ),
          leading: const Icon(Icons.warning),
          onTap: () {},
        ),
        ListTile(
          title: Text(
            "Happy Notes",
            style: AppTheme.myTextTheme.bodyText1,
          ),
          leading: const Icon(Icons.note_rounded),
          onTap: () {},
        ),
        ListTile(
          title: Text(
            "Tips And Tricks",
            style: AppTheme.myTextTheme.bodyText1,
          ),
          leading: const Icon(Icons.lightbulb_outline),
          onTap: () {
            Navigator.pushNamed(
              context,
              TipsAndTricksListPage.routeName,
            );
          },
        ),
        const SizedBox(
          height: 30,
        ),
        const Divider(
          thickness: 1.0,
        ),
        ListTile(
          title: Text(
            "Login",
            style: AppTheme.myTextTheme.bodyText1,
          ),
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
