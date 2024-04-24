import 'package:flutter/material.dart';
import 'package:studentloppet/Screens/reset_screens/forgot_password_screen.dart';
import 'package:studentloppet/Screens/login_screen.dart';
import 'package:studentloppet/Screens/signup_screen.dart';
import 'package:studentloppet/Screens/home_screen.dart';
import 'package:studentloppet/Screens/reset_screens/verify_otp_screen.dart';
import 'package:studentloppet/Screens/reset_screens/update_password_screen.dart';


class AppRoutes {
  static const String initialRoute = '/initialRoute';

  static const String signupScreen = '/Screens/signup_screen.dart';

  static const String homeScreen = '/Screens/home_screen.dart';

  static const String forgotPasswordScreen =
      '/Screens/forgot_password_screen.dart';

  static const String verifyOtpScreen = '/Screens/verify_otp_screen.dart';

  static const String updatePasswordScreen = '/Screens/update_password_screen.dart';

  static Map<String, WidgetBuilder> routes = {
    initialRoute: (context) => LoginScreen(),
    signupScreen: (context) => SignupScreen(),
    homeScreen: (context) => HomeScreen(),
    forgotPasswordScreen: (context) => ForgotPasswordScreen(),
    verifyOtpScreen: (context) => VerifyOtpScreen(),
    updatePasswordScreen:(context) => UpdatePasswordScreen(),
  };
}
