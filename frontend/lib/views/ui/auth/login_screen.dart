import 'package:fitness/config/theme.dart';
import 'package:fitness/models/user_info.dart';
import 'package:fitness/models/water_intake.dart';
import 'package:fitness/providers/calc_providers.dart';
import 'package:fitness/providers/running_tracker_providers.dart';
import 'package:fitness/providers/user_provider.dart';
import 'package:fitness/services/calc_services.dart';
import 'package:fitness/services/user_services.dart';
import 'package:fitness/views/utils/background_unlogged.dart';
import 'package:fitness/views/utils/input_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginScreen extends HookWidget {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authInfo = context.read(authInfoProvider);
    final tracker = context.read(trackerStateProvider);
    final location = context.read(locationStateNotifier);
    final waterIntake = context.read(waterIntakeState);
    UserLogin userLogin = UserLogin();
    Size size = MediaQuery.of(context).size;
    return BackgroundUnlogged(
        headerText: "Welcome to Fitness!",
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 30,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        InputTextField(
                          label: 'Username',
                          onSaved: (value) {
                            userLogin.username = value;
                          },
                          validator: (value) {
                            if (value.length == 0)
                              return ("Username is required");
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        InputTextField(
                          label: 'Password',
                          password: true,
                          validator: (value) {
                            if (value.length == 0)
                              return ("Password is required");
                          },
                          onSaved: (value) {
                            userLogin.password = value;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(36),
                    ),
                    color: primaryColor,
                    onPressed: () async {
                      if (formKey.currentState.validate()) {
                        formKey.currentState.save();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Row(
                            children: <Widget>[
                              CircularProgressIndicator(),
                              Text("    Logging in...")
                            ],
                          ),
                        ));
                        var data = await UserServices().login(userLogin);
                        authInfo.state = data;
                        tracker.state.currentLocation = data.loggedLocation;
                        location.getCurrentLocation();
                        if (authInfo.state != null && data != null) {
                          List<WaterTaken> waterIntakes = await CalcServices()
                              .getWaterIntakeOfDay(
                                  authInfo.state.userId, authInfo.state.token);
                          List<WaterTaken> waterTaken = await CalcServices()
                              .getAllWaterIntake(authInfo.state);
                          waterTaken.forEach((element) {
                            waterIntake.state += element.amount;
                          });
                          waterIntakes.forEach((element) {
                            waterIntake.state += element.amount;
                          });
                          Navigator.pushNamedAndRemoveUntil(context,
                              '/dashboard', (Route<dynamic> route) => false);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.error,
                                  color: Colors.white,
                                ),
                                Text(
                                    "    Incorrect username/password, Please try again")
                              ],
                            ),
                          ));
                        }
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      alignment: Alignment.center,
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 16,
                  ),
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/register");
                    },
                    child: RichText(
                      text: TextSpan(
                          style: TextStyle(color: Colors.black38),
                          children: [
                            TextSpan(text: 'Don\'t have an account? '),
                            TextSpan(
                              text: 'Register',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ]),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
