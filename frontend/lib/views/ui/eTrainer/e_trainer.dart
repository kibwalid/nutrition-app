import 'package:fitness/providers/user_provider.dart';
import 'package:fitness/views/ui/eTrainer/single_training.dart';
import 'package:fitness/views/ui/eTrainer/utils/session_card.dart';
import 'package:fitness/views/utils/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ETrainer extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final authInfo = context.read(authInfoProvider);
    Size size = MediaQuery.of(context).size;
    return Background(
      header: "eTrainer",
      leading: BackButton(
        color: Colors.black,
      ),
      headerColor: Colors.black,
      child: Stack(
        children: [
          Positioned(
            child: Column(
              children: [
                Container(
                  height: size.height * 1,
                  decoration: BoxDecoration(
                    color: Colors.red.shade200,
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "eTrainer",
                      style: Theme.of(context)
                          .textTheme
                          .display1
                          .copyWith(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Text(
                      "Note:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: size.width * .6, // Play
                      child: Text(
                        "Based on your Diet Plans, you're only allowed to do basic exercise",
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Text(
                      "Basic",
                      style: Theme.of(context)
                          .textTheme
                          .title
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: <Widget>[
                        SeassionCard(
                          sessionName: "Squats",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SingleTraining(
                                        authInfo: authInfo.state,
                                        header: "Squats",
                                        videoAsset: "assets/videos/yoga2.mp4",
                                      )),
                            );
                          },
                        ),
                        SeassionCard(
                          sessionName: "Back Stretch",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SingleTraining(
                                        authInfo: authInfo.state,
                                        header: "Back Stretch",
                                        videoAsset: "assets/videos/yoga.mp4",
                                      )),
                            );
                          },
                        ),
                        SeassionCard(
                          sessionName: "Burpees",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SingleTraining(
                                        authInfo: authInfo.state,
                                        header: "Burpees",
                                        videoAsset: "assets/videos/burpees.mp4",
                                      )),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Text(
                      "Intermediate",
                      style: Theme.of(context)
                          .textTheme
                          .title
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: <Widget>[
                        SeassionCard(
                          sessionName: "Dips",
                          locked: true,
                          press: () {},
                        ),
                        SeassionCard(
                          sessionName: "Reverse Dips",
                          locked: true,
                          press: () {},
                        ),
                        SeassionCard(
                          sessionName: "Brench Press",
                          locked: true,
                          press: () {},
                        ),
                        SeassionCard(
                          sessionName: "Push-ups",
                          locked: true,
                          press: () {},
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Text(
                      "Extreme",
                      style: Theme.of(context)
                          .textTheme
                          .title
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: <Widget>[
                        SeassionCard(
                          sessionName: "Side planks",
                          locked: true,
                          press: () {},
                        ),
                        SeassionCard(
                          sessionName: "Glute bridge",
                          locked: true,
                          press: () {},
                        ),
                        SeassionCard(
                          sessionName: "Reverse Dips",
                          locked: true,
                          press: () {},
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    )
                  ],
                ),
              ),
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
                onPressed: () {
                  Navigator.pushNamed(context, "/exercise/history");
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
