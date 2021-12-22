import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:temenin_isoman_mobileapp/models/user.dart';

import 'package:temenin_isoman_mobileapp/common/styles.dart';
import 'package:temenin_isoman_mobileapp/utils/session.dart';
import 'package:temenin_isoman_mobileapp/widgets/custom_drawer.dart';
import 'package:temenin_isoman_mobileapp/widgets/member_card.dart';
import 'package:temenin_isoman_mobileapp/widgets/module_card.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<User?> futureUser;

  Future<User?> fetchUser() async {
    final sessionCookie = await getSessionIdCookie();
    final response = await http.post(
        Uri.parse("https://temenin-isoman.herokuapp.com/user/"),
        headers: sessionCookie);

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body)["data"]);
    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    futureUser = fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Temenin Isoman"),
          backgroundColor: AppTheme.primaryColor,
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(
                  Icons.short_text,
                  size: 30,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ),
        drawer: customDrawer(context, futureUser),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  category(context),
                ],
              ),
            ),
            memberCard(context),
          ],
        ),
      ),
    );
  }
}
