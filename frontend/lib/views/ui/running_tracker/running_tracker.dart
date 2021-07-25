import 'package:fitness/config/theme.dart';
import 'package:fitness/providers/running_tracker_providers.dart';
import 'package:fitness/services/location_services.dart';
import 'package:fitness/views/utils/background.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong/latlong.dart';
import 'package:fitness/views/utils/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RunningTracker extends HookWidget {
  MapController _mapController = MapController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final tracker = useProvider(trackerStateProvider);
    return Background(
      leading: BackButton(
        color: Colors.black,
      ),
      header: "Running Tracker",
      headerColor: Colors.black,
      child: Stack(
        children: <Widget>[
          Container(
            height: size.height * .45,
            decoration: BoxDecoration(
              color: Color(0xFFA09C98),
            ),
          ),
          Positioned(
            top: size.height * 0.13,
            right: 10,
            child: Container(
              alignment: Alignment.center,
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                color: Color(0xFFF2BEA1),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.history),
                onPressed: () {},
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Today"),
                      Text(
                        DateFormat.yMMMMd('en_US').format(DateTime.now()),
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
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
                              "80",
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
                                  shape: BoxShape.circle, color: primaryColor),
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
                              "950",
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
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: size.height * .21,
            child: Container(
              height: size.height * 0.4,
              width: size.width * 1,
              child: FlutterMap(
                  options: MapOptions(
                    minZoom: 12,
                    maxZoom: 18,
                    zoom: 18,
                    center: tracker.state.currentLocation,
                  ),
                  mapController: _mapController,
                  layers: [
                    TileLayerOptions(
                      urlTemplate:
                          'https://api.mapbox.com/styles/v1/uchihakyo1/ckriu54bo7otw17nyfcavwl4b/tiles/{z}/{x}/{y}?optimize=true&access_token=pk.eyJ1IjoidWNoaWhha3lvMSIsImEiOiJja3JpdGQ5Z2swZTQzMm5xcm03MHNqMXpmIn0.aEfEIncdGsPLHyul8_Cg-g',
                    ),
                    MarkerLayerOptions(markers: [
                      Marker(
                        point: tracker.state.currentLocation,
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
                            points: [],
                            strokeWidth: 3.0,
                            color: Colors.yellowAccent,
                            isDotted: true)
                      ],
                    )
                  ]),
            ),
          ),
          Positioned(
            bottom: size.height * .33,
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
                          _mapController.move(LatLng(23.8103, 90.4125), 18));
                    })),
          ),
          Positioned(
            bottom: size.height * .4,
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
                          _mapController.move(LatLng(23.8103, 90.4125),
                              _mapController.zoom - 1));
                    })),
          ),
          Positioned(
            bottom: size.height * 0.46,
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
                          _mapController.move(LatLng(23.8103, 90.4125),
                              _mapController.zoom + 1));
                    })),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: size.height - size.height * 0.7,
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
              ),
              child: ListView(
                primary: false,
                padding: EdgeInsets.only(left: 25.0, right: 20.0),
                children: <Widget>[
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Center(
                    child: Text(
                      LocationServices().secToHourAndMin(0),
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 45.0,
                          color: Colors.black),
                    ),
                  ),
                  Icon(
                    Icons.horizontal_rule_outlined,
                    size: size.width * 0.07,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: RoundedButton(
                          press: () {},
                          text: "Start",
                          color: Colors.blueAccent,
                        ),
                      ),
                      Expanded(
                        child: RoundedButton(
                          press: () {},
                          text: "End",
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
