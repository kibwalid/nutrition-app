import 'package:latlong/latlong.dart';

class Tracker {
  int counter;
  DateTime date;
  double calorieBurned;
  double distanceTraveled;
  List<LatLng> routeList;
  LatLng currentLocation;
  int remoteId;
  String dietId;

  Tracker(
      {this.counter,
      this.routeList,
      this.date,
      this.currentLocation,
      this.calorieBurned,
      this.distanceTraveled,
      this.dietId,
      this.remoteId});
}
