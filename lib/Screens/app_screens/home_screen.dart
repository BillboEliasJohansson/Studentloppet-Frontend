import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentloppet/User/user.dart';
import 'package:studentloppet/networking/network.dart';
import 'package:studentloppet/routes/app_routes.dart';
import 'package:studentloppet/theme/custom_text_style.dart';
import 'package:studentloppet/theme/theme_helper.dart';
import 'package:studentloppet/utils/image_constant.dart';
import 'package:studentloppet/utils/size_utils.dart';
import 'package:studentloppet/widgets/app_bar/appbar_title.dart';
import 'package:studentloppet/widgets/app_bar/custom_app_bar.dart';
import 'package:studentloppet/widgets/custom_icon_button.dart';
import 'package:studentloppet/widgets/custom_image_view.dart';
import 'package:studentloppet/widgets/custom_outlined_button.dart';
import 'package:studentloppet/widgets/metricslist_item_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<University> universityData = [];

  @override
  void initState() {
    fetchLeaderboardData();
    super.initState();
  }

  void fetchLeaderboardData() async {
    try {
      List<University> data = await network.getLeaderboard();
      setState(() {
        universityData = data;
      });
    } catch (e) {
      print("Error fetching leaderboard: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      appBar: _buildAppBar(context, user),
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.h),
                child: Column(
                  children: [
                    SizedBox(height: 16.v),
                    _buildSectionTitle(context),
                    SizedBox(height: 11.v),
                    _buildMetricList(context, user),
                    SizedBox(height: 29.v),
                    _buildSectionTitle1(context),
                    SizedBox(height: 23.v),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.h),
                      child: universityData.isEmpty
                          ? CircularProgressIndicator()
                          : _buildRowTitle(
                              context,
                              titleText: universityData[0].university,
                              pointsCounterText:
                                  universityData[0].score.toString(),
                            ),
                    ),
                    SizedBox(height: 12.v),
                    Divider(
                      indent: 12.h,
                      endIndent: 12.h,
                    ),
                    SizedBox(height: 11.v),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.h),
                      child: universityData.isEmpty
                          ? CircularProgressIndicator()
                          : _buildRowTitle(
                              context,
                              titleText: universityData[1].university,
                              pointsCounterText:
                                  universityData[1].score.toString(),
                            ),
                    ),
                    SizedBox(height: 12.v),
                    Divider(
                      indent: 12.h,
                      endIndent: 12.h,
                    ),
                    SizedBox(height: 11.v),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.h),
                      child: universityData.isEmpty
                          ? CircularProgressIndicator()
                          : _buildRowTitle(
                              context,
                              titleText: universityData[2].university,
                              pointsCounterText:
                                  universityData[2].score.toString(),
                            ),
                    ),
                    SizedBox(height: 12.v),
                    Divider(
                      indent: 12.h,
                      endIndent: 12.h,
                    ),
                    SizedBox(height: 11.v),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: _buildFloatingaction(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, User user) {
    return CustomAppBar(
      title: AppbarTitle(
        text: "Welcome " + user.firstName,
        margin: EdgeInsets.only(left: 10.h, top: 20.h),
      ),
      styleType: Style.bgShadow,
    );
  }

  /// Section Widget
  Widget _buildSectionTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Personal Statistics",
              style: theme.textTheme.titleMedium,
            ),
            SizedBox(height: 3.v),
            Text(
              "University Runner",
              style: CustomTextStyles.bodySmallPrimary,
            )
          ],
        ),
        CustomOutlinedButton(
          height: 22.v,
          width: 92.h,
          text: "View Profile",
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.profileScreen);
          },
          margin: EdgeInsets.only(
            top: 8.v,
            bottom: 9.v,
          ),
          rightIcon: Container(
            margin: EdgeInsets.only(left: 2.h),
            child: CustomImageView(
              imagePath: ImageConstant.imgArrowright,
              height: 12.adaptSize,
              width: 12.adaptSize,
            ),
          ),
          buttonTextStyle: theme.textTheme.bodySmall!,
        )
      ],
    );
  }

  Widget _buildMetricList(BuildContext context, User user) {
    return SizedBox(
      height: 76.v,
      child: ListView.separated(
        padding: EdgeInsets.only(left: 12.h),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => SizedBox(width: 8.h),
        itemCount: 3,
        itemBuilder: (context, index) {
          List<String> titles = ["Points", "Title 2", "Title 3"];
          List<String> subtitles = [
            user.score.toString(),
            "Subtitle 2",
            "Subtitle 3"
          ];
          return MetricslistItemWidget(
            upperText: titles[index],
            lowerText: subtitles[index],
          );
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildSectionTitle1(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 1.v),
          child: Text(
            "Top three Universitys",
            style: theme.textTheme.titleMedium,
          ),
        ),
        CustomOutlinedButton(
          height: 22.v,
          width: 69.h,
          text: "View All",
          rightIcon: Container(
            margin: EdgeInsets.only(left: 2.h),
            child: CustomImageView(
              imagePath: ImageConstant.imgArrowright,
              height: 12.adaptSize,
              width: 12.adaptSize,
            ),
          ),
          buttonTextStyle: theme.textTheme.bodySmall!,
          onPressed: () {
            network.getLeaderboard();
          },
        )
      ],
    );
  }

  /// Section Widget
  Widget _buildFloatingaction(BuildContext context) {
    return FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        backgroundColor: Colors.grey,
        autofocus: true,
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.runScreen);
        });
  }

  /// Common widget
  Widget _buildRowTitle(
    BuildContext context, {
    required String titleText,
    required String pointsCounterText,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomIconButton(
            height: 32.adaptSize,
            width: 32.adaptSize,
            padding: EdgeInsets.all(3.h),
            child: Icon(Icons.school_sharp)),
        Padding(
          padding: EdgeInsets.only(
            left: 8.h,
            top: 8.v,
            bottom: 6.v,
          ),
          child: Text(
            titleText,
            style: CustomTextStyles.bodyMediumPrimary.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.only(
            top: 8.v,
            bottom: 6.v,
          ),
          child: Text(
            pointsCounterText,
            style: theme.textTheme.titleSmall!.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        )
      ],
    );
  }
}

class University {
  final String university;
  final int score;

  University({required this.university, required this.score});

  factory University.fromJson(Map<String, dynamic> json) {
    return University(
      university: json['universityDisplayName'] ?? '',
      score: json['score'] ?? 0,
    );
  }
}
