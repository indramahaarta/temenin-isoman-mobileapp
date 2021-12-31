import 'package:emergency_contact/models/daerah.dart';
import 'package:flutter/material.dart';
import 'package:temenin_isoman_mobileapp/models/user.dart';
import 'package:temenin_isoman_mobileapp/utils/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:temenin_isoman_mobileapp/widgets/custom_drawer.dart';
import 'package:emergency_contact/common/styles.dart';
import 'package:emergency_contact/screens/list_daerah.dart';
import 'package:emergency_contact/screens/rs_form.dart';
import 'package:emergency_contact/widget/scrollable_widget.dart';
import 'package:emergency_contact/models/rumah_sakit.dart';
import 'package:emergency_contact/widget/text_dialog_widget.dart';
// import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class ListRSPage extends StatefulWidget {
  static const routeName = '/list-rs';
  Daerah daerah;
  static const areaButtonColor = Color(0xFFEEEEEE);
  static const areaButtonActiveColor = Colors.pink;

  ListRSPage({Key? key, required this.daerah}) : super(key: key);

  @override
  _ListRSPageState createState() => _ListRSPageState();
}

class _ListRSPageState extends State<ListRSPage> {
  late Daerah daerah;
  late Future<List<RumahSakit>> listRS;
  RumahSakit? rsPilihan;
  late Future<User?> futureUser;

  Future<List<RumahSakit>> fetchRS() async {
    var url = Uri.parse(
        'https://temenin-isoman.herokuapp.com/bed-capacity/daerah_json/' +
            daerah.pk.toString());

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var rsObj = data.map((x) => RumahSakit.fromJson(x));
      List<RumahSakit> _listRS = [];

      for (var rs in rsObj) {
        _listRS.add(rs);
      }
      return _listRS;
    } else {
      throw Exception("failed to load Wilayah data");
    }
  }

  @override
  void initState() {
    super.initState();
    listRS = fetchRS();
    daerah = widget.daerah;
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
              child: Text("Emergency Contact", style: myTextTheme.headline5),
            )),
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
                        Widget cancelButton = TextButton(
                          child: const Text("Tidak",
                              style: TextStyle(color: Colors.pink)),
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                        );
                        Widget launchButton = TextButton(
                          child: const Text("Ya",
                              style: TextStyle(color: Colors.pink)),
                          onPressed: () {
                            // UrlLauncher.launch(('tel://119'));
                          },
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
                },
              ),
              FloatingActionButton(
                  backgroundColor: Color(0xFFF48FB1),
                  child: const Icon(Icons.add),
                  tooltip: 'Tambah RS Baru',
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
                                    Navigator.pushNamed(
                                      context,
                                      RSForm.routeName,
                                      arguments: daerah,
                                    );
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
            ],
          ),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              color: darkPrimaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Daftar Rumah Sakit di " + daerah.daerah,
                      style: myTextTheme.headline6,
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
                height: 1400.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: FutureBuilder<List<RumahSakit>>(
                        future: listRS,
                        builder: (context, snapshot) {
                          if (snapshot.data!.length == 0) {
                            return Text(
                                "Belum ada rumah sakit di " + daerah.daerah);
                          } else if (snapshot.hasData) {
                            var widgetRS = <Widget>[];

                            for (var rs in snapshot.data!) {
                              var button = Padding(
                                padding:
                                    const EdgeInsets.only(left: 35, bottom: 15),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      rsPilihan = rsPilihan == rs ? null : rs;
                                    });
                                  },
                                  child: itemRS(rs),
                                ),
                              );

                              widgetRS.add(button);
                            }

                            return Column(
                              children: widgetRS,
                            );
                          } else if (snapshot.hasError || !snapshot.hasData) {
                            return Text("Error");
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
                                                Colors.pink))),
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
  Widget itemRS(RumahSakit _rumahsakit) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        width: 330.0,
        color: rsPilihan == _rumahsakit
            ? ListRSPage.areaButtonActiveColor
            : ListRSPage.areaButtonColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              // Nama RS
              padding: EdgeInsets.only(left: 20.0, top: 14.0, right: 10.0),
              child: Text(
                _rumahsakit.nama,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: myTextTheme.button,
              ),
            ),
            Padding(
              // Alamat RS
              padding: EdgeInsets.only(left: 25.0, right: 10.0, top: 10.0),
              child: Row(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.local_hospital_sharp,
                        size: 16.0, color: Colors.grey),
                  ),
                  Expanded(
                    child: Text(
                      _rumahsakit.alamat,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style:
                          const TextStyle(fontSize: 10.0, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              // Telpon
              padding: EdgeInsets.only(left: 25.0, right: 10.0, top: 10.0),
              child: Row(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.call, size: 16.0, color: Colors.grey),
                  ),
                  Expanded(
                    child: Text(
                      _rumahsakit.telepon.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style:
                          const TextStyle(fontSize: 10.0, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
