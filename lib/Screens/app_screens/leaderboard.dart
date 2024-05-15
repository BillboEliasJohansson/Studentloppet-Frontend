import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:studentloppet/Constants/image_constant.dart';

import 'package:studentloppet/Screens/app_screens/home_screen.dart';
import 'package:studentloppet/routes/app_routes.dart';
import 'package:studentloppet/theme/theme_helper.dart';
import 'package:studentloppet/utils/size_utils.dart';
import 'package:studentloppet/widgets/ProfileHelpers/custom_app_bar.dart';
import 'package:studentloppet/widgets/app_bar/appbar_leading_image.dart';
import 'package:studentloppet/widgets/custom_helpers/metricslist_item_widget.dart';
import 'package:studentloppet/widgets/custom_nav_bar.dart';

import '../../widgets/ProfileHelpers/appbar_title_profile.dart';

class Leaderboard extends StatefulWidget {
  @override
  LeaderboardState createState() => LeaderboardState();
}

class LeaderboardState extends State<Leaderboard> {
  List<University> universityData = [];
  Map<String, dynamic> activityData = {};
  bool dataFetched = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: _buildAppBar(context),
      body: Container(
        padding: EdgeInsets.only(top: 2.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10.v),
              Text(
                "Universitetstävlingen",
                style: theme.textTheme.headlineSmall!.copyWith(fontSize: 20),
              ),
              SizedBox(height: 10.v),
              _buildLeaderboardList(
                context,
              ),
              SizedBox(height: 10.v),
              Text("Mitt universitet",
                  style: theme.textTheme.headlineSmall!.copyWith(fontSize: 20)),
              _buildLeaderboardList(
                context,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavBar(
        PageIndex: 0,
      ),
    ));
  }

  Widget _buildLeaderboardList(BuildContext context) {
    return SizedBox(
        height: 300.v,
        child: ListView.separated(
          dragStartBehavior: DragStartBehavior.start,
          padding: EdgeInsets.only(left: 12.h, right: 12.h),
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) => SizedBox(width: 8.h),
          itemCount: 3,
          controller: ScrollController(initialScrollOffset: 325),
          itemBuilder: (context, index) {
            List<String> titles = ["Test", "Test2", "Test3"];
            List<String> values = ["Test", "Test2", "Test3"];
            return MetricslistItemWidget(
              upperText: titles[index],
              lowerText: values[index],
            );
          },
        ));
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 30.h,
      leading: AppbarLeadingImage(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.homeScreen);
          },
          imagePath: ImageConstant.imgArrowLeftWhite,
          margin: EdgeInsets.only(
            left: 5.h,
            top: 16.v,
            bottom: 17.v,
          )),
      centerTitle: true,
      title: AppbarTitle(
        text: "Leaderboard",
      ),
      styleType: Style.bgFill,
    );
  }
}
