import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:temenin_isoman_mobileapp/widgets/custom_drawer.dart';
import 'package:tips_and_tricks/common/styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Temenin Isoman"),
          backgroundColor: primaryColor,
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
        drawer: customDrawer(context),
        body: const Center(
          child: Text(
            'My Page!',
          ),
        ),
      ),
    );
  }
}
