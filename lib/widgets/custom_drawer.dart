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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'Temenin Isoman',
                        style: AppTheme.myTextTheme.headline5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          height: 20,
        ),
        _drawerTile(
          context,
          "Home Page",
          Icons.home,
          HomeScreen.routeName,
        ),
        _drawerTile(
          context,
          "Bed Capacity",
          Icons.bed,
          HomeScreen.routeName,
        ),
        _drawerTile(
          context,
          "Checklist",
          Icons.checklist,
          HomeScreen.routeName,
        ),
        _drawerTile(
          context,
          "Deteksi Mandiri",
          Icons.sick_outlined,
          HomeScreen.routeName,
        ),
        _drawerTile(
          context,
          "Emergency Contact",
          Icons.warning,
          HomeScreen.routeName,
        ),
        _drawerTile(
          context,
          "Happy Notes",
          Icons.note_rounded,
          HomeScreen.routeName,
        ),
        _drawerTile(
          context,
          "Tips And Tricks",
          Icons.lightbulb_outline,
          TipsAndTricksListPage.routeName,
        ),
        Container(
          height: 20,
        ),
        FutureBuilder<User?>(
          future: futureUser,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  const Divider(
                    thickness: 1.5,
                    color: AppTheme.primaryColor,
                  ),
                  ListTile(
                    title: Text(
                      snapshot.data!.username,
                      style: AppTheme.myTextTheme.bodyText1,
                    ),
                    leading: const Icon(
                      Icons.person,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  Container(
                    color: AppTheme.primaryColor,
                    child: ListTile(
                      title: Text(
                        "Log out",
                        style: AppTheme.myTextTheme.bodyText1?.apply(
                          color: Colors.white,
                        ),
                      ),
                      leading: const Icon(
                        Icons.power_settings_new,
                        color: Colors.white,
                      ),
                      onTap: () => logout(),
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError ||
                snapshot.connectionState == ConnectionState.done) {
              return Container(
                color: AppTheme.primaryColor,
                child: ListTile(
                  title: Text(
                    "Login",
                    style: AppTheme.myTextTheme.bodyText1?.apply(
                      color: Colors.white,
                    ),
                  ),
                  leading: const Icon(
                    Icons.login,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      LoginScreen.routeName,
                    );
                  },
                ),
              );
            } else {
              return ListTile(
                title: Text(
                  "Loading user...",
                  style: AppTheme.myTextTheme.bodyText1,
                ),
                leading: const CircularProgressIndicator(
                  color: AppTheme.primaryColor,
                ),
              );
            }
          },
        ),
      ],
    ),
  );
}

Widget _drawerTile(
  BuildContext context,
  String text,
  IconData icon,
  String route,
) {
  return ListTile(
    title: Text(
      text,
    ),
    leading: Icon(
      icon,
      color: AppTheme.primaryColor,
    ),
    onTap: () {
      Navigator.pushNamed(
        context,
        route,
      );
    },
  );
}
