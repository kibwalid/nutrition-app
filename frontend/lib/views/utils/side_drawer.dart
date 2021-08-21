import 'package:fitness/config/theme.dart';
import 'package:fitness/providers/user_provider.dart';
import 'package:fitness/services/location_services.dart';
import 'package:fitness/services/user_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SideDrawer extends HookWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final authInfo = useProvider(authInfoProvider);

    return FutureBuilder(
        future: UserServices().getCurrentUserInfo(authInfo.state),
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
                                "${snapshot.data.firstName} ${snapshot.data.lastName}",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20.0),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft + Alignment(0, .7),
                            child: new Text(
                              "@${snapshot.data.username}",
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
                        Navigator.of(context).pushNamed("/exercise/history");
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
                        onTap: () {
                          LocationServices().resetLocationService();
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/', (Route<dynamic> route) => false);
                        }),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
