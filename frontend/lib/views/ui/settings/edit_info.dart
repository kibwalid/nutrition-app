import 'package:fitness/models/user_info.dart';
import 'package:fitness/providers/user_provider.dart';
import 'package:fitness/services/user_services.dart';
import 'package:fitness/views/utils/background.dart';
import 'package:fitness/views/utils/input_text_field.dart';
import 'package:fitness/views/utils/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditInfo extends HookWidget {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final authInfo = useProvider(authInfoProvider);

    onload() async {
      UserInfo userInfo =
          await UserServices().getCurrentUserInfo(authInfo.state);
      return userInfo;
    }

    return Background(
        leading: BackButton(
          color: Colors.black,
        ),
        headerColor: Colors.black,
        child: FutureBuilder(
            future: onload(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                UserInfo userInfo = snapshot.data;
                String fname = "";
                String lname = "";
                double height = 0;
                double weight = 0;
                return Stack(
                  children: [
                    Container(
                      height: size.height * 1,
                      decoration: BoxDecoration(
                        color: Color(0xFFECA9A7),
                      ),
                    ),
                    SingleChildScrollView(
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: size.height * 0.12,
                              ),
                              Form(
                                key: formKey,
                                child: Column(
                                  children: <Widget>[
                                    InputTextField(
                                      labelColor: Colors.black,
                                      underLineColor: Colors.black,
                                      label: 'First Name',
                                      hintText: userInfo.firstName,
                                      onSaved: (value) {
                                        fname = value.toString();
                                      },
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    InputTextField(
                                      labelColor: Colors.black,
                                      underLineColor: Colors.black,
                                      label: 'Last Name',
                                      hintText: userInfo.lastName,
                                      onSaved: (value) {
                                        lname = value.toString();
                                      },
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    InputTextField(
                                      labelColor: Colors.black,
                                      underLineColor: Colors.black,
                                      label: 'Height (In Ft.)',
                                      hintText: userInfo.userHeight.toString(),
                                      keyboardType: TextInputType.number,
                                      onSaved: (value) {
                                        if (value.length > 0) {
                                          height = double.parse(value);
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    InputTextField(
                                      labelColor: Colors.black,
                                      underLineColor: Colors.black,
                                      label: 'Weight (In Kg)',
                                      hintText: userInfo.userWeight.toString(),
                                      keyboardType: TextInputType.number,
                                      onSaved: (value) {
                                        if (value.length > 0) {
                                          weight = double.parse(value);
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    RoundedButton(
                                      text: "Submit",
                                      press: () async {
                                        if (formKey.currentState.validate()) {
                                          formKey.currentState.save();
                                          if (fname.length > 0) {
                                            userInfo.firstName = fname;
                                          }
                                          if (lname.length > 0) {
                                            userInfo.lastName = lname;
                                          }
                                          if (height > 0) {
                                            userInfo.userHeight = height;
                                          }
                                          print(weight);
                                          if (weight > 0) {
                                            userInfo.userWeight = weight;
                                          }
                                          UserInfo userInfoChanged =
                                              await UserServices()
                                                  .updateUserInfo(userInfo);
                                          if (userInfoChanged != null) {
                                            Navigator.popAndPushNamed(
                                                context, "/profile");
                                          }
                                        }
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                );
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
        header: "Edit Profile Information");
  }
}
