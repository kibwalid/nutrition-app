import 'package:fitness/models/calorie_burned_local.dart';
import 'package:fitness/models/diet_plan.dart';
import 'package:fitness/providers/user_provider.dart';
import 'package:fitness/services/calc_services.dart';
import 'package:fitness/views/utils/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatDashboard extends HookWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final authInfo = context.read(authInfoProvider);

    onload() async {
      DietPlan dietPlan =
          await CalcServices().getActiveDietPlan(authInfo.state);
      List<Calorie> intake = await CalcServices()
          .getAllCalorieIntake(authInfo.state, dietPlan.dietId);
      List<Calorie> burn = await CalcServices()
          .getAllCalorieBurned(authInfo.state, dietPlan.dietId);

      return {"intake": intake, "burn": burn};
    }

    return Background(
      leading: BackButton(
        color: Colors.black,
      ),
      child: FutureBuilder(
        future: onload(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Calorie> intake = snapshot.data['intake'];
            List<Calorie> burn = snapshot.data['burn'];
            double totalIntake = 0;
            double burnedRunning = 0;
            double burnedExercise = 0;
            List<_BurnData> data = [
              _BurnData("Sat", 0),
              _BurnData("Sun", 0),
              _BurnData("Mon", 0),
              _BurnData("Tues", 0),
              _BurnData("Wed", 0),
              _BurnData("Thu", 0),
              _BurnData("Fri", 0),
            ];
            List<_IntakeData> intakeData = [
              _IntakeData("Sat", 0),
              _IntakeData("Sun", 0),
              _IntakeData("Mon", 0),
              _IntakeData("Tues", 0),
              _IntakeData("Wed", 0),
              _IntakeData("Thu", 0),
              _IntakeData("Fri", 0),
            ];
            intake.forEach((element) {
              totalIntake = totalIntake + element.calorie;
              if (DateFormat('EEEE').format(element.date) == "Saturday") {
                intakeData.add(_IntakeData("Sat", element.calorie));
              } else if (DateFormat('EEEE').format(element.date) == "Sunday") {
                intakeData.add(_IntakeData("Sun", element.calorie));
              } else if (DateFormat('EEEE').format(element.date) == "Monday") {
                intakeData.add(_IntakeData("Mon", element.calorie));
              } else if (DateFormat('EEEE').format(element.date) == "Tuesday") {
                intakeData.add(_IntakeData("Tues", element.calorie));
              } else if (DateFormat('EEEE').format(element.date) ==
                  "Wednesday") {
                intakeData.add(_IntakeData("Wed", element.calorie));
              } else if (DateFormat('EEEE').format(element.date) ==
                  "Thursday") {
                intakeData.add(_IntakeData("Thu", element.calorie));
              } else {
                intakeData.add(_IntakeData("Fri", element.calorie));
              }
            });
            burn.forEach((element) {
              if (DateFormat('EEEE').format(element.date) == "Saturday") {
                data.add(_BurnData("Sat", element.calorie));
              } else if (DateFormat('EEEE').format(element.date) == "Sunday") {
                data.add(_BurnData("Sun", element.calorie));
              } else if (DateFormat('EEEE').format(element.date) == "Monday") {
                data.add(_BurnData("Mon", element.calorie));
              } else if (DateFormat('EEEE').format(element.date) == "Tuesday") {
                data.add(_BurnData("Tues", element.calorie));
              } else if (DateFormat('EEEE').format(element.date) ==
                  "Wednesday") {
                data.add(_BurnData("Wed", element.calorie));
              } else if (DateFormat('EEEE').format(element.date) ==
                  "Thursday") {
                data.add(_BurnData("Thu", element.calorie));
              } else {
                data.add(_BurnData("Fri", element.calorie));
              }
              if (element.type == "run") {
                burnedRunning = burnedRunning + element.calorie;
              } else {
                burnedExercise = burnedExercise + element.calorie;
              }
            });

            List<_PieData> pieData = [
              _PieData("Intake: Food", totalIntake.toInt()),
              _PieData("Burned: Running", burnedRunning.toInt()),
              _PieData("Burned: Exercise", burnedExercise.toInt()),
            ];
            return Stack(
              children: [
                Container(
                  height: size.height * .5,
                  decoration: BoxDecoration(
                    color: Color(0xFFF5CEB8),
                  ),
                ),
                SafeArea(
                    child: Column(
                  children: [
                    Center(
                      child: SfCircularChart(
                          title: ChartTitle(text: ''),
                          legend: Legend(isVisible: true),
                          series: <PieSeries<_PieData, String>>[
                            PieSeries<_PieData, String>(
                                explode: true,
                                explodeIndex: 0,
                                strokeColor: Colors.black,
                                dataSource: pieData,
                                xValueMapper: (_PieData data, _) => data.xData,
                                yValueMapper: (_PieData data, _) => data.yData,
                                dataLabelMapper: (_PieData data, _) =>
                                    data.text,
                                dataLabelSettings:
                                    DataLabelSettings(isVisible: true)),
                          ]),
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultTabController(
                          length: 2,
                          child: Column(
                            children: [
                              Container(
                                child: TabBar(
                                  labelColor: Colors.green,
                                  unselectedLabelColor: Colors.black,
                                  tabs: [
                                    Tab(text: 'Weekly Intake'),
                                    Tab(text: 'Weekly Burned'),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Container(
                                height: size.height * 0.3,
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                        color: Colors.grey, width: 0.5),
                                  ),
                                ),
                                child: TabBarView(
                                  children: [
                                    SfCartesianChart(
                                        primaryXAxis: CategoryAxis(),
                                        // Chart title
                                        title: ChartTitle(
                                            text: 'Calorie Intake By Date'),
                                        // Enable legend
                                        legend: Legend(isVisible: false),
                                        // Enable tooltip
                                        tooltipBehavior:
                                            TooltipBehavior(enable: true),
                                        series: <
                                            ChartSeries<_IntakeData, String>>[
                                          LineSeries<_IntakeData, String>(
                                              dataSource: intakeData,
                                              xValueMapper:
                                                  (_IntakeData sales, _) =>
                                                      sales.year,
                                              yValueMapper:
                                                  (_IntakeData sales, _) =>
                                                      sales.sales,
                                              name: 'Calorie Burned',
                                              // Enable data label
                                              dataLabelSettings:
                                                  DataLabelSettings(
                                                      isVisible: true))
                                        ]),
                                    SfCartesianChart(
                                        primaryXAxis: CategoryAxis(),
                                        // Chart title
                                        title: ChartTitle(
                                            text: 'Calorie Burned By Date'),
                                        // Enable legend
                                        legend: Legend(isVisible: false),
                                        // Enable tooltip
                                        tooltipBehavior:
                                            TooltipBehavior(enable: true),
                                        series: <
                                            ChartSeries<_BurnData, String>>[
                                          LineSeries<_BurnData, String>(
                                              dataSource: data,
                                              xValueMapper:
                                                  (_BurnData sales, _) =>
                                                      sales.day,
                                              yValueMapper:
                                                  (_BurnData sales, _) =>
                                                      sales.sales,
                                              name: 'Calorie Burned',
                                              // Enable data label
                                              dataLabelSettings:
                                                  DataLabelSettings(
                                                      isVisible: true))
                                        ]),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ))
                  ],
                ))
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
      header: "Fitness Stats",
      headerColor: Colors.black,
    );
  }
}

class _BurnData {
  _BurnData(this.day, this.sales);

  final String day;
  final double sales;
}

class _IntakeData {
  _IntakeData(this.year, this.sales);

  final String year;
  final double sales;
}

class _PieData {
  _PieData(this.xData, this.yData, [this.text]);
  final String xData;
  final num yData;
  final String text;
}
