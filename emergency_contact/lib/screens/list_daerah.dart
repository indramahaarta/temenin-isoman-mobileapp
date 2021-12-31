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
import 'package:emergency_contact/screens/daerah_form.dart';
import 'package:emergency_contact/main.dart';

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
              child: Text("Emergency Contact", style: myTextTheme.overline),
            )),
        drawer: customDrawer(context, futureUser),
        body: ListView(
          children: <Widget>[
            Container(
              color: Colors.pink[900],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, top: 40.0, bottom: 5.0),
                    child: Text(
                      "Berikut adalah wilayah yang tersedia:",
                      style: myTextTheme.headline6,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0, bottom: 15.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.pink,
                        ),
                        onPressed: () {
                          if (chosen != null) {
                            Navigator.pushNamed(
                              context,
                              ListRSPage.routeName,
                              arguments: chosen,
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Mohon pilih wilayah anda terlebih dahulu!')),
                            );
                          }
                        },
                        child: const Text(
                          "Pilih wilayah",
                          style: TextStyle(color: darkPrimaryColor),
                        ),
                      ),
                    ),
                  ),
                ],
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
                        "Daftar Wilayah",
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
            Scaffold(
              floatingActionButton: FloatingActionButton(
                  child: const Icon(Icons.call),
                  tooltip: 'Telepon hotline utama Covid-19',
                  onPressed: () => {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              Widget cancelButton = TextButton(
                                child: const Text("Tidak"),
                                onPressed: () {},
                              );
                              Widget launchButton = TextButton(
                                child: const Text("Ya"),
                                onPressed: () {},
                                // onPressed: () => launch("tel://21213123123"),
                              );
                              return AlertDialog(
                                title: const Text("Hotline Covid-19 (119)"),
                                content: const Text(
                                    "Apakah Anda ingin langsung tersambung ke hotline utama Covid-19?"),
                                actions: [
                                  cancelButton,
                                  launchButton,
                                ],
                              );
                            })
                      }),
            ),
            Scaffold(
              floatingActionButton: FloatingActionButton(
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
                                      'Tambah RS Baru',
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
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.startFloat,
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
              child: Text(daerah.nama, style: myTextTheme.button),
            ),
          ],
        ),
      ),
    );
  }
}
