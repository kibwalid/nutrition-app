import 'package:fitness/views/ui/auth/login_screen.dart';
import 'package:fitness/views/ui/auth/register_screen.dart';
import 'package:flutter/widgets.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => LoginScreen(),
  "/register": (BuildContext context) => RegisterScreen(),
};
