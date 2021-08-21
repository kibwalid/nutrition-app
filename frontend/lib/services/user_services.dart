import 'package:fitness/config/constants.dart';
import 'package:fitness/models/auth_info.dart';
import 'package:fitness/models/user_info.dart';
import 'package:fitness/services/api_services.dart';
import 'package:fitness/services/location_services.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart' as lct;

class UserServices {
  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
  }

  Future<AuthInfo> login(UserLogin userLogin) async {
    LocationServices().resetLocationService();
    Map<String, dynamic> response =
        await Api().post(userLogin.toLoginData(), "$API_URI/api/user/login");
    if (response["message"] == null) {
      lct.Location curLocation = lct.Location();
      final LatLng currentLocation =
          await LocationServices().getLocation(curLocation);
      response["currentLocation"] = currentLocation;
      return AuthInfo.fromJson(response);
    }
    return null;
  }

  Future<AuthInfo> register(UserInfo userInfo) async {
    LocationServices().resetLocationService();
    userInfo.userLogin.roles = ["ROLE_USER"];
    Map<String, dynamic> response =
        await Api().post(userInfo.toJson(), "$API_URI/api/user/register");
    if (response["message"] == null) {
      lct.Location curLocation = lct.Location();
      final LatLng currentLocation =
          await LocationServices().getLocation(curLocation);
      response["currentLocation"] = currentLocation;
      return AuthInfo.fromJson(response);
    }
    return null;
  }

  Future<UserInfo> getCurrentUserInfo(AuthInfo authInfo) async {
    String response =
        await Api().get("$API_URI/api/user/${authInfo.userId}", authInfo.token);
    return userInfoFromJson(response);
  }

  Future<UserInfo> updateUserInfo(UserInfo userInfo) async {
    Map<String, dynamic> response =
        await Api().put(userInfo.toJson(), "$API_URI/api/user/update/info");
    print(response);
    if (response["message"] == null) {
      return UserInfo.fromJson(response);
    }
    return null;
  }
}
