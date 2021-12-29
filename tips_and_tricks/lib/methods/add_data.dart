import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tips_and_tricks/models/article.dart';

Future<dynamic> addNewArtikel(Article artikel) async {
  var url = Uri.parse('https://temenin-isoman.herokuapp.com/tips-and-tricks/add-from-flutter');
  var response = await http.post(
    url,
    headers: {
      "Access-Control_Allow_Origin": "*",
      "Content-Type": "application/json; charset=utf-8",
    },
    body:jsonEncode(artikel)
  );
  return jsonDecode(response.body)["success"];
}
