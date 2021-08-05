import 'dart:convert';

RunningTrackerRemote runningTrackerRemoteFromJson(String str) =>
    RunningTrackerRemote.fromJson(json.decode(str));

String runningTrackerRemoteToJson(RunningTrackerRemote data) =>
    json.encode(data.toJson());

class RunningTrackerRemote {
  RunningTrackerRemote({
    this.calorieBurned,
    this.counter,
    this.date,
    this.dietId,
    this.distanceTraveled,
    this.id,
    this.locationCords,
    this.userId,
  });

  String calorieBurned;
  int counter;
  String date;
  String dietId;
  double distanceTraveled;
  int id;
  List<String> locationCords;
  int userId;

  factory RunningTrackerRemote.fromJson(Map<String, dynamic> json) =>
      RunningTrackerRemote(
        calorieBurned: json["calorieBurned"],
        counter: json["counter"],
        date: json["date"],
        dietId: json["dietId"],
        distanceTraveled: json["distanceTraveled"],
        id: json["id"],
        locationCords: List<String>.from(json["locationCords"].map((x) => x)),
        userId: json["userID"],
      );

  Map<String, dynamic> toJson() => {
        "calorieBurned": calorieBurned,
        "counter": counter,
        "date": date,
        "dietId": dietId,
        "distanceTraveled": distanceTraveled,
        "id": id,
        "locationCords": List<dynamic>.from(locationCords.map((x) => x)),
        "userID": userId,
      };
}
