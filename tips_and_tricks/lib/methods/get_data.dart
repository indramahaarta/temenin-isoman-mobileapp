import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tips_and_tricks/models/article.dart';

Future<List<Article>> fetchArtikel(String query) async {
  var url = Uri.parse('https://temenin-isoman.herokuapp.com/tips-and-tricks/search-json?q=$query');
  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    },
  );

  var data = jsonDecode(utf8.decode(response.bodyBytes));
  List<Article> artikel = [];
  for (var d in data) {
    if (d != null) {
      artikel.add(Article.fromJson(d));
    }
  }

  return artikel;
}