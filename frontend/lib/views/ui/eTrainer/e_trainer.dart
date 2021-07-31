import 'package:fitness/views/ui/eTrainer/utils/session_card.dart';
import 'package:fitness/views/utils/background.dart';
import 'package:flutter/material.dart';

class ETrainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                            Navigator.pushNamed(context, "/single/exercise",
                                arguments: "squats");
                          },
                        ),
                        SeassionCard(
                          sessionName: "Push-ups",
                          press: () {},
                        ),
                        SeassionCard(
                          sessionName: "Planks",
                          press: () {},
                        ),
                        SeassionCard(
                          sessionName: "Burpees",
                          press: () {},
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
        ],
      ),
    );
  }
}
