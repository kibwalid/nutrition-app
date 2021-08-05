import 'package:fitness/models/auth_info.dart';
import 'package:fitness/models/exercise.dart';
import 'package:fitness/services/calc_services.dart';
import 'package:fitness/views/utils/background.dart';
import 'package:fitness/views/utils/input_text_field.dart';
import 'package:fitness/views/utils/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SingleTraining extends StatefulWidget {
  final String videoAsset;
  final String header;
  final AuthInfo authInfo;

  const SingleTraining({Key key, this.videoAsset, this.header, this.authInfo})
      : super(key: key);
  @override
  _SingleTrainingState createState() => _SingleTrainingState();
}

class _SingleTrainingState extends State<SingleTraining> {
  final formKey = GlobalKey<FormState>();
  VideoPlayerController videoPlayerController;

  @override
  void initState() {
    videoPlayerController = VideoPlayerController.asset(widget.videoAsset)
      ..initialize().then((value) {
        videoPlayerController.setLooping(true);
        videoPlayerController.play();

        setState(() {});
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Exercise exercise = Exercise();
    return Background(
      headerColor: Colors.black,
      header: widget.header,
      leading: BackButton(
        onPressed: () {
          Navigator.pop(context);
          videoPlayerController.pause();
        },
        color: Colors.black,
      ),
      child: Stack(
        children: [
          videoPlayerController.value.isInitialized
              ? VideoPlayer(videoPlayerController)
              : Center(
                  child: CircularProgressIndicator(),
                ),
          Positioned(
            bottom: 0,
            child: Container(
              height: size.height - size.height * 0.7,
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
              ),
              child: ListView(
                primary: false,
                padding: EdgeInsets.only(left: 25.0, right: 20.0),
                children: <Widget>[
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  Icon(
                    Icons.horizontal_rule_outlined,
                    color: Colors.white,
                    size: size.width * 0.07,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: RoundedButton(
                          press: () {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Center(child: Text("Add Exercise Info")),
                                content: Container(
                                  height: size.height * 0.28,
                                  child: Form(
                                    key: formKey,
                                    child: Column(
                                      children: <Widget>[
                                        InputTextField(
                                          label: 'Time Spent (In min)',
                                          onSaved: (value) {
                                            exercise.counter =
                                                int.parse(value) * 60;
                                          },
                                          keyboardType: TextInputType.number,
                                          validator: (value) {
                                            if (value.length == 0)
                                              return ("Time Spent is required");
                                          },
                                        ),
                                        SizedBox(
                                          height: size.height * 0.01,
                                        ),
                                        InputTextField(
                                          label: 'Times',
                                          keyboardType: TextInputType.number,
                                          validator: (value) {
                                            if (value.length == 0)
                                              return ("Times is required");
                                          },
                                          onSaved: (value) {
                                            exercise.timesDone =
                                                int.parse(value);
                                          },
                                        ),
                                        SizedBox(
                                          height: size.height * 0.02,
                                        ),
                                        RoundedButton(
                                          text: "Submit",
                                          color: Colors.blueAccent,
                                          press: () async {
                                            if (formKey.currentState
                                                .validate()) {
                                              formKey.currentState.save();
                                              exercise.date =
                                                  DateTime.now().toString();
                                              exercise.exerciseName =
                                                  widget.header;
                                              exercise.caloriesBurned =
                                                  7.6 * (exercise.counter / 47);
                                              exercise.userId = int.parse(
                                                  widget.authInfo.userId);
                                              CalcServices().addExercise(
                                                  exercise,
                                                  widget.authInfo.token);
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            }
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          text: "Finish Exercise",
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
