import 'package:fitness/providers/running_tracker_providers.dart';
import 'package:fitness/views/utils/background.dart';
import 'package:fitness/views/utils/input_text_field.dart';
import 'package:fitness/views/utils/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:weather/weather.dart';

class WaterIntake extends HookWidget {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final location = useProvider(locationStateNotifier);
    Size size = MediaQuery.of(context).size;
    WeatherFactory wf = new WeatherFactory("96ea21fe3b9191d33a13af32063f4b4a");

    onload() async {
      Weather w = await wf.currentWeatherByLocation(
          location.currentLocation.latitude,
          location.currentLocation.longitude);
      return {"weather": w};
    }

    return Background(
        resizeToBottom: false,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        header: "",
        child: FutureBuilder(
          future: onload(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Weather w = snapshot.data['weather'];
              return Stack(children: <Widget>[
                Container(
                  height: size.height * .6,
                  decoration: BoxDecoration(
                    color: Color(0xFFC7B8F5),
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
                            Text(
                              "Water Intake Tracker",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30),
                            ),
                            SizedBox(
                              height: size.height * 0.06,
                            ),
                            Center(
                              child: CircularPercentIndicator(
                                percent: .1,
                                progressColor: Colors.blueAccent,
                                arcType: ArcType.HALF,
                                arcBackgroundColor: Colors.white,
                                radius: size.aspectRatio * 500,
                                center: Center(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: size.height * 0.1,
                                      ),
                                      Text(
                                        "14L",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 40),
                                      ),
                                      Text(DateFormat.yMMMMd('en_US')
                                          .format(DateTime.now()))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.00,
                            ),
                            Text(
                              "Weather",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w600),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 20),
                              padding: EdgeInsets.all(10),
                              height: size.height * 0.15,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(13),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0, 17),
                                    blurRadius: 23,
                                    spreadRadius: -13,
                                    color: Color(0xFFE6E6E6),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.thermostat_outlined,
                                    size: size.aspectRatio * 100,
                                    color: Colors.blueAccent,
                                  ),
                                  SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          w.temperature.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle,
                                        ),
                                        Text("Feels like: ${w.tempFeelsLike}"),
                                        Text(() {
                                          if (w.temperature.celsius > 25) {
                                            return "Its hot outside, Make sure to drink more water than usual";
                                          } else {
                                            return "Its cold outside, Stay hydrated";
                                          }
                                        }()),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ))),
                Positioned(
                    bottom: size.height * 0.06,
                    right: size.width * 0.04,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Center(child: Text("Add Drinkable")),
                            content: Container(
                              height: size.height * 0.28,
                              child: Form(
                                key: formKey,
                                child: Column(
                                  children: <Widget>[
                                    InputTextField(
                                      label: 'Liquid Type',
                                      onSaved: (value) {},
                                      validator: (value) {
                                        if (value.length == 0)
                                          return ("Liquid Type is required");
                                      },
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    InputTextField(
                                      label: 'Amount',
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value.length == 0)
                                          return ("Amount is required");
                                      },
                                      onSaved: (value) {},
                                    ),
                                    SizedBox(
                                      height: size.height * 0.02,
                                    ),
                                    RoundedButton(
                                      text: "Submit",
                                      color: Colors.blueAccent,
                                      press: () {},
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      child: Icon(Icons.add),
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(24),
                      ),
                    ))
              ]);
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
        ));
  }
}
