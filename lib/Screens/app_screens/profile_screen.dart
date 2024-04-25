import 'package:flutter/material.dart';
import 'package:studentloppet/theme/theme_helper.dart';
import 'package:studentloppet/utils/image_constant.dart';
import 'package:studentloppet/utils/size_utils.dart';
import 'package:studentloppet/widgets/custom_image_view.dart';
import '../../widgets/custom_icon_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 1.v),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 4.h),
                  child: Text(
                    "Logga ut",
                    style: theme.textTheme.labelSmall,
                  ),
                ),
              ),
              SizedBox(height: 7.v),
              Text(
                "StudentLoppet",
                style: theme.textTheme.titleLarge,
              ),
              Text(
                "Min profil",
                style: theme.textTheme.titleSmall,
              ),
              SizedBox(height: 54.v),
              Padding(
                padding: EdgeInsets.only(right: 3.h),
                child: _buildRowTitleTwo(
                  context,
                  titleText: "Namn",
                  subtitleText: "Petter Pettersson",
                ),
              ),
              SizedBox(height: 11.v),
              Divider(),
              SizedBox(height: 6.v),
              Padding(
                padding: EdgeInsets.only(left: 5.h),
                child: _buildRowTitleTwo(
                  context,
                  titleText: "Namn på Universitet",
                  subtitleText: "Stockholms Universitet",
                ),
              ),
              SizedBox(height: 6.v),
              Divider(),
              SizedBox(height: 24.v),
              Padding(
                padding: EdgeInsets.only(left: 5.h),
                child: Column(
                  children: [
                    _buildRowView(context),
                    SizedBox(height: 11.v),
                    Divider(),
                    SizedBox(height: 19.v),
                    _buildRowViewOne(context),
                    SizedBox(height: 10.v),
                    Divider(),
                    SizedBox(height: 20.v),
                    _buildRowViewTwo(context),
                    SizedBox(height: 11.v),
                    Divider(),
                    SizedBox(height: 13.v),
                    _buildRowTitleTwo(
                      context,
                      titleText: "Mitt Universitets längsta sträcka",
                      subtitleText: "1 000 km",
                    ),
                    SizedBox(height: 2.v),
                    Divider(),
                    SizedBox(height: 17.v),
                    _buildRowViewThree(context),
                    SizedBox(height: 6.v),
                    Divider(),
                    SizedBox(height: 17.v),
                    _buildRowViewFour(context),
                    SizedBox(height: 6.v),
                    Divider()
                  ],
                ),
              ),
              SizedBox(height: 5.v)
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildRowView(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 32.adaptSize,
          width: 32.adaptSize,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 32.adaptSize,
                  width: 32.adaptSize,
                  decoration: BoxDecoration(
                    color: appTheme.black900.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(
                      16.h,
                    ),
                  ),
                ),
              ),
              CustomImageView(
                imagePath: ImageConstant.imgTelevision,
                height: 32.adaptSize,
                width: 32.adaptSize,
                alignment: Alignment.center,
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 8.h,
            top: 8.v,
            bottom: 6.v,
          ),
          child: Text(
            "Min lägsta sträcka",
            style: theme.textTheme.bodyMedium,
          ),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.only(
            top: 7.v,
            bottom: 8.v,
          ),
          child: Text(
            "10 km",
            style: theme.textTheme.bodyMedium,
          ),
        )
      ],
    );
  }

  /// Section Widget
  Widget _buildRowViewOne(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 32.adaptSize,
          width: 32.adaptSize,
          decoration: BoxDecoration(
            color: appTheme.black900.withOpacity(0.05),
            borderRadius: BorderRadius.circular(
              16.h,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 8.h,
            top: 7.v,
            bottom: 7.v,
          ),
          child: Text(
            "Mitt snabbaste 5km",
            style: theme.textTheme.bodyMedium,
          ),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 7.v),
          child: Text(
            "20 min",
            style: theme.textTheme.bodyMedium,
          ),
        )
      ],
    );
  }

  /// Section Widget
  Widget _buildRowViewTwo(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 32.adaptSize,
          width: 32.adaptSize,
          decoration: BoxDecoration(
            color: appTheme.black900.withOpacity(0.05),
            borderRadius: BorderRadius.circular(
              16.h,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 8.h,
            top: 7.v,
            bottom: 7.v,
          ),
          child: Text(
            "Mitt snabbaste 10km",
            style: theme.textTheme.bodyMedium,
          ),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 7.v),
          child: Text(
            "60 min",
            style: theme.textTheme.bodyMedium,
          ),
        )
      ],
    );
  }

  /// Section Widget
  Widget _buildRowViewThree(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 32.adaptSize,
          width: 32.adaptSize,
          margin: EdgeInsets.only(
            top: 2.v,
            bottom: 4.v,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 32.adaptSize,
                  width: 32.adaptSize,
                  decoration: BoxDecoration(
                    color: appTheme.black900.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(
                      16.h,
                    ),
                  ),
                ),
              ),
              CustomIconButton(
                height: 32.adaptSize,
                width: 32.adaptSize,
                padding: EdgeInsets.all(3.h),
                alignment: Alignment.center,
                child: CustomImageView(
                  imagePath: ImageConstant.imgFrame,
                ),
              )
            ],
          ),
        ),
        Container(
          width: 170.h,
          margin: EdgeInsets.only(left: 8.h),
          child: Text(
            "Mitt Universitets snabbaste sträcka",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium!.copyWith(
              height: 1.43,
            ),
          ),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 11.v),
          child: Text(
            "5 km (på 15 min)",
            style: theme.textTheme.bodyMedium,
          ),
        )
      ],
    );
  }

  /// Section Widget
  Widget _buildRowViewFour(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 32.adaptSize,
          width: 32.adaptSize,
          margin: EdgeInsets.only(
            top: 3.v,
            bottom: 4.v,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 32.adaptSize,
                  width: 32.adaptSize,
                  decoration: BoxDecoration(
                    color: appTheme.black900.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(
                      16.h,
                    ),
                  ),
                ),
              ),
              CustomIconButton(
                height: 32.adaptSize,
                width: 32.adaptSize,
                padding: EdgeInsets.all(3.h),
                alignment: Alignment.center,
                child: CustomImageView(
                  imagePath: ImageConstant.imgFrame,
                ),
              )
            ],
          ),
        ),
        Container(
          width: 132.h,
          margin: EdgeInsets.only(left: 8.h),
          child: Text(
            "Mitt Universitets flest registrerade",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium!.copyWith(
              height: 1.43,
            ),
          ),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 11.v),
          child: Text(
            "200 personer",
            style: theme.textTheme.bodyMedium,
          ),
        )
      ],
    );
  }

  /// Common widget
  Widget _buildRowTitleTwo(
    BuildContext context, {
    required String titleText,
    required String subtitleText,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 3.v,
            bottom: 4.v,
          ),
          child: CustomIconButton(
            height: 32.adaptSize,
            width: 32.adaptSize,
            padding: EdgeInsets.all(3.h),
            child: CustomImageView(
              imagePath: ImageConstant.imgFrame,
            ),
          ),
        ),
        Container(
          width: 66.h,
          margin: EdgeInsets.only(left: 8.h),
          child: Text(
            titleText,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium!.copyWith(
              color: appTheme.black900,
              height: 1.43,
            ),
          ),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.only(
            top: 10.v,
            bottom: 12.v,
          ),
          child: Text(
            subtitleText,
            style: theme.textTheme.bodyMedium!.copyWith(
              color: appTheme.black900,
            ),
          ),
        )
      ],
    );
  }
}
