// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentloppet/User/user.dart';
import 'package:studentloppet/networking/network.dart';
import 'package:studentloppet/routes/app_routes.dart';
import 'package:studentloppet/theme/app_decoration.dart';
import 'package:studentloppet/theme/custom_text_style.dart';
import 'package:studentloppet/theme/theme_helper.dart';
import 'package:studentloppet/utils/image_constant.dart';
import 'package:studentloppet/utils/size_utils.dart';
import 'package:studentloppet/utils/validation_functions.dart';
import 'package:studentloppet/utils/snackbars_util.dart';
import 'package:studentloppet/widgets/custom_dropdownmenu.dart';
import 'package:studentloppet/widgets/custom_image_view.dart';
import 'package:studentloppet/widgets/custom_outlined_button.dart';
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
        body: Container(
          width: SizeUtils.width,
          height: SizeUtils.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                ImageConstant.imgLoginBckg,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: SizedBox(
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
                    child: Column(children: [
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
                              height: 400.v,
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
                                        color: theme
                                            .colorScheme.onPrimaryContainer,
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
                                            "Skapa konto",
                                            style:
                                                theme.textTheme.headlineSmall,
                                          ),
                                          SizedBox(height: 20.v),
                                          _buildInputUniversityDropDown(),
                                          SizedBox(height: 14.v),
                                          _buildInputEmail(context),
                                          SizedBox(height: 14.v),
                                          _buildInputPassword(context),
                                          SizedBox(height: 14.v),
                                          SizedBox(height: 30.v),
                                          _buildButton(user),
                                          SizedBox(height: 8.v),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: GestureDetector(
                                              onTap: () {
                                                onTapArrowleftone(context);
                                              },
                                              child: Text(
                                                "Tillbaka till inloggningssidan",
                                                style: CustomTextStyles
                                                    .bodySmallBlack900
                                                    .copyWith(
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                              ),
                                            ),
                                          )
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
        text: "Registrera",
        buttonTextStyle: theme.textTheme.labelSmall,
        onPressed: () async {
          await Signup(context, user);
        },
      ),
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
              Text("University",
                  style: CustomTextStyles.bodySmallBlack900_1
                      .copyWith(color: appTheme.black900.withOpacity(0.63))),
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
          controller: emailController,
          hintText: "Skriv in ditt universitets email",
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
