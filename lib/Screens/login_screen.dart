// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:studentloppet/Screens/signup_screen.dart';
import 'package:studentloppet/routes/app_routes.dart';
import 'package:studentloppet/theme/app_decoration.dart';
import 'package:studentloppet/theme/custom_button_style.dart';
import 'package:studentloppet/theme/custom_text_style.dart';
import 'package:studentloppet/theme/theme_helper.dart';
import 'package:studentloppet/utils/size_utils.dart';
import 'package:studentloppet/networking/network.dart';

import '../utils/snackbars_util.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_outlined_button.dart';
import '../widgets/custom_text_form_field.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _formKey,
              child: SizedBox(
                width: double.maxFinite,
                child: Column(
                  children: [
                    _buildTopbar(context),
                    SizedBox(height: 13.v),
                    _buildInput(context),
                    SizedBox(height: 13.v),
                    _buildInput1(context),
                    SizedBox(height: 12.v),
                    _buildButton(context),
                    SizedBox(height: 12.v),
                    Container(
                      width: 294.h,
                      margin: EdgeInsets.symmetric(horizontal: 32.h),
                      child: Text(
                        "Join the Running Community at your University",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleMedium!.copyWith(
                          height: 1.33,
                        ),
                      ),
                    ),
                    SizedBox(height: 5.v),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPasswordScreen()),
                        );
                      },
                      child: Text(
                        "Forgot password?",
                        style: theme.textTheme.bodyText1!.copyWith(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextEditingController userNameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// Section Widget
  Widget _buildTopbar(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 106.h,
        vertical: 2.v,
      ),
      decoration: AppDecoration.outlinePrimary,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 8.v),
          SizedBox(
            width: 143.h,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "StudentLoppet   \n",
                    style: theme.textTheme.titleLarge,
                  ),
                  TextSpan(
                    text: "Part of the Midnight Race",
                    style: theme.textTheme.labelLarge,
                  ),
                  const TextSpan(
                    text: "        ",
                  )
                ],
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildInput(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Email",
            style: theme.textTheme.titleSmall,
          ),
          SizedBox(height: 5.v),
          CustomTextFormField(
            controller: userNameController,
            hintText: "Enter your email",
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildInput1(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Password",
            style: theme.textTheme.titleSmall,
          ),
          SizedBox(height: 5.v),
          CustomTextFormField(
            controller: passwordController,
            hintText: "Enter your password",
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.visiblePassword,
            obscureText: true,
          )
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomOutlinedButton(
            width: 164.h,
            text: "Sign Up",
            buttonStyle: CustomButtonStyles.outlinePrimaryTL8,
            buttonTextStyle: CustomTextStyles.titleMedium16,
            onPressed: () async {
              Navigator.pushNamed(context, AppRoutes.signupScreen);
            },
          ),
          CustomElevatedButton(
            width: 164.h,
            text: "Log In",
            margin: EdgeInsets.only(left: 8.h),
            buttonTextStyle: CustomTextStyles.titleMediumWhiteA700,
            onPressed: () async {
              await Signin(context);
            },
          )
        ],
      ),
    );
  }

  Future<void> Signin(BuildContext context) async {
    // Fetch data asynchronously and wait for the result
    final response = await network.callLogIn(
        userNameController.text, passwordController.text);

    // Check if the request was successful
    if (response.statusCode == 200) {
      // Print the body of the HTTP response
      print("Response: " + response.body);
      if (response.body == "true") {
        Navigator.pushNamed(context, AppRoutes.homeScreen);
      } else {
        showErrorSnackbar(context, "Invalid Email Or Password");
      }
    } else {
      print("Error: " + response.statusCode.toString());
      showErrorSnackbar(context, "Invalid Email Or Password");
    }
  }
}
