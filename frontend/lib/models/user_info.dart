import 'dart:convert';

UserInfo userInfoFromJson(String str) => UserInfo.fromJson(json.decode(str));

String userInfoToJson(UserInfo data) => json.encode(data.toJson());

class UserInfo {
  UserInfo({
    this.firstName,
    this.id,
    this.lastName,
    this.sex,
    this.userHeight,
    this.userLogin,
    this.userWeight,
    this.username,
  });

  String firstName;
  int id;
  String lastName;
  String sex;
  double userHeight;
  UserLogin userLogin;
  double userWeight;
  String username;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        firstName: json["firstName"],
        id: json["id"],
        lastName: json["lastName"],
        sex: json["sex"],
        userHeight: json["userHeight"],
        userLogin: UserLogin.fromJson(json["userLogin"]),
        userWeight: json["userWeight"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "id": id,
        "lastName": lastName,
        "sex": sex,
        "userHeight": userHeight,
        "userLogin": userLogin.toJson(),
        "userWeight": userWeight,
        "username": username,
      };
}

class UserLogin {
  UserLogin({
    this.id,
    this.password,
    this.roles,
    this.username,
  });

  int id;
  String password;
  List<String> roles;
  String username;

  factory UserLogin.fromJson(Map<String, dynamic> json) => UserLogin(
        id: json["id"],
        password: json["password"],
        roles: List<String>.from(json["roles"].map((x) => x)),
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "password": password,
        "roles": List<dynamic>.from(roles.map((x) => x)),
        "username": username,
      };

  Map<String, dynamic> toLoginData() => {
        "password": password,
        "username": username,
      };
}
