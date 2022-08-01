// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:obat/methods/add_data.dart';
import 'package:obat/models/med.dart';
import 'package:obat/obat.dart';

class ObatForm extends StatefulWidget {
  const ObatForm({Key? key}) : super(key: key);

  @override
  _ObatFormState createState() => _ObatFormState();
}

class _ObatFormState extends State<ObatForm> {
  late String penyakit;
  late String penjelasan;
  late String daftar_obat;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text(
        'Add Symptomp',
        textAlign: TextAlign.center,
      ),
      content: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: formKey,
        child: Column(children: [
          TextFormField(
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return "Can not be empty";
              }
              penyakit = value!;
            },
            decoration: const InputDecoration(
              hintText: "Symptomp",
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return "Can not be empty";
              }
              penjelasan = value!;
            },
            decoration: const InputDecoration(
              hintText: "Explanation",
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return "Can not be empty";
              }
              daftar_obat = value!;
            },
            decoration: const InputDecoration(
              hintText: "Medicine",
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                Obat newObat = Obat(
                  penyakit: penyakit,
                  penjelasan: penjelasan,
                  daftar_obat: daftar_obat,
                );
                addNewObat(newObat).then((value) =>
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                      value,
                    ))));
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const ObatsPage();
                }));
              }
            },
            child: const Text(
              "Add",
              style: TextStyle(fontSize: 16),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green),
            ),
          ),
        ]),
      ),
    );
  }
}
