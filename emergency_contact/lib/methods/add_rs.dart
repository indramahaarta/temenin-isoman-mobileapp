import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:emergency_contact/models/rumah_sakit.dart';

Future<dynamic> addNewRS(RumahSakit rumahsakit) async {
  var url = Uri.parse(
      'https://temenin-isoman.herokuapp.com/emergency-contact/add-rs-from-flutter');
  var response = await http.post(url,
      headers: {
        "Access-Control_Allow_Origin": "*",
        "Content-Type": "application/json; charset=utf-8",
      },
      body: jsonEncode(rumahsakit));
  return jsonDecode(response.body)["success"];
}
