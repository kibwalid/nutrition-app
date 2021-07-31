import 'package:fitness/providers/running_tracker_providers.dart';
import 'package:fitness/providers/user_provider.dart';
import 'package:fitness/services/location_services.dart';
import 'package:fitness/services/user_services.dart';
import 'package:fitness/views/ui/dashboard/utils/dashboard_card.dart';
import 'package:fitness/views/utils/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Dashboard extends HookWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final authInfo = context.read(authInfoProvider);
    final tracker = context.read(trackerStateProvider);
    final actionState = useProvider(actionStateProvider);
    return FutureBuilder(
        future: UserServices().getCurrentUserInfo(authInfo.state),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Background(
                header: "Dashboard",
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: size.height * 1,
                      decoration: BoxDecoration(
                        color: Color(0xFFF5CEB8),
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
                              "Good Morning, \n${snapshot.data.firstName}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35),
                            ),
                            SizedBox(
                              height: size.height * 0.05,
                            ),
                            Expanded(
                              child: GridView.count(
                                crossAxisCount: 2,
                                childAspectRatio: .85,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20,
                                children: <Widget>[
                                  DashboardCard(
                                    title: "Calorie Calculator",
                                    imgSrc: "assets/icons/calories.png",
                                    press: () {
                                      Navigator.pushNamed(
                                          context, "/calc/calore");
                                    },
                                  ),
                                  DashboardCard(
                                    title: "eTrainer",
                                    imgSrc: "assets/icons/coach.png",
                                    press: () {
                                      Navigator.pushNamed(context, "/etrainer");
                                    },
                                  ),
                                  DashboardCard(
                                    title: "Water Intake",
                                    imgSrc: "assets/icons/water.png",
                                    press: () {},
                                  ),
                                  DashboardCard(
                                    title: () {
                                      if (!actionState.state) {
                                        return "Running Tracker";
                                      } else {
                                        return "Continue Run";
                                      }
                                    }(),
                                    imgSrc: "assets/icons/run.png",
                                    press: () {
                                      if (actionState.state == null) {
                                        actionState.state = true;
                                      } else if (!actionState.state) {
                                        actionState.state = true;
                                      }
                                      if (tracker.state.counter < 1) {
                                        LocationServices()
                                            .getLocationForTracking();
                                        LocationServices().startLocator();
                                      }
                                      Navigator.pushNamed(
                                          context, "/track/running");
                                    },
                                  ),
                                  DashboardCard(
                                    title: "BMI Calculator",
                                    imgSrc: "assets/icons/bmi.png",
                                    press: () {},
                                  ),
                                  DashboardCard(
                                    title: "Sleep Tracker",
                                    imgSrc: "assets/icons/sleep_timer.png",
                                    press: () {},
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ));
          } else if (snapshot.hasError) {
            return Scaffold(
                body: Center(
              child: Text(snapshot.error.toString()),
            ));
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
