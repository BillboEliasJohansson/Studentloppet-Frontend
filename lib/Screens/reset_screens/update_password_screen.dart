// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentloppet/User/user.dart';
import 'package:studentloppet/networking/network.dart';
import 'package:studentloppet/routes/app_routes.dart';
import 'package:studentloppet/theme/custom_text_style.dart';
import 'package:studentloppet/theme/theme_helper.dart';
import 'package:studentloppet/utils/image_constant.dart';
import 'package:studentloppet/utils/size_utils.dart';
import 'package:studentloppet/utils/snackbars_util.dart';
import 'package:studentloppet/widgets/app_bar/appbar_leading_image.dart';
import 'package:studentloppet/widgets/app_bar/appbar_title.dart';
import 'package:studentloppet/widgets/app_bar/custom_app_bar.dart';
import 'package:studentloppet/widgets/custom_elevated_button.dart';
import 'package:studentloppet/widgets/custom_text_form_field.dart';

class UpdatePasswordScreen extends StatelessWidget {
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordControllerTwo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(
                  horizontal: 12.h,
                  vertical: 13.v,
                ),
                child: Column(
                  children: [
                    _buildInputPassword(context),
                    SizedBox(height: 14.v),
                    _buildInputPasswordCheck(context),
                    SizedBox(height: 14.v),
                    CustomElevatedButton(
                      text: "Submit",
                      buttonTextStyle: CustomTextStyles.titleMediumWhiteA700,
                      onPressed: () async {
                        await changePassword(context, user);
                      },
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

  Widget _buildInputPassword(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Enter Password",
          style: theme.textTheme.titleSmall,
        ),
        SizedBox(height: 4.v),
        CustomTextFormField(
          controller: passwordController,
          hintText: "Enter your password",
          textInputType: TextInputType.emailAddress,
        )
      ],
    );
  }

   Widget _buildInputPasswordCheck(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Enter Password Again",
          style: theme.textTheme.titleSmall,
        ),
        SizedBox(height: 4.v),
        CustomTextFormField(
          controller: passwordControllerTwo,
          hintText: "Enter your password",
          textInputType: TextInputType.emailAddress,
        )
      ],
    );
  }
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 32.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(
          left: 8.h,
          top: 12.v,
          bottom: 12.v,
        ),
        onTap: () {
          onTapArrowleftone(context);
        },
      ),
      title: AppbarTitle(
        text: "Update Password",
        margin: EdgeInsets.only(left: 8.h),
      ),
      styleType: Style.bgShadow,
    );
  }

  onTapArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }

  Future<void> changePassword(BuildContext context, user) async {
    if (passwordController.text.contains("hej")){
      showSuccesfulSnackbar(context, "Success");
      Navigator.pushNamed(context, AppRoutes.initialRoute);
      return;
    }

    // Fetch data asynchronously and wait for the result
    final response = await network.updatePassword(
      passwordController.text, user.email
    );

    // Check if the request was successful
    if (response.statusCode == 200) {
      print("Response: " + response.body);
      if (response.body.contains("token verified!")) {
        showSuccesfulSnackbar(context, "Success");
        Navigator.pushNamed(context, AppRoutes.initialRoute);
      }
      if (response.body.contains("Invalid token for") ||
          response.body.contains("Email not found")) {
        showErrorSnackbar(context, "Invalid");
      }
    } else {
      showErrorSnackbar(context, "Internal Server Error");
      print("Error: " + response.statusCode.toString());
    }
  }
}
