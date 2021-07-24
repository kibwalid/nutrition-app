import 'package:fitness/config/theme.dart';
import 'package:fitness/views/utils/background.dart';
import 'package:fitness/views/utils/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RunningTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                                    shape: BoxShape.circle,
                                    color: primaryColor),
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
                    Card(
                        child: Container(
                      height: size.height * 0.2,
                      width: size.width * 1,
                      child: Center(
                        child: Text(
                          "01:13:43",
                          style: TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Center(
                      child: RoundedButton(
                        text: "Start",
                        press: () {},
                      ),
                    ),
                    Center(
                      child: RoundedButton(
                        color: Colors.redAccent,
                        text: "End",
                        press: () {},
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
