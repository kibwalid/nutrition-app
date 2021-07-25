import 'package:latlong/latlong.dart';

class Tracker {
  int counter;
  DateTime date;
  double calorieBurned;
  double distanceTraveled;
  List<LatLng> routeList;
  LatLng currentLocation;

  Tracker(
      {this.counter,
      this.routeList,
      this.date,
      this.currentLocation,
      this.calorieBurned,
      this.distanceTraveled});
}
