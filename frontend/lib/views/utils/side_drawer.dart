import 'package:fitness/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SideDrawer extends HookWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    _onload() async {
      return 1;
    }

    return FutureBuilder(
        future: _onload(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Drawer(
              child: Container(
                color: Colors.black12,
                child: new ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    new DrawerHeader(
                      decoration: BoxDecoration(
                        color: primaryTextColor,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: new AssetImage(
                                'assets/icons/fitness_logo.png')),
                      ),
                      child: Stack(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed("/profile/user");
                            },
                            child: Align(
                              alignment:
                                  Alignment.centerLeft + Alignment(0, .4),
                              child: new Text(
                                "Khalid Ibnul",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20.0),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft + Alignment(0, .7),
                            child: new Text(
                              "@username",
                              style: TextStyle(
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.dashboard),
                      title: Text('Dashboard'),
                      onTap: () {
                        Navigator.of(context).pushNamed("/dashboard");
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.account_circle_rounded),
                      title: Text('My Profile'),
                      onTap: () {
                        Navigator.of(context).pushNamed("/profile");
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.description),
                      title: Text('Exercise History'),
                      onTap: () {
                        Navigator.of(context).pushNamed("/sightings/own");
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text('Settings'),
                      onTap: () {
                        Navigator.of(context).pushNamed("/settings");
                      },
                    ),
                    Divider(),
                    ListTile(
                        title: Text('Logout'),
                        leading: Icon(Icons.exit_to_app),
                        onTap: () {}),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error);
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
