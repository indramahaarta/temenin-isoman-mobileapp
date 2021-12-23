import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:temenin_isoman_mobileapp/models/user.dart';
import 'package:temenin_isoman_mobileapp/utils/session.dart';

Future<User?> fetchUser() async {
  final sessionCookie = await getSessionIdCookie();
  final response = await http.post(
      Uri.parse("https://temenin-isoman.herokuapp.com/user/"),
      headers: sessionCookie);

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body)["data"]);
  } else {
    return null;
  }
}
