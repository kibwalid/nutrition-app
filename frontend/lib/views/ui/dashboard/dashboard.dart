import 'package:fitness/views/ui/dashboard/utils/dashboard_card.dart';
import 'package:fitness/views/utils/background.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
        header: "Dashboard",
        child: Stack(
          children: <Widget>[
            Container(
              height: size.height * .45,
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
                      "Good Morning \nShishir",
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
                            press: () {},
                          ),
                          DashboardCard(
                            title: "eTrainer",
                            imgSrc: "assets/icons/coach.png",
                            press: () {},
                          ),
                          DashboardCard(
                            title: "Meditation Assistance",
                            imgSrc: "assets/icons/meditation.png",
                            press: () {},
                          ),
                          DashboardCard(
                            title: "Running Tracker",
                            imgSrc: "assets/icons/run.png",
                            press: () {},
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
  }
}
