// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentloppet/Constants/constants.dart';
import 'package:studentloppet/Screens/login_signup/signup_screen.dart';
import 'package:studentloppet/Screens/reset_screens/forgot_password_screen.dart';
import 'package:studentloppet/User/user.dart';
import 'package:studentloppet/networking/network.dart';
import 'package:studentloppet/routes/app_routes.dart';
import 'package:studentloppet/theme/app_decoration.dart';
import 'package:studentloppet/theme/custom_text_style.dart';
import 'package:studentloppet/theme/theme_helper.dart';
import 'package:studentloppet/Constants/image_constant.dart';
import 'package:studentloppet/utils/size_utils.dart';
import 'package:studentloppet/utils/snackbars_util.dart';
import 'package:studentloppet/utils/validation_functions.dart';
import 'package:studentloppet/widgets/custom_helpers/custom_image_view.dart';
import 'package:studentloppet/widgets/custom_helpers/custom_outlined_button.dart';
import '../../widgets/custom_helpers/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key})
      : super(
          key: key,
        );

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<LoginScreen> {
  TextEditingController userNameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: SizeUtils.width,
          height: SizeUtils.height,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  ImageConstant.imgLoginBckg,
                ),
                fit: BoxFit.fill),
          ),
          child: SizedBox(
            width: SizeUtils.width,
            child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(
                  horizontal: 12.h,
                  vertical: 13.v,
                ),
                child: Column(children: [
                  SizedBox(
                    height: 25.h,
                  ),
                  _buildTopBar(),
                  Container(
                      margin: EdgeInsets.all(10),
                      decoration: AppDecoration.outlineWhite.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder11,
                      ),
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        elevation: 0,
                        margin: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: theme.colorScheme.onPrimaryContainer,
                            width: 1.h,
                          ),
                          borderRadius: BorderRadiusStyle.roundedBorder10,
                        ),
                        child: Container(
                          height: 275.v,
                          width: 313.h,
                          padding: EdgeInsets.all(5.h),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  height: 546.v,
                                  width: 298.h,
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.onPrimaryContainer,
                                    borderRadius: BorderRadius.circular(
                                      5.h,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: 16.h,
                                    right: 25.h,
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10.v),
                                      Text(
                                        "Logga in",
                                        style: theme.textTheme.headlineSmall,
                                      ),
                                      SizedBox(height: 14.v),
                                      _buildInputEmail(context),
                                      SizedBox(height: 14.v),
                                      _buildInputPassword(context),
                                      SizedBox(height: 20.v),
                                      _buildButton(user),
                                      SizedBox(height: 14.v),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ForgotPasswordScreen()),
                                            );
                                          },
                                          child: Text(
                                            "Glömt ditt lösenord",
                                            style: CustomTextStyles
                                                .bodySmallBlack900
                                                .copyWith(
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 150.h,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Har du inget konto? ",
                          style: CustomTextStyles.smallTextWhite,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupScreen()),
                            );
                          },
                          child: Text(
                            "Skapa konto nu",
                            style: CustomTextStyles.smallTextWhiteUnderlined
                                .copyWith(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              decorationThickness: 4.0,
                              decorationColor: Colors.white,
                              decorationStyle: TextDecorationStyle.solid,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ])),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Column(
      children: [
        Container(
          width: 300.h,
          margin: EdgeInsets.symmetric(horizontal: 23.h),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Studentloppet\n",
                  style: theme.textTheme.displayMedium,
                ),
                TextSpan(
                  text: "en del av",
                  style: CustomTextStyles.titleLargeSansationLight,
                )
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 5.v),
        CustomImageView(
          imagePath: ImageConstant.imgLogo,
          height: 56.v,
          width: 400.h,
          fit: BoxFit.contain,
        ),
        SizedBox(height: 20.v),
      ],
    );
  }

  Widget _buildButton(User user) {
    return Container(
      decoration: AppDecoration.outlineOrange.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: CustomOutlinedButton(
        margin: EdgeInsets.all(5),
        buttonStyle: ButtonStyle(
            side: MaterialStateBorderSide.resolveWith(
                (states) => BorderSide(style: BorderStyle.none)),
            shape: MaterialStateProperty.resolveWith<OutlinedBorder?>(
              (states) => RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(10)),
            ),
            backgroundColor:
                MaterialStateColor.resolveWith((states) => appTheme.orange)),
        text: "Logga in",
        buttonTextStyle: theme.textTheme.labelSmall,
        onPressed: () async {
          await Signin(context, user);
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildInputPassword(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Lösenord",
          style: CustomTextStyles.bodySmallBlack900_1.copyWith(
            color: appTheme.black900.withOpacity(0.63),
          ),
        ),
        SizedBox(height: 5.v),
        CustomTextFormField(
          controller: passwordController,
          hintText: "Skriv in ditt lösenord",
          obscureText: true,
        )
      ],
    );
  }

  /// Section Widget
  Widget _buildInputEmail(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Email",
          style: CustomTextStyles.bodySmallBlack900_1.copyWith(
            color: appTheme.black900.withOpacity(0.63),
          ),
        ),
        SizedBox(height: 4.v),
        CustomTextFormField(
          controller: userNameController,
          hintText: "Skriv in ditt universitets email",
          textInputType: TextInputType.emailAddress,
        )
      ],
    );
  }

  Future<void> Signin(BuildContext context, User user) async {
    //TODO REMOVE
    if (passwordController.text.contains("hej")) {
      Navigator.pushNamed(context, AppRoutes.homeScreen);
      return;
    }

    if (userNameController.text.isEmpty) {
      showErrorSnackbar(context, emptyEmail);
      return;
    }

    if (passwordController.text.isEmpty) {
      showErrorSnackbar(context, emptyPassword);
      return;
    }

    if (!isValidEmail(userNameController.text)) {
      showErrorSnackbar(context, invalidEmail);
      return;
    }

    if (!isValidPassword(passwordController.text)) {
      showErrorSnackbar(context, invalidPassword);
      return;
    }

    final response = await network.callLogIn(
        userNameController.text, passwordController.text);

    if (response.statusCode == 200) {
      print("Response: " + response.body);
      if (response.body.contains(userNameController.text)) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        user.setUser(
          newEmail: responseBody['email'] as String?,
          newScore: responseBody['score'] as int?,
          newFirstName: responseBody['firstName'] as String?,
          newLastName: responseBody['lastName'] as String?,
          newUniversity: responseBody['university'] as String?,
        );
        Navigator.pushNamed(context, AppRoutes.homeScreen);
      } else {
        showErrorSnackbar(context, "Invalid email or password");
      }
    } else {
      print("Error: " + response.statusCode.toString());
      showErrorSnackbar(context, "invalid email or password");
    }
  }

  onTapArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }
}
