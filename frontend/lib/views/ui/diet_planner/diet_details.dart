import 'package:fitness/models/calorie_burned_local.dart';
import 'package:fitness/models/diet_plan.dart';
import 'package:fitness/providers/user_provider.dart';
import 'package:fitness/services/calc_services.dart';
import 'package:fitness/views/utils/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class DietDetails extends HookWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final authInfo = context.read(authInfoProvider);
    final dietPlan = context.read(dietPlanProvider);

    onload() async {
      DietPlan dietPlan =
          await CalcServices().getActiveDietPlan(authInfo.state);

      List<Calorie> intake = await CalcServices()
          .getAllCalorieIntake(authInfo.state, dietPlan.dietId);
      List<Calorie> burn = await CalcServices()
          .getAllCalorieBurned(authInfo.state, dietPlan.dietId);
      // List<Calorie> burnedList = await CalcServices()
      //     .getAllCalorieBurned(authInfo.state, dietPlan.dietId);

      return {"diet": dietPlan, "intake": intake, "burn": burn};
    }

    return Background(
      header: "Diet Plan",
      leading: BackButton(
        color: Colors.black,
      ),
      headerColor: Colors.black,
      child: Stack(
        children: [
          Container(
            height: size.height * 0.7,
            decoration: BoxDecoration(
              color: Color(0xFF4CC5AD),
            ),
          ),
          FutureBuilder(
              future: onload(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  DietPlan dietPlan = snapshot.data['diet'];
                  List<Calorie> intake = snapshot.data['intake'];
                  List<Calorie> burn = snapshot.data['burn'];
                  double burnQuota = 0.0;
                  double burned = 0;
                  double burnedPercent = 0;
                  double intakeTotal = 0;
                  double intakePercent = 0;
                  burn.forEach((element) {
                    burned += element.calorie;
                  });
                  intake.forEach((element) {
                    intakeTotal += element.calorie;
                  });
                  if (dietPlan.weightNow > dietPlan.weightTarget) {
                    burnQuota = (dietPlan.caloriePerDay * 0.3);
                  } else {
                    burnQuota = (dietPlan.caloriePerDay * 0.12);
                  }
                  burnedPercent = burned / burnQuota;
                  intakePercent = intakeTotal / dietPlan.caloriePerDay;
                  return SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Today"),
                              Text(
                                DateFormat.yMMMMd('en_US')
                                    .format(DateTime.now()),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.05,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Daily Calorie Burn Quota: ${(burnedPercent * 100).toStringAsFixed(2)}%",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87),
                              )
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.04,
                          ),
                          LinearPercentIndicator(
                            progressColor: Colors.black38,
                            percent: burnedPercent,
                          ),
                          SizedBox(
                            height: size.height * 0.04,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Daily Calorie Intake Quota: ${(intakePercent * 100).toStringAsFixed(2)}%",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87),
                              )
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.04,
                          ),
                          LinearPercentIndicator(
                            progressColor: Colors.green,
                            percent: intakePercent,
                          ),
                          SizedBox(
                            height: size.height * 0.04,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.orangeAccent),
                                      child: Image.network(
                                        "https://static.thenounproject.com/png/512375-200.png",
                                        scale: size.aspectRatio * 8,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Calorie Burn Target",
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    Text(
                                      "${burnQuota.toStringAsFixed(2)}",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      "KCal",
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
                                          color: Colors.redAccent),
                                      child: Image.network(
                                        "https://img.icons8.com/color/452/healthy-food-calories-calculator.png",
                                        scale: size.aspectRatio * 20,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Daily Calorie Limit",
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    Text(
                                      "${dietPlan.caloriePerDay.toStringAsFixed(1)}",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      "KCal",
                                      style: TextStyle(fontSize: 12.0),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Card(
                            child: DefaultTabController(
                              length: 2,
                              child: Column(
                                children: [
                                  Container(
                                    child: TabBar(
                                      labelColor: Colors.green,
                                      unselectedLabelColor: Colors.black,
                                      tabs: [
                                        Tab(text: 'Calorie Intake'),
                                        Tab(text: 'Calorie Burned'),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: size.height * 0.2,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                            color: Colors.grey, width: 0.5),
                                      ),
                                    ),
                                    child: TabBarView(
                                      children: [
                                        ListView.builder(
                                            itemCount: intake.length,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 10),
                                                padding: EdgeInsets.all(10),
                                                height: size.height * 0.1,
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
                                                    intake[index].type == "food"
                                                        ? SizedBox(
                                                            width: size.width *
                                                                0.012)
                                                        : SizedBox(),
                                                    Image.network(
                                                      () {
                                                        if (intake[index]
                                                                .type ==
                                                            "water") {
                                                          return "https://www.freepnglogos.com/uploads/water-glass-png/water-glass-icon-download-png-and-vector-29.png";
                                                        } else {
                                                          return "https://i.pinimg.com/originals/95/0d/1a/950d1aaefee57bcfe67e5b9d9cbb35ca.png";
                                                        }
                                                      }(),
                                                      scale: intake[index]
                                                                  .type ==
                                                              "water"
                                                          ? size.aspectRatio *
                                                              30
                                                          : size.aspectRatio *
                                                              23,
                                                    ),
                                                    SizedBox(width: 20),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          SizedBox(
                                                            height:
                                                                size.height *
                                                                    0.01,
                                                          ),
                                                          Text(
                                                            intake[index].name,
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                size.height *
                                                                    0.0012,
                                                          ),
                                                          Text(intake[index]
                                                                  .calorie
                                                                  .toString() +
                                                              " KCal")
                                                        ],
                                                      ),
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(DateFormat.jm(
                                                                'en_US')
                                                            .format(
                                                                intake[index]
                                                                    .date)),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              );
                                            }),
                                        ListView.builder(
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
                                                            width: size.width *
                                                                0.012)
                                                        : SizedBox(
                                                            width: size.width *
                                                                0.012),
                                                    Image.network(
                                                      () {
                                                        if (burn[index].type ==
                                                            "run") {
                                                          return "https://www.freepnglogos.com/uploads/running-png/running-icon-download-icons-35.png";
                                                        } else {
                                                          return "https://www.pngrepo.com/png/81526/512/exercise.png";
                                                        }
                                                      }(),
                                                      scale:
                                                          size.aspectRatio * 30,
                                                    ),
                                                    SizedBox(width: 20),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Text(
                                                            burn[index].name,
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                size.height *
                                                                    0.0012,
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
                                                        Text(DateFormat.jm(
                                                                'en_US')
                                                            .format(burn[index]
                                                                .date)),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              );
                                            }),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
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
