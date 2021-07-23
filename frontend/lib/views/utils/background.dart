import 'package:fitness/config/theme.dart';
import 'package:fitness/views/utils/side_drawer.dart';
import 'package:flutter/material.dart';

class Background extends StatefulWidget {
  final Widget child;
  final Widget leading;
  final String header;
  final Color headerColor;
  final Color appbarBG;
  final List<Widget> actions;

  const Background({
    Key key,
    @required this.child,
    this.leading,
    @required this.header,
    this.appbarBG = Colors.transparent,
    this.headerColor = primaryColor,
    this.actions,
  }) : super(key: key);

  @override
  _BackgroundState createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: new AppBar(
        leading: widget.leading,
        iconTheme: IconThemeData(color: primaryColor),
        title: Text(
          widget.header,
          style:
              TextStyle(fontWeight: FontWeight.bold, color: widget.headerColor),
        ),
        elevation: 0,
        backgroundColor: widget.appbarBG,
        actions: widget.actions,
      ),
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            widget.child,
          ],
        ),
      ),
      drawer: SideDrawer(),
    );
  }
}
