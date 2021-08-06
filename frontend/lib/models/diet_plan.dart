import 'dart:convert';

DietPlan dietPlanFromJson(String str) => DietPlan.fromJson(json.decode(str));

String dietPlanToJson(DietPlan data) => json.encode(data.toJson());

class DietPlan {
  DietPlan({
    this.caloriePerDay,
    this.dietId,
    this.endDate,
    this.id,
    this.startDate,
    this.userId,
    this.status,
    this.weightNow,
    this.weightTarget,
  });

  double caloriePerDay;
  String dietId;
  String endDate;
  int id;
  String startDate;
  int userId;
  int status;
  double weightNow;
  double weightTarget;

  factory DietPlan.fromJson(Map<String, dynamic> json) => DietPlan(
        caloriePerDay: json["caloriePerDay"],
        dietId: json["dietId"],
        endDate: json["endDate"],
        id: json["id"],
        startDate: json["startDate"],
        userId: json["userId"],
        weightNow: json["weightNow"],
        weightTarget: json["weightTarget"],
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
        "caloriePerDay": caloriePerDay,
        "dietId": dietId,
        "endDate": endDate,
        "id": id,
        "startDate": startDate,
        "userId": userId,
        "weightNow": weightNow,
        "weightTarget": weightTarget,
        "status": status
      };
}
