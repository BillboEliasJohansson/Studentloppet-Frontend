
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:studentloppet/theme/custom_text_style.dart';
import 'package:studentloppet/theme/theme_helper.dart';
import 'package:studentloppet/utils/image_constant.dart';
import 'package:studentloppet/utils/size_utils.dart';
import 'package:studentloppet/widgets/app_bar/appbar_leading_image.dart';
import 'package:studentloppet/widgets/app_bar/appbar_title.dart';
import 'package:studentloppet/widgets/app_bar/custom_app_bar.dart';
import 'package:studentloppet/widgets/custom_elevated_button.dart';
import 'package:studentloppet/widgets/metricslist_item_widget.dart';

class RunScreen extends StatefulWidget {
  const RunScreen({super.key});

  @override
  State<RunScreen> createState() => _RunScreenState();
}

class _RunScreenState extends State<RunScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 12.v),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMap(context),
              SizedBox(height: 28.v),
              Padding(
                padding: EdgeInsets.only(left: 12.h),
                child: Text(
                  "Statistics",
                  style: theme.textTheme.titleMedium,
                ),
              ),
              SizedBox(height: 2.v),
              Padding(
                padding: EdgeInsets.only(left: 12.h),
                child: Text(
                  "Distance, Time, Pace",
                  style: CustomTextStyles.bodySmallPrimary,
                ),
              ),
              SizedBox(height: 11.v),
              _buildMetricsList(context)
            ],
          ),
        ),
        bottomNavigationBar: _buildStartRun(context),
      ),
    );
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
        text: "Running Route",
        margin: EdgeInsets.only(left: 8.h),
      ),
      styleType: Style.bgShadow,
    );
  }

  /// Section Widget
  Widget _buildMap(BuildContext context) {
    return Center(
      child: Container(
        height: 386.adaptSize,
        width: 336.adaptSize,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey, 
            width: 2, 
          ),
          borderRadius:
              BorderRadius.circular(10), 
        ),
        child: FlutterMap(
          options: MapOptions(
            initialZoom: 1,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildMetricsList(BuildContext context) {
    return SizedBox(
      height: 76.v,
      child: ListView.separated(
        padding: EdgeInsets.only(left: 12.h),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) {
          return SizedBox(
            width: 8.h,
          );
        },
        itemCount: 3,
        itemBuilder: (context, index) {
          return MetricslistItemWidget();
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildStartRun(BuildContext context) {
    return CustomElevatedButton(
      text: "Start Run",
      margin: EdgeInsets.only(
        left: 12.h,
        right: 12.h,
        bottom: 12.v,
      ),
      buttonTextStyle: CustomTextStyles.titleMediumWhiteA700,
    );
  }

  /// Navigates back to the previous screen.
  onTapArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }
}
