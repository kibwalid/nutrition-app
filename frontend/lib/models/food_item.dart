import 'dart:convert';

FoodItem foodItemFromJson(String str) => FoodItem.fromJson(json.decode(str));

String foodItemToJson(FoodItem data) => json.encode(data.toJson());

class FoodItem {
  FoodItem({
    this.totalCal,
    this.items,
  });

  double totalCal;
  List<Item> items;

  factory FoodItem.fromJson(Map<String, dynamic> json) => FoodItem(
        totalCal: json["totalCal"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalCal": totalCal,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Item {
  Item({
    this.sugarG,
    this.fiberG,
    this.servingSizeG,
    this.sodiumMg,
    this.name,
    this.potassiumMg,
    this.fatSaturatedG,
    this.fatTotalG,
    this.calories,
    this.cholesterolMg,
    this.proteinG,
    this.carbohydratesTotalG,
  });

  double sugarG;
  double fiberG;
  double servingSizeG;
  int sodiumMg;
  String name;
  int potassiumMg;
  double fatSaturatedG;
  double fatTotalG;
  double calories;
  int cholesterolMg;
  double proteinG;
  double carbohydratesTotalG;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        sugarG: json["sugar_g"].toDouble(),
        fiberG: json["fiber_g"].toDouble(),
        servingSizeG: json["serving_size_g"].toDouble(),
        sodiumMg: json["sodium_mg"],
        name: json["name"],
        potassiumMg: json["potassium_mg"],
        fatSaturatedG: json["fat_saturated_g"].toDouble(),
        fatTotalG: json["fat_total_g"].toDouble(),
        calories: json["calories"].toDouble(),
        cholesterolMg: json["cholesterol_mg"],
        proteinG: json["protein_g"].toDouble(),
        carbohydratesTotalG: json["carbohydrates_total_g"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "sugar_g": sugarG,
        "fiber_g": fiberG,
        "serving_size_g": servingSizeG,
        "sodium_mg": sodiumMg,
        "name": name,
        "potassium_mg": potassiumMg,
        "fat_saturated_g": fatSaturatedG,
        "fat_total_g": fatTotalG,
        "calories": calories,
        "cholesterol_mg": cholesterolMg,
        "protein_g": proteinG,
        "carbohydrates_total_g": carbohydratesTotalG,
      };
}
