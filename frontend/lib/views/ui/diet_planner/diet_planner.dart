import 'package:fitness/providers/user_provider.dart';
import 'package:fitness/services/calc_services.dart';
import 'package:fitness/views/utils/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DietPlanner extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final authInfo = context.read(authInfoProvider);

    onload() async {
      bool dietActive = await CalcServices().checkDietActivity(authInfo.state);
      return dietActive;
    }

    return Background(
        headerColor: Colors.black,
        leading: BackButton(
          color: Colors.black,
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFF5CEB8),
              ),
            ),
            Center(
              child: FutureBuilder(
                  future: onload(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data) {
                        Future.delayed(Duration(seconds: 1), () {
                          Navigator.popAndPushNamed(
                              context, "/diet/plan/details");
                        });
                      } else {
                        Future.delayed(Duration(seconds: 1), () {
                          Navigator.popAndPushNamed(
                              context, "/diet/create/one");
                        });
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(
                            height: 20,
                          ),
                          Text(() {
                            if (snapshot.data) {
                              return "Please wait, Redirecting you to your Diet Plan";
                            } else {
                              return "Please wait, Processing your data to create Diet Plan";
                            }
                          }())
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error),
                      );
                    } else {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(
                              height: 20,
                            ),
                            Text("Please wait. Checking diet activity...")
                          ],
                        ),
                      );
                    }
                  }),
            ),
          ],
        ),
        header: "Diet Planner");
  }
}
