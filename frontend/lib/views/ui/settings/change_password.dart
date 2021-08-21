import 'package:fitness/views/utils/background.dart';
import 'package:fitness/views/utils/input_text_field.dart';
import 'package:fitness/views/utils/rounded_button.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      leading: BackButton(
        color: Colors.black,
      ),
      header: "Change Password",
      headerColor: Colors.black,
      child: Stack(
        children: [
          Container(
            height: size.height * 1,
            decoration: BoxDecoration(
              color: Color(0xFFECA9A7),
            ),
          ),
          SafeArea(
              child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Container(
                          width: size.width * 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: size.height * 0.1,
                              ),
                              InputTextField(
                                underLineColor: Colors.black,
                                labelColor: Colors.black,
                                label: "Old Password",
                                password: true,
                                validator: (val) {
                                  if (val.length == 0) {
                                    return "Password is required ";
                                  }
                                },
                                onSaved: (val) {},
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              InputTextField(
                                underLineColor: Colors.black,
                                labelColor: Colors.black,
                                label: "New Password",
                                password: true,
                                validator: (val) {
                                  if (val.length == 0) {
                                    return "New Password is required ";
                                  }
                                },
                                onSaved: (val) {},
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              InputTextField(
                                underLineColor: Colors.black,
                                labelColor: Colors.black,
                                label: "Re-type New Password",
                                password: true,
                                validator: (val) {
                                  if (val.length == 0) {
                                    return "ReNew Password is required ";
                                  }
                                },
                                onSaved: (val) {},
                              ),
                              SizedBox(
                                height: size.height * .04,
                              ),
                            ],
                          ),
                        ),
                        RoundedButton(
                          text: "test",
                          press: () {},
                        ),
                        SizedBox(
                          height: size.height * .02,
                        ),
                      ],
                    )),
              )
            ],
          )),
        ],
      ),
    );
  }
}
