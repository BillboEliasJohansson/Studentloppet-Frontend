import 'package:flutter/material.dart';
import 'package:studentloppet/Screens/login_screen.dart';
import 'package:studentloppet/Screens/signup_screen.dart';
import 'package:studentloppet/Screens/home_screen.dart';

class AppRoutes {
  static const String initialRoute = '/initialRoute';

  static const String signupScreen = '/Screens/signup_screen.dart';

  static const String homeScreen = '/Screens/home_screen.dart';

  static Map<String, WidgetBuilder> routes = {
    initialRoute: (context) => LoginScreen(),
    signupScreen: (context) => SignupScreen(),
    homeScreen: (context) => HomeScreen()
  };
}
