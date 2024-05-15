import 'package:flutter/material.dart';
import 'package:studentloppet/Screens/app_screens/profile_screen_test.dart';
import 'package:studentloppet/Screens/app_screens/run_screens/run_screen.dart';
import 'package:studentloppet/Screens/login_signup/signup_details_screen.dart';
import 'package:studentloppet/Screens/login_signup/signup_successful.dart';
import 'package:studentloppet/Screens/reset_screens/forgot_password_screen.dart';
import 'package:studentloppet/Screens/login_signup/login_screen.dart';
import 'package:studentloppet/Screens/login_signup/signup_screen.dart';
import 'package:studentloppet/Screens/app_screens/home_screen.dart';
import 'package:studentloppet/Screens/reset_screens/verify_otp_screen.dart';
import 'package:studentloppet/Screens/reset_screens/update_password_screen.dart';

class AppRoutes {
  static const String initialRoute = '/initialRoute';

  static const String signupScreen = '/Screens/signup_screen.dart';

  static const String homeScreen = '/Screens/home_screen.dart';

  static const String forgotPasswordScreen =
      '/Screens/forgot_password_screen.dart';

  static const String verifyOtpScreen = '/Screens/verify_otp_screen.dart';

  static const String updatePasswordScreen =
      '/Screens/update_password_screen.dart';

  static const String signUpDetailsScreen =
      '/Screens/signup_details_screen.dart';

  static const String profileScreen = '/Screens/profileScreen';

  static const String runScreen = '/Screens/app_screens/run_screen.dart';

  static const String signUpSuccess =
      '/Screens/app_screens/signup_successful.dart';

  static const String profileScreenTest = '/Screens/profile_screen_test.dart';

  static Map<String, WidgetBuilder> routes = {
    initialRoute: (context) => LoginScreen(),
    signupScreen: (context) => SignupScreen(),
    homeScreen: (context) => HomeScreen(),
    forgotPasswordScreen: (context) => ForgotPasswordScreen(),
    verifyOtpScreen: (context) => VerifyOtpScreen(),
    updatePasswordScreen: (context) => UpdatePasswordScreen(),
    signUpDetailsScreen: (context) => SignupDetailsScreen(),
    profileScreenTest: (context) => ProfileScreenTest(),
    runScreen: (context) => RunScreen(),
    signUpSuccess: (context) => SignUpSuccess(),
  };
}
