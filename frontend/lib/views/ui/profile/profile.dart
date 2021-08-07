import 'package:fitness/config/theme.dart';
import 'package:fitness/models/calorie_burned_local.dart';
import 'package:fitness/models/user_info.dart';
import 'package:fitness/providers/user_provider.dart';
import 'package:fitness/services/calc_services.dart';
import 'package:fitness/services/user_services.dart';
import 'package:fitness/views/utils/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class Profile extends HookWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final authInfo = context.read(authInfoProvider);
    final dietPlan = context.read(dietPlanProvider);
    onload() async {
      UserInfo userInfo =
          await UserServices().getCurrentUserInfo(authInfo.state);
      return userInfo;
    }

    onExLoad() async {
      String dietId = "11";
      if (dietPlan.state.dietId != null) {
        dietId = dietPlan.state.dietId;
      }
      List<Calorie> burn =
          await CalcServices().getAllCalorieBurned(authInfo.state, dietId);
      return burn;
    }

    return Background(
      header: "Profile",
      leading: BackButton(
        color: Colors.black,
      ),
      headerColor: Colors.black,
      child: Stack(
        children: [
          Container(
            height: size.height * 0.65,
            decoration: BoxDecoration(
              color: Color(0xFF9FC39F),
            ),
          ),
          SafeArea(
            child: FutureBuilder(
              future: onload(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  double bmi = ((snapshot.data.userWeight * 2.20462) /
                          ((snapshot.data.userHeight * 12) *
                              (snapshot.data.userHeight * 12))) *
                      705;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${snapshot.data.firstName} ${snapshot.data.lastName}",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 35),
                        ),
                        Text(
                          "@${snapshot.data.username}",
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.normal,
                              fontSize: 22),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Row(
                          children: [
                            Text(
                              "Height:  ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 22),
                            ),
                            Text(
                              "${snapshot.data.userHeight} Ft",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.normal,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 22),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Row(
                          children: [
                            Text(
                              "Weight:  ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 22),
                            ),
                            Text(
                              "${snapshot.data.userWeight} Kg",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.normal,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 22),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.04,
                        ),
                        Text(
                          "Body Information:  ",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 22),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
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
                          height: size.height * 0.02,
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
                          height: size.height * 0.07,
                        ),
                        Text(
                          "Recent Exercise:  ",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 22),
                        ),
                        FutureBuilder(
                            future: onExLoad(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<Calorie> burn = snapshot.data;
                                return Expanded(
                                  child: ListView.builder(
                                      itemCount: burn.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10),
                                          padding: EdgeInsets.all(10),
                                          height: size.height * 0.08,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(13),
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
                                              burn[index].type == "run"
                                                  ? SizedBox(
                                                      width: size.width * 0.012)
                                                  : SizedBox(
                                                      width:
                                                          size.width * 0.012),
                                              Image.network(
                                                () {
                                                  if (burn[index].type ==
                                                      "run") {
                                                    return "https://www.freepnglogos.com/uploads/running-png/running-icon-download-icons-35.png";
                                                  } else {
                                                    return "https://www.pngrepo.com/png/81526/512/exercise.png";
                                                  }
                                                }(),
                                                scale: size.aspectRatio * 30,
                                              ),
                                              SizedBox(width: 20),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      burn[index].name,
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          size.height * 0.0012,
                                                    ),
                                                    Text(burn[index]
                                                            .calorie
                                                            .toStringAsFixed(
                                                                2) +
                                                        " KCal")
                                                  ],
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  Text(DateFormat.jm('en_US')
                                                      .format(
                                                          burn[index].date)),
                                                ],
                                              )
                                            ],
                                          ),
                                        );
                                      }),
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
                            }),
                      ],
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
              },
            ),
          )
        ],
      ),
    );
  }
}
