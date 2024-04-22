import 'package:flutter/material.dart';
import 'package:studentloppet/theme/app_decoration.dart';
import 'package:studentloppet/theme/custom_button_style.dart';
import 'package:studentloppet/theme/custom_text_style.dart';
import 'package:studentloppet/theme/theme_helper.dart';
import 'package:studentloppet/utils/size_utils';

import '../routes/app_routes.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_outlined_button.dart';
import '../widgets/custom_text_form_field.dart';

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
                    SizedBox(height: 5.v)
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

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                  TextSpan(
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
            "Username",
            style: theme.textTheme.titleSmall,
          ),
          SizedBox(height: 5.v),
          CustomTextFormField(
            controller: userNameController,
            hintText: "Enter your username",
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
            onPressed: () {
              //TODO
            },
          ),
          CustomElevatedButton(
            width: 164.h,
            text: "Log In",
            margin: EdgeInsets.only(left: 8.h),
            buttonTextStyle: CustomTextStyles.titleMediumWhiteA700,
            onPressed: () {
              //TODO
            },
          )
        ],
      ),
    );
  }
}
