import 'dart:convert';

UserInfo userInfoFromJson(String str) => UserInfo.fromJson(json.decode(str));

String userInfoToJson(UserInfo data) => json.encode(data.toJson());

class UserInfo {
  UserInfo({
    this.email,
    this.firstName,
    this.id,
    this.lastName,
    this.phoneNum,
    this.userLogin,
    this.username,
  });

  String email;
  String firstName;
  int id;
  String lastName;
  String phoneNum;
  UserLogin userLogin;
  String username;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        email: json["email"],
        firstName: json["firstName"],
        id: json["id"],
        lastName: json["lastName"],
        phoneNum: json["phoneNum"],
        userLogin: UserLogin.fromJson(json["userLogin"]),
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "firstName": firstName,
        "id": id,
        "lastName": lastName,
        "phoneNum": phoneNum,
        "userLogin": userLogin.toJson(),
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
}
