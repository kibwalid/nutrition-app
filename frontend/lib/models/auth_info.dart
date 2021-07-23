import 'dart:convert';

AuthInfo authInfoFromJson(String str) => AuthInfo.fromJson(json.decode(str));

String authInfoToJson(AuthInfo data) => json.encode(data.toJson());

class AuthInfo {
  AuthInfo({
    this.userId,
    this.token,
  });

  String userId;
  String token;

  factory AuthInfo.fromJson(Map<String, dynamic> json) => AuthInfo(
        userId: json["userID"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "userID": userId,
        "token": token,
      };
}
