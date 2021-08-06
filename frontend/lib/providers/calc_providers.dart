import 'package:fitness/models/food_item.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final changeState = StateProvider<FoodItem>((ref) => FoodItem());

final waterIntakeState = StateProvider<double>((ref) => 0);

final fitnessGoalSelectState = StateProvider<int>((ref) => 0);

final fitnesDurationState = StateProvider<String>((ref) => "1 Week");
