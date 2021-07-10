import 'package:fitness/config/theme.dart';
import 'package:fitness/views/utils/background_unlogged.dart';
import 'package:fitness/views/utils/input_text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String username = "";
    String password = "";
    Size size = MediaQuery.of(context).size;
    return BackgroundUnlogged(
        child: SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Text(
                'Welcome to Fitness!',
                style: TextStyle(
                  color: primaryTextColor,
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
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
                        username = value;
                      },
                      validator: (value) {
                        if (value.length == 0) return ("Username is required");
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    InputTextField(
                      label: 'Password',
                      password: true,
                      validator: (value) {
                        if (value.length == 0) return ("Password is required");
                      },
                      onSaved: (value) {
                        password = value;
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
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    formKey.currentState.save();
                    print(username);
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
