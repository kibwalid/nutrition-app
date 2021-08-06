import 'dart:convert';

Exercise exerciseFromJson(String str) => Exercise.fromJson(json.decode(str));

String exerciseToJson(Exercise data) => json.encode(data.toJson());

class Exercise {
  Exercise({
    this.caloriesBurned,
    this.counter,
    this.date,
    this.exerciseName,
    this.id,
    this.timesDone,
    this.userId,
    this.dietId,
  });

  double caloriesBurned;
  int counter;
  String date;
  String exerciseName;
  int id;
  int timesDone;
  int userId;
  String dietId;

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
        caloriesBurned: json["caloriesBurned"],
        counter: json["counter"],
        date: json["date"],
        exerciseName: json["exerciseName"],
        id: json["id"],
        timesDone: json["timesDone"],
        userId: json["userID"],
        dietId: json["dietId"]
      );

  Map<String, dynamic> toJson() => {
        "caloriesBurned": caloriesBurned,
        "counter": counter,
        "date": date,
        "exerciseName": exerciseName,
        "id": id,
        "timesDone": timesDone,
        "userID": userId,
        "dietId": dietId
      };
}
