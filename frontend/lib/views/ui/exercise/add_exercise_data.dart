import 'package:fitness/providers/exercise_providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

class AddExercise extends HookWidget {
  @override
  Widget build(BuildContext context) {
    print("build");
    final counterProvider = useProvider(exerciseCountStateProvider);
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 400,
              ),
              Center(
                child:
                    Text("Counter:      " + counterProvider.state.toString()),
              ),
              ElevatedButton(
                  onPressed: () {
                    counterProvider.state++;
                  },
                  child: Text("Add"))
            ],
          ),
        ),
      ),
    );
  }
}
