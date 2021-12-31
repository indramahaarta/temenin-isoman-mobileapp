import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:emergency_contact/common/styles.dart';
import 'package:emergency_contact/methods/add_daerah.dart';
import 'package:emergency_contact/models/daerah.dart';
import 'package:emergency_contact/main.dart';

class DaerahForm extends StatefulWidget {
  static const routeName = '/daerah-form';

  const DaerahForm({Key? key}) : super(key: key);

  @override
  _DaerahFormState createState() => _DaerahFormState();
}

class _DaerahFormState extends State<DaerahForm> {
  late String nama;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Input Daerah Baru"),
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
                      hintText: "contoh: Cikarang Baru",
                      labelText: "Daerah",
                      icon: Icon(Icons.add_location_alt),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Nama Daerah tidak boleh kosong';
                      }
                      nama = value;
                    },
                  ),
                ),
                ElevatedButton(
                  child: Text('Submit'),
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      Daerah newDareah = Daerah(nama: nama, pk: 1);
                      addNewDaerah(newDareah).then((value) =>
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
