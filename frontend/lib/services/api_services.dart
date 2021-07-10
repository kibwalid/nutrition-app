import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  Future<dynamic> post(Map<String, dynamic> jsonData, String apiUri) async {
    String responseString = "";
    final response = await http.post(Uri.parse(apiUri),
        headers: {"Content-Type": "application/json"},
        body: json.encode(jsonData));

    if (response.statusCode == 200) {
      responseString = response.body;
      Map info = jsonDecode(responseString);
      return info;
    } else {
      responseString = response.body;
      Map info = jsonDecode(responseString);
      return info;
    }
  }
}
