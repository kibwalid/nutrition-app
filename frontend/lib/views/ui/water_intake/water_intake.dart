import 'package:fitness/models/user_info.dart';
import 'package:fitness/models/water_intake.dart';
import 'package:fitness/providers/calc_providers.dart';
import 'package:fitness/providers/running_tracker_providers.dart';
import 'package:fitness/providers/user_provider.dart';
import 'package:fitness/services/api_services.dart';
import 'package:fitness/services/calc_services.dart';
import 'package:fitness/services/user_services.dart';
import 'package:fitness/views/utils/background.dart';
import 'package:fitness/views/utils/input_text_field.dart';
import 'package:fitness/views/utils/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class WaterIntake extends HookWidget {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final location = useProvider(locationStateNotifier);
    final authInfo = context.read(authInfoProvider);
    final waterIntake = useProvider(waterIntakeState);
    WaterTaken waterTaken = WaterTaken();
    Size size = MediaQuery.of(context).size;
    onload() async {
      Map<String, dynamic> response = await Api().getFromWeather(
          "${location.currentLocation.latitude},${location.currentLocation.longitude}");

      UserInfo userInfo =
          await UserServices().getCurrentUserInfo(authInfo.state);
      return {"weather": response, "user": userInfo};
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
              UserInfo userInfo = snapshot.data['user'];
              print(userInfo.userWeight);

              double waterNeeded = userInfo.userWeight / 30;
              double waterPercent = 0;
              if (waterIntake.state != 0) {
                waterPercent = waterNeeded / waterIntake.state;
              }

              return Stack(children: <Widget>[
                Container(
                  height: size.height * .6,
                  decoration: BoxDecoration(
                    color: Color(0xFFC7B8F5),
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
                      color: Colors.blue,
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
                                percent: waterPercent > 1 ? 1 : waterPercent,
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
                                        "${(waterIntake.state / 1000).toStringAsFixed(1)}L",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 40),
                                      ),
                                      Text(DateFormat.yMMMMd('en_US')
                                          .format(DateTime.now())),
                                      Text(
                                          "Total ${waterNeeded.toStringAsFixed(2)}L water needed for today")
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
                                  Column(
                                    children: [
                                      Image.network("http:" +
                                          snapshot.data['weather']["current"]
                                              ['condition']['icon']),
                                      Text(snapshot.data['weather']["current"]
                                          ['condition']['text'])
                                    ],
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
                                          snapshot.data['weather']["current"]
                                                      ['temp_c']
                                                  .toString() +
                                              " Celsius",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle,
                                        ),
                                        Text(
                                            "Feels like: ${snapshot.data['weather']["current"]['feelslike_c'] - 4} Celsius"),
                                        Text(() {
                                          if (snapshot.data['weather']
                                                  ["current"]['temp_c'] >
                                              30) {
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
                                      onSaved: (value) {
                                        waterTaken.liquidType =
                                            value.toString();
                                      },
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
                                      onSaved: (value) {
                                        waterTaken.amount = double.parse(value);
                                      },
                                    ),
                                    SizedBox(
                                      height: size.height * 0.02,
                                    ),
                                    RoundedButton(
                                      text: "Submit",
                                      color: Colors.blueAccent,
                                      press: () async {
                                        if (formKey.currentState.validate()) {
                                          formKey.currentState.save();
                                          WaterTaken waterFromDB =
                                              await CalcServices().addWater(
                                                  waterTaken, authInfo.state);
                                          if (waterFromDB != null) {
                                            waterIntake.state +=
                                                waterFromDB.amount;
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            Navigator.pushNamed(
                                                context, "/water/intake");
                                          }
                                        }
                                      },
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
