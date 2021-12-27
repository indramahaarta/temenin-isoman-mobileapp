import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happy_notes/models/note.dart';

Widget NoteCard(BuildContext context, Note noteData) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              noteData.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            noteData.message,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: Text(
              "- by ${noteData.sender}",
              style: TextStyle(
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
