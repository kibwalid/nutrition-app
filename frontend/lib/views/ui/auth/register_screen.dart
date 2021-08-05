import 'package:fitness/config/theme.dart';
import 'package:fitness/models/user_info.dart';
import 'package:fitness/providers/running_tracker_providers.dart';
import 'package:fitness/providers/user_provider.dart';
import 'package:fitness/services/user_services.dart';
import 'package:fitness/views/utils/background_unlogged.dart';
import 'package:fitness/views/utils/input_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RegisterScreen extends HookWidget {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    UserInfo userInfo = UserInfo();
    userInfo.userLogin = UserLogin();

    Size size = MediaQuery.of(context).size;
    final authInfo = context.read(authInfoProvider);
    final tracker = context.read(trackerStateProvider);
    final location = context.read(locationStateNotifier);
    return BackgroundUnlogged(
        headerText: "Register",
        leading: BackButton(
          color: primaryColor,
        ),
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
                          label: 'First Name',
                          onSaved: (value) {
                            userInfo.firstName = value;
                          },
                          validator: (value) {
                            if (value.length == 0)
                              return ("First Name is required");
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        InputTextField(
                          label: 'Last Name',
                          onSaved: (value) {
                            userInfo.lastName = value;
                          },
                          validator: (value) {
                            if (value.length == 0)
                              return ("Last Name is required");
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        InputTextField(
                          label: 'Height (In Ft.)',
                          keyboardType: TextInputType.number,
                          onSaved: (value) {
                            userInfo.userHeight = double.parse(value);
                          },
                          validator: (value) {
                            if (value.length == 0)
                              return ("Height is required");
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        InputTextField(
                          label: 'Weight (In Kg)',
                          keyboardType: TextInputType.number,
                          onSaved: (value) {
                            userInfo.userWeight = double.parse(value);
                          },
                          validator: (value) {
                            if (value.length == 0)
                              return ("Weight is required");
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        InputTextField(
                          label: 'Username',
                          onSaved: (value) {
                            userInfo.userLogin.username = value;
                            userInfo.username = value;
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
                            userInfo.userLogin.password = value;
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
                        var data = await UserServices().register(userInfo);
                        authInfo.state = data;
                        tracker.state.currentLocation = data.loggedLocation;
                        location.getCurrentLocation();
                        if (authInfo.state != null && data != null) {
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
                                new Text("     Username already taken")
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
                        'Register',
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
                      Navigator.pushNamed(context, "/");
                    },
                    child: RichText(
                      text: TextSpan(
                          style: TextStyle(color: Colors.black38),
                          children: [
                            TextSpan(text: 'Already have an account? '),
                            TextSpan(
                              text: 'Login',
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
