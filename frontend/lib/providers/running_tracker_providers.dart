import 'dart:isolate';

import 'package:fitness/models/running_tracker_local.dart';
import 'package:fitness/services/location_services.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart' as lct;

final actionStateProvider = StateProvider<bool>((ref) => false);

final pauseStateProvider = StateProvider<bool>((ref) => false);

final trackerIntervalStateProvider = StateProvider<int>((ref) => 5);

final trackerStateProvider = StateProvider<Tracker>((ref) => Tracker(
    counter: 0,
    routeList: [],
    currentLocation: LatLng(1, 1),
    calorieBurned: 0,
    distanceTraveled: 0));

final locationStateNotifier =
    ChangeNotifierProvider<LocationNotifier>((ref) => LocationNotifier());

class LocationNotifier extends ChangeNotifier {
  LatLng currentLocation = LatLng(1, 1);

  void getCurrentLocation() async {
    lct.Location curLocation = lct.Location();
    currentLocation = await LocationServices().getLocation(curLocation);
    notifyListeners();
  }
}

final trackerStreamProvider = StreamProvider<int>((ref) {
  ReceivePort port = ReceivePort();
  final Distance distance = new Distance();
  final action = ref.read(actionStateProvider);
  final trackerState = ref.read((trackerStateProvider));
  final intervalState = ref.read(trackerIntervalStateProvider);
  final location = ref.read(locationStateNotifier);

  return Stream.periodic(Duration(seconds: 1), (number) {
    if (action.state) {
      if (trackerState.state.counter % intervalState.state == 0) {
        trackerState.state.routeList.add(location.currentLocation);
        trackerState.state.currentLocation = location.currentLocation;
        if (trackerState.state.routeList.length > 1) {
          trackerState.state.distanceTraveled =
              trackerState.state.distanceTraveled +
                  distance(
                      trackerState.state.routeList.last,
                      trackerState.state
                          .routeList[trackerState.state.routeList.length - 2]);
        } else {
          trackerState.state.distanceTraveled = 0;
        }
        print(trackerState.state.routeList);
      }
      if (trackerState.state.counter % (intervalState.state - 3) == 0) {
        location.getCurrentLocation();
      }
      trackerState.state.counter++;
      return trackerState.state.counter;
    } else {
      return trackerState.state.counter;
    }
  });
});
