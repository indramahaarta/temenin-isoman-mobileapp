import 'package:flutter/material.dart';
import 'package:temenin_isoman_mobileapp/common/styles.dart';
import 'package:temenin_isoman_mobileapp/screens/home_screen.dart';
import 'package:tips_and_tricks/main.dart';

Widget category(BuildContext context) {
  return Column(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(
          top: 8,
          right: 16,
          left: 16,
          bottom: 4,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                top: 10.0,
              ),
              child: Text(
                "Features",
                style: AppTheme.myTextTheme.headline6?.copyWith(
                  fontSize: 22,
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 230,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            _categoryCard(
              "Bed Capacity",
              Icons.bed,
              const Color(0xfffa8c73),
              const Color(0xfffa9881),
              HomeScreen.routeName,
              context,
            ),
            _categoryCard(
              "Checklist",
              Icons.checklist,
              const Color(0xfffa8c73),
              const Color(0xfffa9881),
              HomeScreen.routeName,
              context,
            ),
            _categoryCard(
              "Deteksi Mandiri",
              Icons.sick_outlined,
              const Color(0xfffa8c73),
              const Color(0xfffa9881),
              HomeScreen.routeName,
              context,
            ),
            _categoryCard(
              "Emergency Contact",
              Icons.warning,
              const Color(0xfffa8c73),
              const Color(0xfffa9881),
              HomeScreen.routeName,
              context,
            ),
            _categoryCard(
              "Happy Notes",
              Icons.note_rounded,
              const Color(0xfffa8c73),
              const Color(0xfffa9881),
              HomeScreen.routeName,
              context,
            ),
            _categoryCard(
              "Tips And Tricks",
              Icons.lightbulb_outline,
              const Color(0xfffa8c73),
              const Color(0xfffa9881),
              TipsAndTricksListPage.routeName,
              context,
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _categoryCard(String title, IconData icon, Color color, Color lightColor,
    String route, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: AspectRatio(
      aspectRatio: 6 / 8,
      child: Container(
        height: 500,
        width: 500,
        margin: const EdgeInsets.only(
          left: 10,
          right: 10,
          bottom: 20,
          top: 10,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(
            Radius.circular(
              20,
            ),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: const Offset(4, 4),
              blurRadius: 10,
              color: lightColor.withOpacity(.8),
            )
          ],
        ),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              route,
            );
          },
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(
                20,
              ),
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: -20,
                  left: -20,
                  child: CircleAvatar(
                    backgroundColor: lightColor,
                    radius: 60,
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 40,
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 50.0,
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          title,
                          style: AppTheme.myTextTheme.headline5?.apply(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
