import 'package:flutter/material.dart';
import 'package:studentloppet/Screens/login_screen.dart';

class AppRoutes {
  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> routes = {
    initialRoute: (context) => LoginScreen()
  };
}
