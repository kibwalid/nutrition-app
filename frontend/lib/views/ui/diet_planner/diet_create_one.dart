import 'package:fitness/config/theme.dart';
import 'package:fitness/models/user_info.dart';
import 'package:fitness/providers/calc_providers.dart';
import 'package:fitness/providers/user_provider.dart';
import 'package:fitness/services/user_services.dart';
import 'package:fitness/views/utils/background.dart';
import 'package:fitness/views/utils/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DietCreateOne extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final authInfo = context.read(authInfoProvider);
    final fintesGoal = useProvider(fitnessGoalSelectState);
    final fitnesDuration = useProvider(fitnesDurationState);
    onload() async {
      UserInfo userInfo =
          await UserServices().getCurrentUserInfo(authInfo.state);
      return userInfo;
    }

    Size size = MediaQuery.of(context).size;
    return Background(
      leading: BackButton(
        color: Colors.black,
      ),
      header: "",
      headerColor: Colors.black,
      child: Stack(
        children: [
          Container(
            height: size.height * 0.5,
            decoration: BoxDecoration(
              color: Color(0xFF4CC5AD),
            ),
          ),
          FutureBuilder(
              future: onload(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  double bmi = ((snapshot.data.userWeight * 2.20462) /
                          ((snapshot.data.userHeight * 12) *
                              (snapshot.data.userHeight * 12))) *
                      705;
                  return SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Create Diet Plan",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
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
                                        Icons.accessibility_new_outlined,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Weight",
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    Text(
                                      "${snapshot.data.userWeight}",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      "Kg",
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
                                        size: size.aspectRatio * 80,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "BMI",
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    Text(
                                      "${bmi.toStringAsFixed(2)}",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      "Kg/m2",
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
                                          color: Colors.amberAccent),
                                      child: Icon(
                                        Icons.height,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Height",
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    Text(
                                      "${snapshot.data.userHeight}",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      "Ft",
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
                          Center(child: Text(() {
                            if (bmi < 19) {
                              return "       According to your BMI, \nYou’re considered underweight.";
                            } else if (bmi > 19 && bmi < 24.9) {
                              return "       According to your BMI, \nYou’re in the healthy state.";
                            } else if (bmi > 25 && bmi < 29.9) {
                              return "       According to your BMI, \nYou’re considered overweight.";
                            } else {
                              return "       According to your BMI, \nFor the love of god, Please stop eating.";
                            }
                          }())),
                          SizedBox(
                            height: size.height * 0.1,
                          ),
                          Text(
                            "Fitness Target",
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Row(
                            children: [
                              Text("Time Range:"),
                              SizedBox(
                                width: size.width * 0.05,
                              ),
                              DropdownButton<String>(
                                value: fitnesDuration.state,
                                hint: Text(
                                  "1 Week",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                items: <String>[
                                  '1 Week',
                                  '2 Week',
                                  '3 Week',
                                  '1 Month'
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ));
                                }).toList(),
                                onChanged: (value) {
                                  fitnesDuration.state = value;
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Row(
                            children: [
                              Text("Fitness Goal:"),
                              SizedBox(
                                width: size.width * 0.05,
                              ),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  primary: fintesGoal.state == 1
                                      ? Colors.white
                                      : Colors.blue,
                                  backgroundColor: fintesGoal.state == 1
                                      ? Colors.blue
                                      : Colors.white,
                                ),
                                onPressed: () {
                                  fintesGoal.state = 1;
                                },
                                child: Text("Lose Weight"),
                              ),
                              SizedBox(
                                width: size.width * 0.02,
                              ),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  primary: fintesGoal.state == 2
                                      ? Colors.white
                                      : Colors.blue,
                                  backgroundColor: fintesGoal.state == 2
                                      ? Colors.blue
                                      : Colors.white,
                                ),
                                onPressed: () {
                                  fintesGoal.state = 2;
                                },
                                child: Text("Stay Current"),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: size.width * 0.25,
                              ),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  primary: fintesGoal.state == 3
                                      ? Colors.white
                                      : Colors.blue,
                                  backgroundColor: fintesGoal.state == 3
                                      ? Colors.blue
                                      : Colors.white,
                                ),
                                onPressed: () {
                                  fintesGoal.state = 3;
                                },
                                child: Text("Gain Weight"),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.04,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RoundedButton(
                                color: Colors.black,
                                press: () {},
                                text: "Submit",
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
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
              })
        ],
      ),
    );
  }
}
