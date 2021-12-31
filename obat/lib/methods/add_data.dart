import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:obat/models/med.dart';

Future<dynamic> addNewObat(Obat obatData) async {
  var url =
      Uri.parse('https://temenin-isoman.herokuapp.com/obat/add-from-flutter');
  Map<String, String> data = {
    "penyakit": obatData.penyakit,
    "penjelasan": obatData.penjelasan,
    "daftar_obat": obatData.daftar_obat,
  };
  var response = await http.post(url,
      headers: {
        "Access-Control_Allow_Origin": "*",
        "Content-Type": "application/json; charset=utf-8",
      },
      body: jsonEncode(data));
  if (response.statusCode == 200) {
    return ("berhasil submit data");
  } else {
    return ("gagal submit data");
  }
}
