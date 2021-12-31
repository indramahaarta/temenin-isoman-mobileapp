import 'package:flutter/material.dart';
import 'package:obat/models/med.dart';

Widget obatCard(BuildContext context, Obat obatData) {
  return Card(
      child: Container(
    width: 250,
    height: 210,
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Colors.indigo.shade50,
      elevation: 20,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(" "),
          Text(obatData.penyakit + "\n"),
          Text(obatData.penjelasan + "\n"),
          Text("obat: ${obatData.daftar_obat}"),
          Text(" "),
        ],
      ),
    ),
  ));
}
