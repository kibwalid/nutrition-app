import 'package:fitness/views/ui/auth/login_screen.dart';
import 'package:fitness/views/ui/auth/register_screen.dart';
import 'package:fitness/views/ui/calorie_calculator/calorie_calculator.dart';
import 'package:fitness/views/ui/dashboard/dashboard.dart';
import 'package:fitness/views/ui/eTrainer/e_trainer.dart';
import 'package:fitness/views/ui/exercise/add_exercise_data.dart';
import 'package:fitness/views/ui/running_tracker/running_tracker.dart';
import 'package:fitness/views/ui/water_intake/intake_history.dart';
import 'package:fitness/views/ui/water_intake/water_intake.dart';
import 'package:flutter/widgets.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => LoginScreen(),
  "/register": (BuildContext context) => RegisterScreen(),
  "/dashboard": (BuildContext context) => Dashboard(),
  "/calc/calore": (BuildContext context) => CalorieCalculator(),
  "/exercise/add": (BuildContext context) => AddExercise(),
  "/track/running": (BuildContext context) => RunningTracker(),
  "/etrainer": (BuildContext context) => ETrainer(),
  "/water/intake": (BuildContext context) => WaterIntake(),
  "/water/history": (BuildContext context) => IntakeHistory(),
};
