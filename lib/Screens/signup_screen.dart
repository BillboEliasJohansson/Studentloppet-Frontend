// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:studentloppet/networking/network.dart';
import 'package:studentloppet/routes/app_routes.dart';
import 'package:studentloppet/theme/custom_text_style.dart';
import 'package:studentloppet/theme/theme_helper.dart';
import 'package:studentloppet/utils/image_constant.dart';
import 'package:studentloppet/utils/size_utils.dart';
import 'package:studentloppet/utils/validation_functions.dart';
import 'package:studentloppet/utils/snackbars_util.dart';
import 'package:studentloppet/widgets/custom_dropdownmenu.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController fullNameController = TextEditingController();

  TextEditingController universityplaceController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController graduationyearpController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
              key: _formKey,
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(
                  horizontal: 12.h,
                  vertical: 13.v,
                ),
                child: Column(
                  children: [
                    _buildInputUniversityDropDown(context),
                    SizedBox(height: 14.v),
                    _buildInputFullName(context),
                    SizedBox(height: 14.v),
                    _buildInputUniversityPlace(context),
                    SizedBox(height: 14.v),
                    _buildInputEmail(context),
                    SizedBox(height: 14.v),
                    _buildInputPassword(context),
                    SizedBox(height: 14.v),
                    _buildInputGraduationYearP(context),
                    SizedBox(height: 14.v),
                    CustomElevatedButton(
                      text: "Submit",
                      buttonTextStyle: CustomTextStyles.titleMediumWhiteA700,
                      onPressed: () async {
                        await Signup(context);
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

  Future<void> Signup(BuildContext context) async {
    if (!isValidEmail(emailController.text)) {
      showErrorSnackbar(context, "Invalid Email");
      return;
    }
    if (!isValidPassword(passwordController.text)) {
      showErrorSnackbar(context, "Invalid Password");
      return;
    }

    // Fetch data asynchronously and wait for the result
    final response = await network.callSignUp(universityplaceController.text,
        emailController.text, passwordController.text);

    // Check if the request was successful
    if (response.statusCode == 200) {
      print("Response: " + response.body);
      if (response.body.contains("saved")) {
        showSuccesfulSnackbar(context, "Success");
        Navigator.pushNamed(context, AppRoutes.initialRoute);
      }
      if (response.body.contains("Email not valid")) {
        showErrorSnackbar(context, "Email not valid");
      }
      if (response.body.contains("Email already exists")) {
        showErrorSnackbar(context, "Email already exists");
      }
    } else {
      showErrorSnackbar(context, "Internal Server Error");
      print("Error: " + response.statusCode.toString());
    }
  }

  /// Section Widget
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
        text: "University Runner Sign Up",
        margin: EdgeInsets.only(left: 8.h),
      ),
      styleType: Style.bgShadow,
    );
  }

  /// Section Widget
  Widget _buildInputFullName(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Full Name",
          style: theme.textTheme.titleSmall,
        ),
        SizedBox(height: 5.v),
        CustomTextFormField(
          controller: fullNameController,
          hintText: "Enter your full name",
        )
      ],
    );
  }

  Widget _buildInputUniversityDropDown(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Full Name",
          style: theme.textTheme.titleSmall,
        ),
        SizedBox(height: 5.v),
        CustomDropDownMenu(entries: <DropdownMenuEntry<Color>>[
          DropdownMenuEntry(value: Colors.red, label: "Uppsala Universitet"),
          DropdownMenuEntry(value: Colors.black, label: "black")
        ])
      ],
    );
  }

  /// Section Widget
  Widget _buildInputPassword(BuildContext context) {
    return Column(
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
          obscureText: true,
        )
      ],
    );
  }

  /// Section Widget
  Widget _buildInputUniversityPlace(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "University",
          style: theme.textTheme.titleSmall,
        ),
        SizedBox(height: 4.v),
        CustomTextFormField(
          controller: universityplaceController,
          hintText: "Enter your University",
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
          "University Email",
          style: theme.textTheme.titleSmall,
        ),
        SizedBox(height: 4.v),
        CustomTextFormField(
          controller: emailController,
          hintText: "Enter your university email",
          textInputType: TextInputType.emailAddress,
        )
      ],
    );
  }

  /// Section Widget
  Widget _buildInputGraduationYearP(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Graduation year",
          style: theme.textTheme.titleSmall,
        ),
        SizedBox(height: 4.v),
        CustomTextFormField(
          controller: graduationyearpController,
          hintText: "Enter when you are graduating",
          textInputAction: TextInputAction.done,
        )
      ],
    );
  }

  /// Navigates back to the previous screen.
  onTapArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }
}
