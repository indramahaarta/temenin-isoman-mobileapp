import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:happy_notes/models/note.dart';

Future<dynamic> addNewNote(Note noteData) async {
  var url = Uri.parse(
      'https://temenin-isoman.herokuapp.com/happy-notes/add-from-flutter');
  var response = await http.post(url,
      headers: {
        "Access-Control_Allow_Origin": "*",
        "Content-Type": "application/json; charset=utf-8",
      },
      body: jsonEncode(noteData));
  return jsonDecode(response.body)["success"];
}
