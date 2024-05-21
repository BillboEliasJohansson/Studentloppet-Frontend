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
import 'package:studentloppet/Constants/image_constant.dart';
import 'package:studentloppet/utils/size_utils.dart';
import 'package:studentloppet/utils/snackbars_util.dart';
import 'package:studentloppet/widgets/custom_helpers/custom_image_view.dart';
import 'package:studentloppet/widgets/custom_helpers/custom_outlined_button.dart';
import 'package:studentloppet/widgets/custom_helpers/custom_text_form_field.dart';

//TODO updatera user klassen

class SignupDetailsScreen extends StatelessWidget {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController date = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
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
          child: SingleChildScrollView(
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
                            height: 415.v,
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
                                          "Skapa konto",
                                          style: theme.textTheme.headlineSmall,
                                        ),
                                        SizedBox(height: 20.v),
                                        _buildInputFirstName(context),
                                        SizedBox(height: 14.v),
                                        _buildInputLastName(context),
                                        SizedBox(height: 14.v),
                                        _buildInputWeight(context),
                                        SizedBox(height: 14.v),
                                        _buildInputDate(context),
                                        SizedBox(height: 14.v),
                                        _buildButton(context, user),
                                        SizedBox(height: 10.v),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  AppRoutes.initialRoute);
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
        text: "Registrera",
        buttonTextStyle: theme.textTheme.labelSmall,
        onPressed: () async {
          await setWeight(context, user);
          await setName(context, user);
        },
      ),
    );
  }

  Widget _buildInputFirstName(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Förnamn",
          style: CustomTextStyles.bodySmallBlack900_1
                      .copyWith(color: appTheme.black900.withOpacity(0.63))),
        SizedBox(height: 4.v),
        CustomTextFormField(
          controller: firstName,
          hintText: "Skriv ditt förnamn här",
          textInputType: TextInputType.visiblePassword,
        )
      ],
    );
  }

  Widget _buildInputLastName(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Efternamn",
          style: CustomTextStyles.bodySmallBlack900_1
                      .copyWith(color: appTheme.black900.withOpacity(0.63))),
        SizedBox(height: 4.v),
        CustomTextFormField(
          controller: lastName,
          hintText: "Skriv ditt efternamn här",
          textInputType: TextInputType.visiblePassword,
        )
      ],
    );
  }

  Widget _buildInputDate(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Födelseår",
          style: CustomTextStyles.bodySmallBlack900_1
                      .copyWith(color: appTheme.black900.withOpacity(0.63))),
        Text(
          "Krävs för autentisering*",
          style: CustomTextStyles.bodySmallBlack900_1
                      .copyWith(color: appTheme.black900)),
        SizedBox(height: 4.v),
        CustomTextFormField(
          controller: date,
          hintText: "Skriv ditt födelsedatum här",
          textInputType: TextInputType.numberWithOptions(decimal: true),
        ),
      ],
    );
  }

  Widget _buildInputWeight(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Vikt (frivilligt)",
          style: CustomTextStyles.bodySmallBlack900_1
                      .copyWith(color: appTheme.black900.withOpacity(0.63))),
        Text(
          "Krävs för kaloriberäkning*",
          style: theme.textTheme.bodySmall!
              .copyWith(color: Colors.black),
        ),
        SizedBox(height: 4.v),
        CustomTextFormField(
          controller: weight,
          hintText: "Skriv din vikt här",
          textInputType: TextInputType.numberWithOptions(decimal: true),
        )
      ],
    );
  }

  Future<void> setWeight(BuildContext context, user) async {
    final response = await network.setWeight(user.email, weight.text);
    if (response.statusCode == 200) {
      // Visa en framgångsrik snackbar om vikten uppdaterades korrekta
      print(user.weight);
    } else {
      print(response.body);
      // Visa ett felmeddelande om det uppstod problem med att uppdatera vikten
    }
  }

  Future<void> setName(BuildContext context, user) async {
    if (user.email.contains("hej")) {
      Navigator.pushNamed(context, AppRoutes.signUpSuccess);
    }

    if (firstName.text.isEmpty) {
      return;
    }

    if (lastName.text.isEmpty) {
      return;
    }

    final response =
        await network.updateName(user.email, firstName.text, lastName.text);

    if (response.statusCode == 200) {
      if (response.body.contains("true")) {
        Navigator.pushNamed(context, AppRoutes.signUpSuccess);
      } else {
      }
    } else {
    }
  }
}
