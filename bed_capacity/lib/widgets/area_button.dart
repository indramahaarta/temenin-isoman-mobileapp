import 'package:bed_capacity/main.dart';
import 'package:flutter/material.dart';
import 'package:bed_capacity/models/area.dart';

Color areaBorderColor = Color(0xFFF5F5F5);
Color areaFillColor = Color(0xFFF5F5F5);

Widget buildAreaButton0(Area area) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(10.0),
    child: Container(
      width: 350.0,
      height: 50.0,
      color: areaFillColor,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(area.name, style: const TextStyle(color: Colors.black54)),
        ),
      ),
    ),
  );

}