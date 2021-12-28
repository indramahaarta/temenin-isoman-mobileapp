import 'package:flutter/material.dart';

Widget stateInfo(String message, bool noData, IconData icon) {
  return Center(
    child: SingleChildScrollView(
      child: Column(
        children: [
          noData
              ? Icon(
                  icon,
                  size: 100,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              message,
            ),
          ),
        ],
      ),
    ),
  );
}
