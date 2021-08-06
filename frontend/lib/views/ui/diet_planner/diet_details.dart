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

    onload() async {
      DietPlan dietPlan =
          await CalcServices().getActiveDietPlan(authInfo.state);
      // List<Calorie> burnedList = await CalcServices()
      //     .getAllCalorieBurned(authInfo.state, dietPlan.dietId);

      return dietPlan;
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
            height: size.height * 0.6,
            decoration: BoxDecoration(
              color: Color(0xFF4CC5AD),
            ),
          ),
          FutureBuilder(
              future: onload(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  DietPlan dietPlan = snapshot.data;
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
                                "Daily Calorie Burn Quota: 30%",
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
                            percent: 0.3,
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
                                      () {
                                        if (dietPlan.weightNow >
                                            dietPlan.weightTarget) {
                                          return "${(dietPlan.caloriePerDay * 0.3).toStringAsFixed(2)}";
                                        } else {
                                          return "${(dietPlan.caloriePerDay * 0.12).toStringAsFixed(2)}";
                                        }
                                      }(),
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
                                    height: size.height * 0.38,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                            color: Colors.grey, width: 0.5),
                                      ),
                                    ),
                                    child: TabBarView(
                                      children: [
                                        ListView.builder(
                                            itemCount: 3,
                                            itemBuilder: (context, snapshot) {
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
                                                    Image.network(
                                                      "https://www.freepnglogos.com/uploads/water-glass-png/water-glass-icon-download-png-and-vector-29.png",
                                                      scale:
                                                          size.aspectRatio * 30,
                                                    ),
                                                    SizedBox(width: 20),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[],
                                                      ),
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(DateFormat.jm(
                                                                'en_US')
                                                            .format(DateTime
                                                                .now())),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              );
                                            }),
                                        ListView.builder(
                                            itemCount: 2,
                                            itemBuilder: (context, snapshot) {
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
                                                    Image.network(
                                                      "https://www.freepnglogos.com/uploads/water-glass-png/water-glass-icon-download-png-and-vector-29.png",
                                                      scale:
                                                          size.aspectRatio * 30,
                                                    ),
                                                    SizedBox(width: 20),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[],
                                                      ),
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(DateFormat.jm(
                                                                'en_US')
                                                            .format(DateTime
                                                                .now())),
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
