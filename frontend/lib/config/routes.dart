import 'package:fitness/views/ui/auth/login_screen.dart';
import 'package:fitness/views/ui/auth/register_screen.dart';
import 'package:fitness/views/ui/calorie_calculator/calorie_calculator.dart';
import 'package:fitness/views/ui/dashboard/dashboard.dart';
import 'package:fitness/views/ui/diet_planner/diet_create_one.dart';
import 'package:fitness/views/ui/diet_planner/diet_planner.dart';
import 'package:fitness/views/ui/eTrainer/e_trainer.dart';
import 'package:fitness/views/ui/eTrainer/exercise_history.dart';
import 'package:fitness/views/ui/eTrainer/single_training.dart';
import 'package:fitness/views/ui/exercise/add_exercise_data.dart';
import 'package:fitness/views/ui/running_tracker/running_tracker.dart';
import 'package:fitness/views/ui/running_tracker/single_tracking.dart';
import 'package:fitness/views/ui/running_tracker/track_history.dart';
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
  "/track/history": (BuildContext context) => TrackHistory(),
  "/track/single": (BuildContext context) => SingleTracking(),
  "/etrainer": (BuildContext context) => ETrainer(),
  "/etrainer/single": (BuildContext context) => SingleTraining(),
  "/exercise/history": (BuildContext context) => ExerciseHistory(),
  "/water/intake": (BuildContext context) => WaterIntake(),
  "/water/history": (BuildContext context) => IntakeHistory(),
  "/diet/plan": (BuildContext context) => DietPlanner(),
  "/diet/create/one": (BuildContext context) => DietCreateOne(),
};
