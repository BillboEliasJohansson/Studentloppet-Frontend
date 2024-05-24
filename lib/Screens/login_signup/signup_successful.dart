import 'package:flutter/material.dart';
import 'package:studentloppet/routes/app_routes.dart';
import 'package:studentloppet/theme/app_decoration.dart';
import 'package:studentloppet/theme/custom_text_style.dart';
import 'package:studentloppet/theme/theme_helper.dart';
import 'package:studentloppet/Constants/image_constant.dart';
import 'package:studentloppet/utils/size_utils.dart';
import 'package:studentloppet/widgets/custom_helpers/custom_image_view.dart';
import 'package:studentloppet/widgets/custom_helpers/custom_outlined_button.dart';

class SignUpSuccess extends StatelessWidget {
  const SignUpSuccess({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        width: SizeUtils.width,
        height: SizeUtils.height,
        decoration: BoxDecoration(color: appTheme.purple200),
        child: SizedBox(
            width: SizeUtils.width,
            child: Column(
              children: [
                SizedBox(
                  height: 15.h,
                ),
                Padding(
                    padding: const EdgeInsets.all(10.0), child: _buildTopBar()),
                SizedBox(
                  height: 30.h,
                ),
                Container(
                    height: 375,
                    width: 375,
                    decoration: AppDecoration.fillPurple300.copyWith(
                      borderRadius: BorderRadiusStyle.circleBorder,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: CustomImageView(
                        imagePath: ImageConstant.imgRunner,
                        fit: BoxFit.fitWidth,
                      ),
                    )),
                SizedBox(
                  height: 30.h,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildButton(context),
                )
              ],
            )),
      ),
    ));
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

  Widget _buildButton(BuildContext context) {
    return Container(
      decoration: AppDecoration.outlinePurple.copyWith(
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
                MaterialStateColor.resolveWith((states) => appTheme.purple300)),
        text: "Logga in!",
        buttonTextStyle: theme.textTheme.labelSmall,
        onPressed: () async {
          Navigator.pushNamed(context, AppRoutes.initialRoute);
        },
      ),
    );
  }
}
