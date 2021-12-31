import 'package:emergency_contact/models/daerah.dart';
import 'package:flutter/material.dart';
import 'package:temenin_isoman_mobileapp/models/user.dart';
import 'package:temenin_isoman_mobileapp/utils/user.dart';
import 'package:temenin_isoman_mobileapp/widgets/custom_drawer.dart';
import 'package:emergency_contact/common/styles.dart';
import 'package:emergency_contact/screens/list_daerah.dart';
import 'package:emergency_contact/screens/rs_form.dart';
import 'package:emergency_contact/methods/get_rs.dart';
import 'package:emergency_contact/widget/scrollable_widget.dart';
import 'package:emergency_contact/models/rumah_sakit.dart';
import 'package:emergency_contact/utils.dart';
import 'package:emergency_contact/widget/text_dialog_widget.dart';
// import 'package:url_launcher/url_launcher.dart';

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
              child: Text("Emergency Contact", style: myTextTheme.overline),
            )),
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
                      "Daftar Rumah Sakit di " + daerah.nama,
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
                          if (snapshot.hasData) {
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
                          } else if (snapshot.hasError) {
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
            Scaffold(
              floatingActionButton: FloatingActionButton(
                  child: const Icon(Icons.call),
                  tooltip: 'Telepon ' + rsPilihan!.nama,
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
                                content: Text(
                                    "Apakah Anda ingin langsung tersambung ke " +
                                        rsPilihan!.nama +
                                        "?"),
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
                  tooltip: 'Tambah Rumah Sakit Baru',
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
                                    return const RSForm();
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
