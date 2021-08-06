import 'package:fitness/views/utils/background.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
        child: Stack(
          children: [
            Container(
              height: size.height * 0.5,
              decoration: BoxDecoration(
                color: Color(0xFF336655),
              ),
            ),
            SafeArea(
              child: Column(
                children: [],
              ),
            )
          ],
        ),
        header: "header");
  }
}