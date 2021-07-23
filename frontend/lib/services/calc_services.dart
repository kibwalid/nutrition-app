import 'package:fitness/models/food_item.dart';
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
}
