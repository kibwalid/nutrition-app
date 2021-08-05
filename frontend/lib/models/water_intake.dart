import 'dart:convert';

WaterTaken waterIntakeFromJson(String str) =>
    WaterTaken.fromJson(json.decode(str));

String waterIntakeToJson(WaterTaken data) => json.encode(data.toJson());

class WaterTaken {
  WaterTaken({
    this.amount,
    this.id,
    this.liquidType,
    this.userId,
    this.waterIntakeId,
  });

  double amount;
  int id;
  String liquidType;
  int userId;
  String waterIntakeId;

  factory WaterTaken.fromJson(Map<String, dynamic> json) => WaterTaken(
        amount: json["amount"],
        id: json["id"],
        liquidType: json["liquidType"],
        userId: json["userId"],
        waterIntakeId: json["waterIntakeId"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "id": id,
        "liquidType": liquidType,
        "userId": userId,
        "waterIntakeId": waterIntakeId,
      };
}
