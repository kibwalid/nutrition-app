import 'dart:convert';
import 'package:latlong/latlong.dart';

AuthInfo authInfoFromJson(String str) => AuthInfo.fromJson(json.decode(str));

String authInfoToJson(AuthInfo data) => json.encode(data.toJson());

class AuthInfo {
  AuthInfo({this.userId, this.token, this.loggedLocation});

  String userId;
  String token;
  LatLng loggedLocation;

  factory AuthInfo.fromJson(Map<String, dynamic> json) => AuthInfo(
      userId: json["userID"],
      token: json["token"],
      loggedLocation: json['currentLocation']);

  Map<String, dynamic> toJson() => {
        "userID": userId,
        "token": token,
      };
}
