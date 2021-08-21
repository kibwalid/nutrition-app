import 'package:fitness/config/theme.dart';
import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
    Key key,
    this.label,
    this.onSaved,
    this.password = false,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.labelColor = Colors.grey,
    this.underLineColor = Colors.grey,
    this.hintText,
  }) : super(key: key);

  final String label;
  final String hintText;
  final Function onSaved;
  final Function validator;
  final bool password;
  final TextInputType keyboardType;
  final Color labelColor;
  final Color underLineColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onSaved: onSaved,
      keyboardType: keyboardType,
      obscureText: password,
      cursorColor: Colors.grey,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        labelStyle: TextStyle(color: labelColor),
        border: UnderlineInputBorder(
            borderSide: BorderSide(
          color: primaryColor,
          width: 2,
        )),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: primaryColor,
          width: 2,
        )),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: underLineColor,
          width: 0.5,
        )),
      ),
    );
  }
}
