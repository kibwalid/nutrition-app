import 'dart:convert';

WaterTaken waterTakenFromJson(String str) =>
    WaterTaken.fromJson(json.decode(str));

String waterTakenToJson(WaterTaken data) => json.encode(data.toJson());

class WaterTaken {
  WaterTaken({
    this.amount,
    this.date,
    this.id,
    this.liquidType,
    this.userId,
    this.waterIntakeId,
  });

  double amount;
  String date;
  int id;
  String liquidType;
  int userId;
  String waterIntakeId;

  factory WaterTaken.fromJson(Map<String, dynamic> json) => WaterTaken(
        amount: json["amount"],
        date: json["date"],
        id: json["id"],
        liquidType: json["liquidType"],
        userId: json["userId"],
        waterIntakeId: json["waterIntakeId"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "date": date,
        "id": id,
        "liquidType": liquidType,
        "userId": userId,
        "waterIntakeId": waterIntakeId,
      };
}
