import 'package:emergency_contact/models/daerah.dart';
import 'package:emergency_contact/models/rumah_sakit.dart';
import 'package:flutter/material.dart';
import 'package:temenin_isoman_mobileapp/models/user.dart';
import 'package:temenin_isoman_mobileapp/utils/user.dart';
import 'package:temenin_isoman_mobileapp/widgets/custom_drawer.dart';
import 'package:emergency_contact/common/styles.dart';
import 'package:emergency_contact/methods/get_daerah.dart';
import 'package:emergency_contact/models/daerah.dart';
import 'package:emergency_contact/screens/list_rs.dart';
import 'package:emergency_contact/screens/list_rs_dummies.dart';
import 'package:emergency_contact/screens/daerah_form.dart';
import 'package:emergency_contact/main.dart';
// import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class ListDaerahPage extends StatefulWidget {
  static const routeName = '/list-daerah';
  static const areaButtonColor = Colors.amber;
  static const areaButtonActiveColor = Colors.pink;

  const ListDaerahPage({Key? key}) : super(key: key);

  @override
  _ListDaerahPageState createState() => _ListDaerahPageState();
}

class _ListDaerahPageState extends State<ListDaerahPage> {
  late Future<List<Daerah>> listDaerah;
  late Future<User?> futureUser;
  Daerah? chosen;

  @override
  void initState() {
    super.initState();
    listDaerah = fetchDaerah();
    futureUser = fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: darkPrimaryColor,
        appBar: AppBar(
            backgroundColor: darkPrimaryColor,
            title: Center(
              child: Text("List Daerah", style: myTextTheme.headline5),
            )),
        drawer: customDrawer(context, futureUser),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FloatingActionButton(
                backgroundColor: Color(0xFFF48FB1),
                child: const Icon(Icons.call),
                tooltip: 'Telepon hotline utama Covid-19',
                onPressed: () => {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return FutureBuilder(
                          future: futureUser,
                          builder: (context, snapshot) {
                            Widget cancelButton = TextButton(
                              child: const Text("Tidak",
                                  style: TextStyle(color: Colors.pink)),
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                              },
                            );
                            Widget launchButton = TextButton(
                              child: const Text("Ya",
                                  style: TextStyle(color: Colors.pink)),
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                                // UrlLauncher.launch(('tel://119'));
                              },
                            );
                            if (!snapshot.hasData) {
                              return const AlertDialog(
                                scrollable: true,
                                title: Text(
                                  'Hotline Covid-19',
                                  textAlign: TextAlign.center,
                                ),
                                content: Text(
                                  "Login agar dapat terhubung ke hotline utama Covid-19.",
                                  textAlign: TextAlign.center,
                                ),
                              );
                            }
                            return AlertDialog(
                              scrollable: true,
                              title: const Text("Hotline Covid-19 (119)"),
                              content: const Text(
                                  "Apakah Anda ingin langsung tersambung ke hotline utama Covid-19?"),
                              actions: [
                                cancelButton,
                                launchButton,
                              ],
                            );
                          },
                        );
                      }),
                },
              ),
              FloatingActionButton(
                  backgroundColor: Color(0xFFF48FB1),
                  child: const Icon(Icons.add),
                  tooltip: 'Tambah Daerah Baru',
                  onPressed: () => {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return FutureBuilder(
                                future: futureUser,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData &&
                                      ((snapshot.data as User).roles.contains(
                                              "fasilitas_kesehatan") ||
                                          (snapshot.data as User)
                                              .roles
                                              .contains("admin"))) {
                                    return const DaerahForm();
                                  }
                                  return const AlertDialog(
                                    scrollable: true,
                                    title: Text(
                                      'Tambah Daerah Baru',
                                      textAlign: TextAlign.center,
                                    ),
                                    content: Text(
                                      "Anda bukan fasilitas kesehatan.",
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                },
                              );
                            }),
                      }),
            ],
          ),
        ),
        body: ListView(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(150, 30),
                    maximumSize: const Size(150, 30),
                    primary: Colors.white,
                  ),
                  child: const Text(
                    "LIHAT LIST RS",
                    style: TextStyle(color: darkPrimaryColor, fontSize: 10),
                  ),
                  onPressed: () {
                    if (chosen != null) {
                      print(chosen!.daerah);
                      print(chosen!.pk);
                      Navigator.pushNamed(
                        context,
                        ListRSDummies.routeName,
                        arguments: chosen,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Anda belum memilih daerah')),
                      );
                    }
                  },
                ),
              ),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0),
              ),
              child: Container(
                color: Colors.white,
                height: 700.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 40, top: 30, bottom: 30),
                      child: Text(
                        "Silakan pilih wilayah:",
                        style: myTextTheme.headline6,
                      ),
                    ),
                    Container(
                      child: FutureBuilder<List<Daerah>>(
                        future: listDaerah,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var widgetDaerah = <Widget>[];

                            for (var _daerah in snapshot.data!) {
                              var button = Padding(
                                padding:
                                    const EdgeInsets.only(left: 35, bottom: 15),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      chosen =
                                          chosen == _daerah ? null : _daerah;
                                    });
                                  },
                                  child: itemDaerah(_daerah),
                                ),
                              );

                              widgetDaerah.add(button);
                            }

                            return Column(
                              children: widgetDaerah,
                            );
                          } else if (snapshot.hasError) {
                            return const Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.only(top: 100.0),
                                child: Text("Error"),
                              ),
                            );
                          }
                          return Align(
                            alignment: Alignment.center,
                            child: Column(
                              children: const [
                                Padding(
                                    padding: EdgeInsets.only(top: 100.0),
                                    child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                darkPrimaryColor))),
                                Padding(
                                    padding: EdgeInsets.only(top: 20.0),
                                    child: Text('Loading')),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget itemDaerah(Daerah daerah) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        width: 270.0,
        height: 50.0,
        color: chosen == daerah
            ? ListDaerahPage.areaButtonActiveColor
            : ListDaerahPage.areaButtonColor,
        child: Row(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(daerah.daerah, style: myTextTheme.button),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
