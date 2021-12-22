import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:temenin_isoman_mobileapp/models/user.dart';
import 'package:temenin_isoman_mobileapp/utils/session.dart';

import 'package:temenin_isoman_mobileapp/common/styles.dart';
import 'package:temenin_isoman_mobileapp/screens/home_screen.dart';
import 'package:temenin_isoman_mobileapp/screens/login_screen.dart';
import 'package:tips_and_tricks/main.dart';

Widget customDrawer(BuildContext context, Future<User?> futureUser) {
  void logout() async {
    final sessionCookie = await getSessionIdCookie();
    final response = await http.post(
        Uri.parse("https://temenin-isoman.herokuapp.com/user/logout"),
        headers: sessionCookie);

    if (response.statusCode == 200) {
      updateSessionId(response);
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Logout success!")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Logout failed!")));
    }
  }

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
        FutureBuilder<User?>(
          future: futureUser,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  ListTile(
                    title: Text(
                      snapshot.data!.username,
                      style: AppTheme.myTextTheme.bodyText1,
                    ),
                    leading: const Icon(Icons.person),
                  ),
                  ListTile(
                    title: Text(
                      "Log out",
                      style: AppTheme.myTextTheme.bodyText1,
                    ),
                    leading: const Icon(Icons.power_settings_new),
                    onTap: () => logout(),
                  ),
                ],
              );
            } else if (snapshot.hasError ||
                snapshot.connectionState == ConnectionState.done) {
              return ListTile(
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
              );
            } else {
              return ListTile(
                title: Text(
                  "Loading user...",
                  style: AppTheme.myTextTheme.bodyText1,
                ),
                leading: const CircularProgressIndicator(),
              );
            }
          },
        ),
      ],
    ),
  );
}
