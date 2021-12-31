import 'package:flutter/material.dart';
import 'package:temenin_isoman_mobileapp/models/user.dart';
import 'package:temenin_isoman_mobileapp/utils/user.dart';
import 'package:temenin_isoman_mobileapp/widgets/custom_drawer.dart';
import 'package:obat/models/med.dart';
import 'package:obat/methods/get_data.dart';
import 'package:obat/widgets/scroll_behavior.dart';
import 'package:obat/widgets/state_info.dart';
import 'package:obat/widgets/obat_card.dart';
import 'package:obat/widgets/obat_form.dart';

class ObatsPage extends StatefulWidget {
  static const routeName = '/symptomp';
  const ObatsPage({Key? key}) : super(key: key);

  @override
  _ObatsPageState createState() => _ObatsPageState();
}

class _ObatsPageState extends State<ObatsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  late Future<User?> futureUser;
  Color color = Colors.white;

  @override
  void initState() {
    super.initState();
    futureUser = fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: customDrawer(context, futureUser),
      body: SafeArea(
        bottom: false,
        top: false,
        child: Container(
          padding: const EdgeInsets.only(
            top: 80,
            left: 8,
            right: 8,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Center(
              child: Container(
                padding: const EdgeInsets.only(left: 22, right: 22),
                child: const Text(
                  "Symptomps And Medicine",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              ),
              onPressed: () => _scaffoldKey.currentState!.openDrawer(),
            ),
            // cards view
            Expanded(
              child: FutureBuilder<List<Obat>>(
                  future: fetchObat(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final List<Obat>? obats = snapshot.data;
                      if (obats?.isNotEmpty ?? false) {
                        return ScrollConfiguration(
                          behavior: ScrollPageBehavior(),
                          child: ListView(
                            children: List.generate(obats!.length, (index) {
                              return obatCard(context, obats[index]);
                            }),
                          ),
                        );
                      } else {
                        return stateInfo("No symptomps available", true,
                            Icons.search_off_rounded);
                      }
                    } else {
                      return stateInfo(
                          "Loading", false, Icons.search_off_rounded);
                    }
                  }),
            )
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
        ),
        onPressed: () => {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return FutureBuilder(
                  future: futureUser,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return const ObatForm();
                    }
                    return const AlertDialog(
                      scrollable: true,
                      title: Text(
                        'Add Symptomp',
                        textAlign: TextAlign.center,
                      ),
                      content: Text(
                        "Please login to add symptomp",
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                );
              }),
        },
        backgroundColor: Colors.green,
        tooltip: 'Add New Symptomp',
      ),
    );
  }
}
