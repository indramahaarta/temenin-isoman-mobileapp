import 'package:http/http.dart' as http;
import 'package:obat/models/med.dart';
import 'dart:convert';

Future<List<Obat>> fetchObat() async {
  var url = Uri.parse('https://temenin-isoman.herokuapp.com/obat/json/');
  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    },
  );

  var data = jsonDecode(utf8.decode(response.bodyBytes));
  List<Obat> obatsData = [];
  for (var i in data) {
    if (i != null) {
      obatsData.add(Obat.fromJson(i));
    }
  }

  return obatsData;
}
