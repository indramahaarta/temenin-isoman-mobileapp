import 'package:flutter/material.dart';
import 'package:happy_notes/models/note.dart';

Widget noteCard(BuildContext context, Note noteData) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              noteData.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            noteData.message,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: Text(
              "- by ${noteData.sender}",
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          ), // msg
        ],
      ),
    ),
  );
}
