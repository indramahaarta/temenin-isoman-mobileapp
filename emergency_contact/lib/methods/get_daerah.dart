import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:emergency_contact/models/daerah.dart';

Future<List<Daerah>> fetchDaerah() async {
  var url = Uri.parse(
      'https://temenin-isoman.herokuapp.com/emergency-contact/daerah_json');
  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    },
  );

  var data = jsonDecode(utf8.decode(response.bodyBytes));
  List<Daerah> daerah = [];
  for (var i in data) {
    if (i != null) {
      daerah.add(Daerah.fromJson(i));
    }
  }

  return daerah;
}
