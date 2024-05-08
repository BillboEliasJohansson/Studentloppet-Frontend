// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentloppet/Constants/constants.dart';
import 'package:studentloppet/User/user.dart';
import 'package:studentloppet/networking/network.dart';
import 'package:studentloppet/routes/app_routes.dart';
import 'package:studentloppet/theme/app_decoration.dart';
import 'package:studentloppet/theme/custom_text_style.dart';
import 'package:studentloppet/theme/theme_helper.dart';
import 'package:studentloppet/utils/image_constant.dart';
import 'package:studentloppet/utils/size_utils.dart';
import 'package:studentloppet/utils/snackbars_util.dart';
import 'package:studentloppet/utils/validation_functions.dart';
import 'package:studentloppet/widgets/custom_helpers/custom_image_view.dart';
import 'package:studentloppet/widgets/custom_helpers/custom_outlined_button.dart';
import 'package:studentloppet/widgets/custom_helpers/custom_text_form_field.dart';

class UpdatePasswordScreen extends StatelessWidget {
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordControllerTwo = TextEditingController();

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
                          height: 260.v,
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
                                    left: 10.h,
                                    right: 19.h,
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10.v),
                                      Text(
                                        "Återställ Lösenord",
                                        style: theme.textTheme.headlineSmall,
                                      ),
                                      SizedBox(height: 30.v),
                                      _buildInputPassword(context),
                                      SizedBox(height: 14.v),
                                      _buildInputPasswordCheck(context),
                                      SizedBox(height: 14.v),
                                      _buildButton(context, user),
                                      SizedBox(height: 14.v),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
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

  Widget _buildButton(BuildContext context, User user) {
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
        text: "Återställ",
        buttonTextStyle: theme.textTheme.labelSmall,
        onPressed: () async {
          await changePassword(context, user);
        },
      ),
    );
  }

  Widget _buildInputPassword(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Ange Lösenord",
          style: CustomTextStyles.bodySmallBlack900_1.copyWith(
            color: appTheme.black900.withOpacity(0.63),
          ),
        ),
        SizedBox(height: 4.v),
        CustomTextFormField(
          controller: passwordController,
          hintText: "Skriv in ditt nya lösenord",
          textInputType: TextInputType.visiblePassword,
          obscureText: true,
        )
      ],
    );
  }

  Widget _buildInputPasswordCheck(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Upprepa Lösenord",
          style: CustomTextStyles.bodySmallBlack900_1.copyWith(
            color: appTheme.black900.withOpacity(0.63),
          ),
        ),
        SizedBox(height: 4.v),
        CustomTextFormField(
          controller: passwordControllerTwo,
          hintText: "Skriv in ditt nya lösenord igen",
          textInputType: TextInputType.visiblePassword,
          obscureText: true,
        )
      ],
    );
  }

  Future<void> changePassword(BuildContext context, user) async {
    if (passwordController.text.isEmpty || passwordControllerTwo.text.isEmpty) {
      showErrorSnackbar(context, emptyPassword);
      return;
    }

    if (!isValidPassword(passwordController.text)) {
      showErrorSnackbar(context, invalidPassword);
      return;
    }

    if (passwordController.text != passwordControllerTwo.text) {
      showErrorSnackbar(context, passwordNotSame);
      return;
    }

    Map<String, String> passwordData = {
      'password': passwordController.text,
      'repeatedPassword': passwordControllerTwo.text,
    };

    final response = await network.updatePassword(passwordData, user.email);

    if (response.statusCode == 200) {
      if (response.body.contains("Password has updated sucessfully")) {
        showSuccesfulSnackbar(context, "Success");
        Navigator.pushNamed(context, AppRoutes.initialRoute);
      }
      if (response.body.contains("Enter the password again")) {
        showErrorSnackbar(context, "Invalid password");
      }
    } else {
      showErrorSnackbar(context, "Internal Server Error");
    }
  }
}
