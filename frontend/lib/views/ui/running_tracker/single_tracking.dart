import 'package:fitness/config/theme.dart';
import 'package:fitness/models/running_tracker_local.dart';
import 'package:fitness/providers/user_provider.dart';
import 'package:fitness/services/calc_services.dart';
import 'package:fitness/services/location_services.dart';
import 'package:fitness/views/utils/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';

class SingleTracking extends HookWidget {
  MapController _mapController = MapController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final authInfo = context.read(authInfoProvider);

    onload() async {
      final Map<String, dynamic> data =
          ModalRoute.of(context).settings.arguments as Map;
      Tracker tracker = await CalcServices()
          .getRunningTrackedData(data['trackerId'], authInfo.state);

      return tracker;
    }

    return Background(
        headerColor: Colors.black,
        leading: BackButton(
          color: Colors.black,
        ),
        child: FutureBuilder(
          future: onload(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Tracker tracker = snapshot.data;
              return Stack(
                children: [
                  Positioned(
                    top: 0,
                    child: Container(
                      height: size.height * 0.8,
                      width: size.width * 1,
                      child: FlutterMap(
                          options: MapOptions(
                            minZoom: 12,
                            maxZoom: 18,
                            zoom: 18,
                            center: tracker.routeList.first,
                          ),
                          mapController: _mapController,
                          layers: [
                            TileLayerOptions(
                              urlTemplate:
                                  'https://api.mapbox.com/styles/v1/uchihakyo1/ckriu54bo7otw17nyfcavwl4b/tiles/{z}/{x}/{y}?optimize=true&access_token=pk.eyJ1IjoidWNoaWhha3lvMSIsImEiOiJja3JpdGQ5Z2swZTQzMm5xcm03MHNqMXpmIn0.aEfEIncdGsPLHyul8_Cg-g',
                            ),
                            MarkerLayerOptions(markers: [
                              Marker(
                                point: tracker.routeList.first,
                                builder: (context) => Container(
                                  child: Icon(
                                    Icons.album_outlined,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Marker(
                                point: tracker.routeList.last,
                                builder: (context) => Container(
                                  child: Icon(
                                    Icons.album_outlined,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ]),
                            PolylineLayerOptions(
                              polylines: [
                                Polyline(
                                    points: tracker.routeList,
                                    strokeWidth: 3.0,
                                    color: Colors.black,
                                    isDotted: true)
                              ],
                            )
                          ]),
                    ),
                  ),
                  Positioned(
                    bottom: size.height * .43,
                    right: 10,
                    child: Container(
                        height: size.height * .05,
                        alignment: AlignmentDirectional(0.0, 0.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: IconButton(
                            icon: Icon(Icons.location_searching),
                            onPressed: () {
                              _mapController.onReady.then((value) =>
                                  _mapController.move(
                                      snapshot.data.routeList.first, 18));
                            })),
                  ),
                  Positioned(
                    bottom: size.height * .5,
                    right: 10,
                    child: Container(
                        height: size.height * .05,
                        alignment: AlignmentDirectional(0.0, 0.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: IconButton(
                            icon: Icon(Icons.zoom_out),
                            onPressed: () {
                              _mapController.onReady.then((value) =>
                                  _mapController.move(_mapController.center,
                                      _mapController.zoom - 1));
                            })),
                  ),
                  Positioned(
                    bottom: size.height * 0.56,
                    right: 10,
                    child: Container(
                        height: size.height * .05,
                        alignment: AlignmentDirectional(0.0, 0.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: IconButton(
                            icon: Icon(Icons.zoom_in),
                            onPressed: () {
                              _mapController.onReady.then((value) =>
                                  _mapController.move(_mapController.center,
                                      _mapController.zoom + 1));
                            })),
                  ),
                  Positioned(
                    bottom: size.height * 0.05,
                    child: Container(
                      height: size.height - size.height * 0.7,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(75.0)),
                      ),
                      child: ListView(
                        primary: false,
                        padding: EdgeInsets.only(left: 25.0, right: 20.0),
                        children: <Widget>[
                          SizedBox(
                            height: size.height * 0.05,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.orangeAccent),
                                      child: Icon(
                                        Icons.directions_run_outlined,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Total Distance",
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    Text(
                                      "${(tracker.distanceTraveled / 1000).toStringAsFixed(2)}",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      "Km",
                                      style: TextStyle(fontSize: 12.0),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: primaryColor),
                                      child: Icon(
                                        Icons.local_fire_department_sharp,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Calories Burned",
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    Text(
                                      "${tracker.calorieBurned.toStringAsFixed(2)}",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      "Kcal",
                                      style: TextStyle(fontSize: 12.0),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.horizontal_rule_outlined,
                            size: size.width * 0.07,
                          ),
                          Center(
                            child: Expanded(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Tracked Time",
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                  Text(
                                    "${LocationServices().secToWord(tracker.counter)}",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        header: "Tracked Data");
  }
}
