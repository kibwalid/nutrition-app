import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

class AddExercise extends HookWidget {
  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            children: [
              // SizedBox(
              //   height: 400,
              // ),
              // Center(
              //   child:
              //       Text("Counter:      " + counterProvider.state.toString()),
              // ),
              // ElevatedButton(
              //     onPressed: () {
              //       counterProvider.state++;
              //     },
              // child: Text("Add"))
            ],
          ),
        ),
      ),
    );
  }
}
