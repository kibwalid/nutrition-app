import 'dart:convert';
import 'package:fitness/config/constants.dart';
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

  Future<dynamic> get(String apiUri, String token) async {
    String responseString = "";
    final response = await http
        .get(Uri.parse(apiUri), headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      responseString = response.body;
      if (responseString.isNotEmpty) {
        return responseString;
      } else {
        return {'message': 'No data from response string, see http.get'};
      }
    } else {
      responseString = response.body;
      Map info = jsonDecode(responseString);
      print(info);
      return info;
    }
  }

  Future<dynamic> getFromCN(String query) async {
    String responseString = "";
    final response = await http.get(
        Uri.parse("https://api.calorieninjas.com/v1/nutrition?query=$query"),
        headers: {'X-Api-Key': CN_API_URI});
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

  Future<dynamic> getFromWeather(String query) async {
    String responseString = "";
    String apiKey = "301bdd5089fb4b0ab5d91616210508";
    final response = await http.get(Uri.parse(
        "http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$query"));
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

  Future<dynamic> postWithToken(
      String apiUri, String token, Map<String, dynamic> jsonData) async {
    String responseString = "";
    final response = await http.post(
      Uri.parse(apiUri),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
      body: json.encode(jsonData),
    );

    if (response.statusCode == 200) {
      responseString = response.body;
      dynamic info = jsonDecode(responseString);
      return info;
    } else {
      responseString = response.body;
      Map info = jsonDecode(responseString);
      return info;
    }
  }
}
