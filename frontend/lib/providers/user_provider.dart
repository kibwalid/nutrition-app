import 'package:fitness/models/auth_info.dart';
import 'package:fitness/models/diet_plan.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authInfoProvider = StateProvider<AuthInfo>((ref) => null);

final dietPlanProvider = StateProvider<DietPlan>((ref) => null);
