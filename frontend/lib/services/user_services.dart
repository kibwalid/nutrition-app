import 'package:fitness/config/constants.dart';
import 'package:fitness/models/auth_info.dart';
import 'package:fitness/models/user_info.dart';
import 'package:fitness/services/api_services.dart';

class UserServices {
  Future<AuthInfo> login(UserLogin userLogin) async {
    Map<String, dynamic> response =
        await Api().post(userLogin.toLoginData(), "$API_URI/api/user/login");
    if (response["message"] == null) {
      return AuthInfo.fromJson(response);
    }
    return null;
  }

  Future<AuthInfo> register(UserInfo userInfo) async {
    userInfo.userLogin.roles = ["ROLE_USER"];
    Map<String, dynamic> response =
        await Api().post(userInfo.toJson(), "$API_URI/api/user/register");
    if (response["message"] == null) {
      return AuthInfo.fromJson(response);
    }
    return null;
  }

  Future<UserInfo> getCurrentUserInfo(AuthInfo authInfo) async {
    print(authInfo.token);
    String response =
        await Api().get("$API_URI/api/user/${authInfo.userId}", authInfo.token);
    return userInfoFromJson(response);
  }
}
