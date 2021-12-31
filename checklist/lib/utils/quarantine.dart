import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:temenin_isoman_mobileapp/utils/session.dart';
import 'package:checklist/models/quarantine.dart';

Future<Quarantine?> fetchQuarantine() async {
  final sessionCookie = await getSessionIdCookie();
  final response = await http.post(
      Uri.parse(
          "http://temenin-isoman.herokuapp.com/checklist/quarantine-data"),
      headers: sessionCookie);

  if (response.statusCode == 200) {
    return Quarantine.fromJson(jsonDecode(response.body));
  } else {
    return null;
  }
}

Future<bool> startQuarantine() async {
  final sessionCookie = await getSessionIdCookie();
  final response = await http.post(
      Uri.parse("http://temenin-isoman.herokuapp.com/checklist/start"),
      headers: sessionCookie);

  return response.statusCode == 200;
}
