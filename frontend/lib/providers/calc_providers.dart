import 'package:fitness/models/food_item.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final changeState = StateProvider<FoodItem>((ref) => FoodItem());
