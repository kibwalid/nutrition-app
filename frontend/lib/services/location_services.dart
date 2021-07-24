import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:background_locator/background_locator.dart';
import 'package:background_locator/location_dto.dart';
import 'package:background_locator/settings/android_settings.dart';
import 'package:background_locator/settings/ios_settings.dart';
import 'package:background_locator/settings/locator_settings.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as lct;

class LocationServices {
  ReceivePort port = ReceivePort();
  static const String isolateName = 'LocatorIsolate';

  String secToHourAndMin(int sec) {
    int hour = sec ~/ 3600;
    sec %= 3600;
    int minutes = sec ~/ 60;
    sec %= 60;

    if (minutes < 10 && hour < 10) {
      return "0$hour:0$minutes:$sec";
    } else if (minutes < 10) {
      return "$hour:0$minutes:$sec";
    } else if (hour < 10) {
      return "0$hour:0$minutes:$sec";
    } else {
      return "$hour:$minutes:$sec";
    }
  }

  Future<LatLng> requestPerms() async {
    Map<Permission, PermissionStatus> statuses =
        await [Permission.locationAlways].request();

    var status = statuses[Permission.locationAlways];
    if (status == PermissionStatus.denied) {
      return requestPerms();
    } else {
      return gpsEnable();
    }
  }

  Future<LatLng> gpsEnable() async {
    lct.Location curLocation = lct.Location();
    bool statusResult = await curLocation.requestService();

    if (!statusResult) {
      gpsEnable();
      return null;
    } else {
      return getLocation(curLocation);
    }
  }

  Future<LatLng> getLocation(lct.Location curLocation) async {
    var currentLocation = await curLocation.getLocation();
    if (currentLocation != null) {
      return LatLng(currentLocation.latitude, currentLocation.longitude);
    } else {
      return null;
    }
  }

  void callback(LocationDto locationDto) {
    final SendPort send = IsolateNameServer.lookupPortByName(isolateName);
    send?.send(locationDto);
  }

  static Future<void> locationCallback(LocationDto locationDto) async {
    LocationServices().callback(locationDto);
  }

  static Future<void> notificationCallback() async {
    print('***notificationCallback');
  }

  void startLocator() {
    BackgroundLocator.registerLocationUpdate(LocationServices.locationCallback,
        iosSettings: IOSSettings(
            accuracy: LocationAccuracy.NAVIGATION, distanceFilter: 0),
        autoStop: false,
        androidSettings: AndroidSettings(
            accuracy: LocationAccuracy.NAVIGATION,
            interval: 5,
            distanceFilter: 0,
            client: LocationClient.google,
            androidNotificationSettings: AndroidNotificationSettings(
                notificationChannelName: 'Location tracking',
                notificationTitle: 'Start Location Tracking',
                notificationMsg: 'Track location in background',
                notificationBigMsg:
                    'Background location is on to keep the app up-tp-date with your location. This is required for main features to work properly when the app is not running.',
                notificationIconColor: Colors.grey,
                notificationTapCallback:
                    LocationServices.notificationCallback)));
  }

  Future<void> getLocationForTracking() async {
    if (IsolateNameServer.lookupPortByName(LocationServices.isolateName) !=
        null) {
      IsolateNameServer.removePortNameMapping(LocationServices.isolateName);
    }

    IsolateNameServer.registerPortWithName(
        port.sendPort, LocationServices.isolateName);

    port.listen(
      (dynamic data) async {
        updateLocationData(data);
      },
    );
    print('Initializing...');

    await BackgroundLocator.initialize();
    print('Initialization done');

    final isRunning = await BackgroundLocator.isServiceRunning();
    print(isRunning);
    if (isRunning) {
      print("Started");
    }
  }

  Future<void> updateLocationData(LocationDto data) async {
    await updateNotificationText(data);

    if (data != null) {
      print("========");
    } else {
      print("error");
    }
  }

  Future<void> updateNotificationText(LocationDto data) async {
    if (data == null) {
      return;
    }

    await BackgroundLocator.updateNotificationText(
        title: "Background Tracking is On",
        msg: "Tap to return to Animal Tracker",
        bigMsg: "");
  }

  Future<void> startgettingLocationData() async {
    LocationServices().startLocator();
    final isRunning = await BackgroundLocator.isServiceRunning();
    if (isRunning) {
      print("ok!");
    }
  }

  Future<void> stopGettingLocationData() async {
    BackgroundLocator.unRegisterLocationUpdate();
    final isRunning = await BackgroundLocator.isServiceRunning();
    if (!isRunning) {
      print("closed");
    }
  }

  Future<void> resetLocationService() async {
    final isRunning = await BackgroundLocator.isServiceRunning();
    if (isRunning) {
      LocationServices().startLocator();
      BackgroundLocator.unRegisterLocationUpdate();
    }
  }
}
