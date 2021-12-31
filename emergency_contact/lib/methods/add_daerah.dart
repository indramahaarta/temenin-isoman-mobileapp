import 'dart:convert';
import 'package:emergency_contact/models/daerah.dart';
import 'package:http/http.dart' as http;
import 'package:emergency_contact/models/rumah_sakit.dart';

Future<dynamic> addNewDaerah(Daerah daerah) async {
  var url = Uri.parse(
      'https://temenin-isoman.herokuapp.com/emergency-contact/add-daerah-from-flutter');
  var response = await http.post(url,
      headers: {
        "Access-Control_Allow_Origin": "*",
        "Content-Type": "application/json; charset=utf-8",
      },
      body: jsonEncode(daerah));
  return jsonDecode(response.body)["success"];
}
