import 'package:fitness/models/water_intake.dart';
import 'package:fitness/providers/user_provider.dart';
import 'package:fitness/services/calc_services.dart';
import 'package:fitness/views/utils/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class IntakeHistory extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final authInfo = useProvider(authInfoProvider);

    onload() async {
      List<WaterTaken> waterTaken =
          await CalcServices().getAllWaterIntake(authInfo.state);
      return waterTaken;
    }

    Size size = MediaQuery.of(context).size;
    return Background(
        leading: BackButton(
          color: Colors.black,
        ),
        headerColor: Colors.black,
        child: Stack(
          children: [
            Container(
              height: size.height * 1,
              decoration: BoxDecoration(
                color: Color(0xFF97EBDB),
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
                  icon: Icon(Icons.refresh_outlined),
                  onPressed: () {},
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Text(
                      "Water Intake History",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                    Expanded(
                      child: FutureBuilder(
                          future: onload(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10),
                                      padding: EdgeInsets.all(10),
                                      height: size.height * 0.1,
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
                                          Image.network(
                                            "https://www.freepnglogos.com/uploads/water-glass-png/water-glass-icon-download-png-and-vector-29.png",
                                            scale: size.aspectRatio * 20,
                                          ),
                                          SizedBox(width: 20),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                SizedBox(
                                                  height: size.height * 0.01,
                                                ),
                                                Text(
                                                  snapshot
                                                      .data[index].liquidType,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: size.height * 0.0012,
                                                ),
                                                Text(snapshot.data[index].amount
                                                        .toString() +
                                                    " mL")
                                              ],
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Text(DateFormat.yMMMMd('en_US')
                                                  .format(DateTime.parse(
                                                      snapshot
                                                          .data[index].date))),
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  });
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
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        header: "");
  }
}
