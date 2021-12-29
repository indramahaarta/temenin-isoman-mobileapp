import 'package:bed_capacity/main.dart';
import 'package:flutter/material.dart';
import 'package:bed_capacity/models/hospital.dart';

Widget buildHospitalButton(BuildContext context, Hospital hospital) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(
        context,
        BedRequestForm.routeName,
        arguments: hospital,
      );
    },
    child: Container(
        child: Text(hospital.nama)
    ),
  );
}