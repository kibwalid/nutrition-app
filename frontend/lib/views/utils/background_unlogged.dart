import 'package:fitness/config/theme.dart';
import 'package:flutter/material.dart';

class BackgroundUnlogged extends StatelessWidget {
  final Widget child;
  final String headerText;
  final Widget leading;
  const BackgroundUnlogged({
    Key key,
    @required this.child,
    this.headerText = "",
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          headerText,
          style: TextStyle(
            color: primaryTextColor,
          ),
        ),
        leading: leading,
      ),
      backgroundColor: backgroundColor,
      body: Container(
        height: size.height,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              bottom: size.height * 0.5,
              left: 0,
              child: Image.asset(
                "assets/images/bg1.png",
              ),
            ),
            child
          ],
        ),
      ),
    );
  }
}
