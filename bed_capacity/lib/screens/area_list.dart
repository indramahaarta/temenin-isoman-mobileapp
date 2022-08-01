import 'package:flutter/material.dart';
import 'package:bed_capacity/models/area.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bed_capacity/common/styles.dart';
import 'package:bed_capacity/screens/hospital_list.dart';
import 'package:temenin_isoman_mobileapp/widgets/custom_drawer.dart';
import 'package:temenin_isoman_mobileapp/utils/user.dart';
import 'package:temenin_isoman_mobileapp/models/user.dart';

class AreaList extends StatefulWidget {
  static const routeName = '/area_list';

  static const areaButtonColor = Color(0xFFEEEEEE);
  static const areaButtonActiveColor = Color(0xFFFFF4D4);

  const AreaList({Key? key}) : super(key: key);

  @override
  _AreaListState createState() => _AreaListState();
}

class _AreaListState extends State<AreaList> {
  late Future<List<Area>> _areas;
  late Future<User?> futureUser;
  String debugger = 'test';
  Map<int, Area> areaObjects = <int, Area>{};
  Area? choice;

  // Wilayah data fetcher
  Future<List<Area>> _fetchWilayah() async {
    var url = Uri.parse(
        'https://temenin-isoman.herokuapp.com/bed-capacity/wilayah_json');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var areaObjects = data.map((x) => Area.fromJson(x));
      List<Area> areas = [];

      for (var area in areaObjects) {
        areas.add(area);
      }
      return areas;
    } else {
      throw Exception("failed to load Wilayah data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: darkPrimaryColor,
        appBar: AppBar(
            backgroundColor: darkPrimaryColor,
            title: Center(
              child: Text("Bed Request", style: myTextTheme.overline),
            )),
        drawer: customDrawer(context, futureUser),
        body: ListView(
          children: <Widget>[
            Container(
              color: darkPrimaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, top: 40.0, bottom: 5.0),
                    child: Text(
                      "Silakan Pilih\nWilayah",
                      style: myTextTheme.headline5,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0, bottom: 15.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: btnColor,
                        ),
                        onPressed: () {
                          if (choice != null) {
                            Navigator.pushNamed(
                              context,
                              HospitalList.routeName,
                              arguments: choice,
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
                          "PILIH",
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
                      child: FutureBuilder<List<Area>>(
                        future: _areas,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var widgets = <Widget>[];

                            for (var area in snapshot.data!) {
                              var button = Padding(
                                padding:
                                    const EdgeInsets.only(left: 35, bottom: 15),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      choice = choice == area ? null : area;
                                    });
                                  },
                                  child: buildAreaButton(area),
                                ),
                              );

                              widgets.add(button);
                            }

                            return Column(
                              children: widgets,
                            );
                          } else if (snapshot.hasError) {
                            return const Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.only(top: 100.0),
                                child: Text("Terjadi Error"),
                              ),
                            );

                            widgets.add(button);
                          }

                          return Column(
                            children: widgets,
                          );
                        }
                        else if (snapshot.hasError) {
                          return const Align(
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
                                    child: Text('Mengambil Data Wilayah')),
                              ],
                            ),
                          );
                        }
                        return Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(top:100.0),
                                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(darkPrimaryColor))),
                              Padding(padding: EdgeInsets.only(top: 20.0) ,child: Text('Mengambil Data Wilayah')),
                            ],
                          ),
                        );
                      },
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
  void initState() {
    super.initState();
    _areas = _fetchWilayah();
    futureUser = fetchUser();
  }

  // Widget Builder
  Widget buildAreaButton(Area area) {
    var container = Container(
      width: 320.0,
      height: 50.0,
      color: choice == area
          ? AreaList.areaButtonActiveColor
          : AreaList.areaButtonColor,
      child: Row(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Icon(
              Icons.arrow_forward_ios_sharp,
              size: 15.0,
              color: Colors.grey,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(area.name, style: myTextTheme.button),
            ),
          ),
        ],
      ),
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: container,
    );
  }
}
