import 'package:bed_capacity/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bed_capacity/models/models.dart';
import 'package:bed_capacity/common/styles.dart';

class HospitalList extends StatefulWidget {
  static const String routeName = '/hospital_list';
  final Area area;
  static const areaButtonColor = Color(0xFFEEEEEE);
  static const areaButtonActiveColor = Color(0xFFFFF4D4);

  const HospitalList({Key? key, required this.area}) : super(key: key);

  @override
  _HospitalListState createState() => _HospitalListState();
}

class _HospitalListState extends State<HospitalList> {
  late Area area;
  late Future<List<Hospital>> _hospitals;
  Hospital? choice;

  // Hospital data fetcher
  Future<List<Hospital>> _fetchHospital() async {
    var url = Uri.parse(
        'https://temenin-isoman.herokuapp.com/bed-capacity/bed_data_json/wil/' + area.pk.toString());

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var hospitalObjects = data.map((x) => Hospital.fromJson(x));
      List<Hospital> hospitals = [];

      for (var hospital in hospitalObjects) {
        hospitals.add(hospital);
      }
      return hospitals;
    }
    else {
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
            )
        ),
        body: ListView(
          children: <Widget> [
            Container(
              color: darkPrimaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, top: 40.0, bottom: 5.0),
                    child: Text(
                      "Silakan Pilih\nRumah Sakit",
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
                              BedRequestForm.routeName,
                              arguments: choice,
                            );
                          }
                          else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Mohon pilih rumah sakit terlebih dahulu!')),
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
                height: 1400.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget> [
                    Padding(
                      padding: const EdgeInsets.only(left: 40, top: 30, bottom: 30),
                      child: Text(
                        "Daftar Rumah Sakit di " + area.name,
                        style: myTextTheme.headline6,
                      ),
                    ),
                    FutureBuilder<List<Hospital>>(
                      future: _hospitals,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var widgets = <Widget>[];

                          for (var hospital in snapshot.data!) {
                            var button = Padding(
                              padding: const EdgeInsets.only(left: 35, bottom: 15),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    choice = choice == hospital ? null : hospital;
                                  });
                                },
                                child: buildHospitalButton(hospital),
                              ),
                            );

                            widgets.add(button);
                          }

                          return Column(
                            children: widgets,
                          );
                        }
                        else if (snapshot.hasError) {
                          return const Text("gagal");
                        }
                        return Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: const [
                              Padding(
                                  padding: EdgeInsets.only(top:100.0),
                                  child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(darkPrimaryColor))),
                              Padding(padding: EdgeInsets.only(top: 20.0) ,child: Text('Mengambil Data Rumah Sakit')),
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
    area = widget.area;
    _hospitals = _fetchHospital();
  }

  Widget buildHospitalButton(Hospital hospital) {
    var container = Container(
      width: 330.0,
      color: choice == hospital ? HospitalList.areaButtonActiveColor : HospitalList.areaButtonColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding( // Nama RS
            padding: const EdgeInsets.only(left: 20.0, top: 14.0, right: 10.0),
            child: Text(
              hospital.nama,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: myTextTheme.button,
            ),
          ),
          Padding( // Alamat RS
            padding: const EdgeInsets.only(left: 25.0, right: 10.0, top: 10.0),
            child: Row(
              children: <Widget> [
                const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.local_hospital_sharp, size: 16.0, color: Colors.grey),
                ),
                Expanded(
                  child: Text(
                    hospital.alamat,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 10.0, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
          Padding( // Telpon
            padding: const EdgeInsets.only(left: 25.0, right: 10.0, top: 10.0),
            child: Row(
              children: <Widget> [
                const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.phone, size: 16.0, color: Colors.grey),
                ),
                Expanded(
                  child: Text(
                    hospital.telp,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 10.0, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
          Padding( // Isi / Kapasitas
            padding: const EdgeInsets.only(left: 25.0, right: 10.0, top: 10.0, bottom: 20.0),
            child: Row(
              children: <Widget> [
                const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.reduce_capacity_sharp, size: 16.0, color: Colors.grey),
                ),
                Expanded(
                  child: Text(
                    "telah terisi " + hospital.isi.toString()
                    + " dari kapasitas total " + hospital.kapasitas.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 10.0, color: Colors.grey),
                  ),
                ),
              ],
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


