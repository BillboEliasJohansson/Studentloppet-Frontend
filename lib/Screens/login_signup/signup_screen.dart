// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentloppet/User/user.dart';
import 'package:studentloppet/networking/network.dart';
import 'package:studentloppet/routes/app_routes.dart';
import 'package:studentloppet/theme/custom_text_style.dart';
import 'package:studentloppet/theme/theme_helper.dart';
import 'package:studentloppet/utils/image_constant.dart';
import 'package:studentloppet/utils/size_utils.dart';
import 'package:studentloppet/utils/validation_functions.dart';
import 'package:studentloppet/utils/snackbars_util.dart';
import 'package:studentloppet/widgets/custom_dropdownmenu.dart';
import '../../../widgets/app_bar/appbar_leading_image.dart';
import '../../../widgets/app_bar/appbar_title.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_text_form_field.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key})
      : super(
          key: key,
        );

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController fullNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController graduationyearpController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController universitySelectorController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<List<DropdownMenuEntry<String>>>? universityListFuture;

  late String uni;

  @override
  void initState() {
    super.initState();
    universityListFuture = network.requestUniverityList();
  }

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
              key: _formKey,
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(
                  horizontal: 12.h,
                  vertical: 13.v,
                ),
                child: Column(
                  children: [
                    _buildInputUniversityDropDown(),
                    SizedBox(height: 14.v),
                    _buildInputEmail(context),
                    SizedBox(height: 14.v),
                    _buildInputPassword(context),
                    SizedBox(height: 14.v),
                    CustomElevatedButton(
                      text: "Submit",
                      buttonTextStyle: CustomTextStyles.titleMediumWhiteA700,
                      onPressed: () async {
                        await Signup(context, user);
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

  Future<void> Signup(BuildContext context, User user) async {
    user.email = emailController.text;

    if (!isValidEmail(emailController.text)) {
      showErrorSnackbar(context, "Invalid Email");
      return;
    }
    if (!isValidPassword(passwordController.text)) {
      showErrorSnackbar(context, "Invalid Password");
      return;
    }

    // Fetch data asynchronously and wait for the result
    final response = await network.callSignUp(
        uni, emailController.text, passwordController.text);

    // Check if the request was successful
    if (response.statusCode == 200) {
      print("Response: " + response.body);
      if (response.body.contains("User registered successfully")) {
        showSuccesfulSnackbar(context, "Success");
        Navigator.pushNamed(context, AppRoutes.signUpDetailsScreen);
      }
      if (response.body.contains("Invalid email address")) {
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

  Widget _buildInputUniversityDropDown() {
    return FutureBuilder<List<DropdownMenuEntry<String>>>(
      future: universityListFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // While waiting for the future, show a loading indicator.
        } else if (snapshot.hasError) {
          return Text(
              'Error: ${snapshot.error}'); // If there's an error, display it.
        } else if (snapshot.hasData) {
          // If we have data, build the dropdown menu.
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("University", style: Theme.of(context).textTheme.titleSmall),
              SizedBox(height: 5),
              CustomDropDownMenu(
                controller: universitySelectorController,
                entries: snapshot.data!,
                onSelected: (value) {
                  uni = value;
                  print("Selected value: $value");
                },
              ),
            ],
          );
        }
        return SizedBox.shrink(); // Default empty widget
      },
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

  /// Navigates back to the previous screen.
  onTapArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }
}
