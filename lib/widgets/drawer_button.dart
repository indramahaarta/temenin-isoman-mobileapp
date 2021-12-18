import 'package:flutter/material.dart';
import 'package:temenin_isoman_mobileapp/common/styles.dart';

Widget drawerButton(BuildContext context, String title, IconData icon, String route){
  return ListTile(
    title:  Text(
      title,
      style: AppTheme.myTextTheme.bodyText1,
    ),
    leading: Icon(icon),
    onTap: () {
      Navigator.pushNamed(
        context,
        route,
      );
    },
  );
}