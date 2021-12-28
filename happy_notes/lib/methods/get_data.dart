import 'package:http/http.dart' as http;
import 'package:happy_notes/models/note.dart';
import 'dart:convert';

Future<List<Note>> fetchNote() async {
  var url = Uri.parse(
    'https://temenin-isoman.herokuapp.com/happy-notes/notes-json',
  );
  var response = await http.get(
    url,
    headers: {
      // ngatur perizinan
      "Access-Control-Allow-Origin": "*",
      // memberi tau type datanya adalah json
      "Content-Type": "application/json",
    },
  );

  // decode dari json ke struktur data map
  var data = jsonDecode(utf8.decode(response.bodyBytes));
  List<Note> notesData = [];
  // add data to notes
  for (var i in data) {
    if (i != null) {
      notesData.add(Note.fromJson(i));
    }
  }

  return notesData;
}
