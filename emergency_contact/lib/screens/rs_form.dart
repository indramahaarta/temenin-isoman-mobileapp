import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:emergency_contact/common/styles.dart';
import 'package:emergency_contact/methods/add_rs.dart';
import 'package:emergency_contact/methods/get_daerah.dart';
import 'package:emergency_contact/models/rumah_sakit.dart';
import 'package:emergency_contact/models/daerah.dart';
import 'package:emergency_contact/main.dart';

class RSForm extends StatefulWidget {
  static const routeName = '/rs-form';

  const RSForm({Key? key}) : super(key: key);

  @override
  _RSFormState createState() => _RSFormState();
}

class _RSFormState extends State<RSForm> {
  late String nama;
  late String alamat;
  late int daerah;
  late int telepon;
  Future<List<Daerah>> futureDaerah = fetchDaerah();

  final formKey = GlobalKey<FormState>();

  int? _value = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Input RS Baru"),
        backgroundColor: Colors.pink,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: new InputDecoration(
                      hintText: "contoh: RS Harapan Keluarga",
                      labelText: "Nama RS",
                      icon: Icon(Icons.local_hospital),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Nama RS tidak boleh kosong';
                      }
                      nama = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    obscureText: true,
                    decoration: new InputDecoration(
                      labelText: "Alamat",
                      icon: Icon(Icons.location_city),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Alamat tidak boleh kosong';
                      }
                      alamat = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: new InputDecoration(
                      hintText: "contoh: 0812xxxxxxx",
                      labelText: "Nomor Telepon",
                      icon: Icon(Icons.phone),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Nomor telepon tidak boleh kosong';
                      }
                      telepon = int.parse(value);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Pilih Daerah:', textAlign: TextAlign.left),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder<List<Daerah>>(
                    future: futureDaerah,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var listDaerah = <Daerah>[];
                        for (Daerah daerah in snapshot.data!) {
                          listDaerah.add(daerah);
                        }
                        return DropdownButton(
                          items: listDaerah.map((loc) {
                            return DropdownMenuItem(
                              child: Text(loc.nama),
                              value: loc.pk,
                            );
                          }).toList(),
                          value: _value,
                          onChanged: (int? newValue) {
                            setState(() {
                              _value = newValue;
                            });
                          },
                        );
                      }
                      return Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: const [
                            Padding(
                                padding: EdgeInsets.only(top: 20.0),
                                child: Text('Belum ada wilayah')),
                          ],
                        ),
                      );
                    },
                  ),
                  // child: DropdownButton(
                  //   dropDownButton
                ),
                ElevatedButton(
                  child: Text('Submit'),
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      RumahSakit newRS = RumahSakit(
                          nama: nama,
                          alamat: alamat,
                          telepon: telepon,
                          daerah: daerah);
                      addNewRS(newRS).then((value) =>
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                            value,
                          ))));
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const EmergencyContactPage();
                      }));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.pink,
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                      textStyle:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
