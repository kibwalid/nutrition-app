import 'package:fitness/views/utils/background.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      leading: BackButton(
        color: Colors.black,
      ),
      header: "Settings",
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
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * .02,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed("/change/password");
                  },
                  child: Container(
                    child: ListTile(
                      title: Text('Change Password'),
                      leading: Icon(Icons.lock),
                    ),
                  ),
                ),
                _buildDivider(),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed("/profile");
                  },
                  child: Container(
                    child: ListTile(
                      title: Text('Access your Information'),
                      subtitle: Text('View Your information'),
                      leading: Icon(Icons.perm_identity_rounded),
                    ),
                  ),
                ),
                _buildDivider(),
              ],
            ),
          ))
        ],
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }
}
