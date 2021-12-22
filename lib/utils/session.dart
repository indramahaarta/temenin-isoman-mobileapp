import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// Adapted from https://stackoverflow.com/questions/52241089/how-do-i-make-an-http-request-using-cookies-on-flutter
void updateSessionId(http.Response response) {
  // Get cookie from response
  String? rawCookie = response.headers["set-cookie"];
  if (rawCookie == null) return;

  rawCookie.split(",").forEach((cookie) {
    if (!cookie.startsWith("sessionid")) return;
    String sessionId = cookie.split(";")[0].split("=")[1];
    _saveSessionId(sessionId);
  });
}

Future<String?> getSessionId() {
  return _readSessionId();
}

Future<Map<String, String>> getSessionIdCookie() async {
  String? sessionId = await getSessionId();
  if (sessionId == null) return {};

  return {"cookie": "sessionid=$sessionId"};
}

Future<String?> _readSessionId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString("sessionId");
}

void _saveSessionId(String sessionId) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString("sessionId", sessionId);
}
