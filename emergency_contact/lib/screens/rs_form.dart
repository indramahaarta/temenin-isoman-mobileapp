import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:emergency_contact/common/styles.dart';
import 'package:emergency_contact/methods/add_rs.dart';
import 'package:emergency_contact/methods/get_daerah.dart';
import 'package:emergency_contact/models/rumah_sakit.dart';
import 'package:emergency_contact/models/daerah.dart';
import 'package:emergency_contact/screens/list_daerah.dart';
import 'package:emergency_contact/main.dart';
import 'package:http/http.dart' as http;

class RSForm extends StatefulWidget {
  static const routeName = '/rs-form';
  Daerah daerah;

  RSForm({Key? key, required this.daerah}) : super(key: key);

  @override
  _RSFormState createState() => _RSFormState();
}

class _RSFormState extends State<RSForm> {
  late String nama;
  late String alamat;
  late int telepon;

  final formKey = GlobalKey<FormState>();

  int? _value = 1;

  @override
  Widget build(BuildContext context) {
    print(widget.daerah.daerah);
    print(widget.daerah.pk);
    return Scaffold(
      appBar: AppBar(
        title: Text("Input RS Baru", style: myTextTheme.headline6),
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
                ElevatedButton(
                  child: Text('Submit'),
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      RumahSakit newRS = RumahSakit(
                          nama: nama,
                          alamat: alamat,
                          telepon: telepon,
                          daerah: widget.daerah.pk);
                      addNewRS(newRS).then((value) =>
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                            value,
                          ))));
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const ListDaerahPage();
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
