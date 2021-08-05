import 'package:fitness/config/constants.dart';
import 'package:fitness/models/auth_info.dart';
import 'package:fitness/models/food_item.dart';
import 'package:fitness/models/water_intake.dart';
import 'package:fitness/services/api_services.dart';

class CalcServices {
  Future<FoodItem> getMealInfo(String query) async {
    Map<String, dynamic> response = await Api().getFromCN(query);
    FoodItem foodItem = FoodItem.fromJson(response);
    foodItem.totalCal = 0;
    foodItem.items.forEach((element) {
      foodItem.totalCal += element.calories;
    });
    return foodItem;
  }

  Future<List<WaterTaken>> getWaterIntakeOfDay(String userID, token) async {
    WaterTaken intake = WaterTaken(
        amount: 0,
        userId: int.parse(userID),
        waterIntakeId:
            "${DateTime.now().day}_${DateTime.now().month}_${DateTime.now().year}_of_user_$userID");
    List<dynamic> response = await Api()
        .postWithToken("$API_URI/api/intake/check", token, intake.toJson());
    List<WaterTaken> waterIntakes = [];
    response.forEach((element) {
      waterIntakes.add(WaterTaken.fromJson(element));
    });
    return waterIntakes;
  }

  Future<WaterTaken> addWater(WaterTaken waterTaken, AuthInfo authInfo) async {
    waterTaken.userId = int.parse(authInfo.userId);
    waterTaken.date = DateTime.now().toString();
    waterTaken.waterIntakeId =
        "${DateTime.now().day}_${DateTime.now().month}_${DateTime.now().year}_of_user_${authInfo.userId}";
    Map<String, dynamic> response = await Api().postWithToken(
        "$API_URI/api/intake/add", authInfo.token, waterTaken.toJson());
    if (response["message"] == null) {
      return WaterTaken.fromJson(response);
    }
    return null;
  }

  Future<List<WaterTaken>> getAllWaterIntake(AuthInfo authInfo) async {
    List<dynamic> response = await Api()
        .getAll("$API_URI/api/intake/all/${authInfo.userId}", authInfo.token);
    List<WaterTaken> waterIntakes = [];
    response.forEach((element) {
      if (element['amount'] > 0) {
        waterIntakes.add(WaterTaken.fromJson(element));
      }
    });
    if (waterIntakes.isNotEmpty) {
      return waterIntakes;
    }
    return null;
  }
}
