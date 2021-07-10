import 'package:fitness/config/constants.dart';
import 'package:fitness/models/user_info.dart';
import 'package:fitness/services/api_services.dart';

class NativeServices {
  Future<bool> login(UserLogin userLogin) async {
    Map<String, dynamic> response =
        await Api().post(userLogin.toLoginData(), "$API_URI/api/user/login");
    if (response["message"] == null) {
      print(response['token']);
      return true;
    }
    return false;
  }

  Future<bool> register(UserInfo userInfo) async {
    userInfo.userLogin.roles = ["ROLE_USER"];
    Map<String, dynamic> response =
        await Api().post(userInfo.toJson(), "$API_URI/api/user/register");
    if (response["message"] == null) {
      return true;
    }
    return false;
  }
}
