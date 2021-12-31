import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:obat/models/med.dart';

Future<dynamic> addNewObat(Obat obatData) async {
  var url =
      Uri.parse('https://temenin-isoman.herokuapp.com/obat/add-from-flutter');
  var response = await http.post(url,
      headers: {
        "Access-Control_Allow_Origin": "*",
        "Content-Type": "application/json; charset=utf-8",
      },
      body: jsonEncode(obatData));
  return jsonDecode(response.body)["success"];
}
