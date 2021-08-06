import 'dart:convert';

FoodIntake foodIntakeFromJson(String str) =>
    FoodIntake.fromJson(json.decode(str));

String foodIntakeToJson(FoodIntake data) => json.encode(data.toJson());

class FoodIntake {
  FoodIntake({
    this.calorieTaken,
    this.date,
    this.dietId,
    this.foodName,
    this.id,
  });

  double calorieTaken;
  String date;
  String dietId;
  String foodName;
  int id;

  factory FoodIntake.fromJson(Map<String, dynamic> json) => FoodIntake(
        calorieTaken: json["calorieTaken"],
        date: json["date"],
        dietId: json["dietId"],
        foodName: json["foodName"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "calorieTaken": calorieTaken,
        "date": date,
        "dietId": dietId,
        "foodName": foodName,
        "id": id,
      };
}
