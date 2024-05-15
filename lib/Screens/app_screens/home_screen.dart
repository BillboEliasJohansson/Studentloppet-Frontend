import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentloppet/User/user.dart';
import 'package:studentloppet/networking/network.dart';
import 'package:studentloppet/theme/app_decoration.dart';
import 'package:studentloppet/theme/theme_helper.dart';
import 'package:studentloppet/Constants/image_constant.dart';
import 'package:studentloppet/utils/size_utils.dart';
import 'package:studentloppet/widgets/ProfileHelpers/appbar_title_profile.dart';
import 'package:studentloppet/widgets/ProfileHelpers/custom_app_bar.dart';
import 'package:studentloppet/widgets/custom_helpers/custom_outlined_button.dart';
import 'package:studentloppet/widgets/custom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<University> universityData = [];
  Map<String, dynamic> activityData = {};
  bool dataFetched = false;

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

  void fetchPersonalData(user) async {
    try {
      Map<String, dynamic> data = await network.getTotalActivity(user.email);
      setState(() {
        activityData = data;
      });
      return;
    } catch (e) {
      print("Error fetching leaderboard: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!dataFetched) {
      User user = Provider.of<User>(context);
      fetchPersonalData(user);
      dataFetched = true;
    }
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: SizeUtils.width,
          height: SizeUtils.height,
          padding: EdgeInsets.only(
            top: 5.v,
            left: 10,
            right: 10,
            bottom: 1,
          ),
          child: SingleChildScrollView(
            child: Consumer<User>(
              builder: (context, user, _) {
                return Column(
                  children: [
                    _buildPageHeader(),
                    SizedBox(height: 5.h),
                    _buildButton(
                        "Registering för Midnattsloppet",
                        () => null,
                        MaterialStateColor.resolveWith(
                            (states) => appTheme.deepPurple500),
                        AppDecoration.outlineDeepPurple.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder10)),
                    SizedBox(height: 5.h),
                    _buildButton(
                        "Påbörja en ny löprunda",
                        () => null,
                        MaterialStateColor.resolveWith(
                            (states) => appTheme.orange),
                        AppDecoration.outlineOrange.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder10)),
                    SizedBox(height: 5.h),
                    _buildPersonalStatisticsCard(
                        context, user, "Min Löpstatistik"),
                    SizedBox(height: 5.h),
                    _buildCardLeaderboard(
                        context, user, "Universitetstävlingen"),
                  ],
                );
              },
            ),
          ),
        ),
        bottomNavigationBar: CustomNavBar(
          PageIndex: 1,
        ),
      ),
    );
  }

  Widget _buildPersonalStatisticsCard(
      BuildContext context, User user, String header) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: appTheme.deepPurple500,
          width: 2.h,
        ),
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Container(
        height: 210.v,
        width: 360.h,
        padding: EdgeInsets.all(7.h),
        decoration: AppDecoration.outlinePurple.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder10,
        ),
        child: Stack(
          children: [
            Align(
              child: Container(
                height: 220.v,
                width: 330.h,
                decoration: BoxDecoration(
                  color: appTheme.deepPurple500,
                  borderRadius: BorderRadius.circular(
                    5.h,
                  ),
                ),
              ),
            ),
            _buildCardHeader(context, header),
            _buildInfoCard(context, user),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    context,
    user,
  ) {
    return Column(children: [
      SizedBox(height: 40),
      _buildRowView(
        context,
        user,
        "Tid",
        activityData['totalDuration'] == null
            ? "..."
            : activityData['totalDuration'].toString(),
        ImageConstant.imgTimer,
      ),
      SizedBox(height: 0.v),
      Divider(
        indent: 20.h,
        color: Colors.white.withOpacity(0.80),
        endIndent: 20,
      ),
      _buildRowView(
        context,
        user,
        "Avstånd",
        activityData['totalDistance'] == null
            ? "..."
            : activityData['totalDistance'].toStringAsFixed(2),
        ImageConstant.imgFeet,
      ),
      SizedBox(height: 0.v),
      Divider(
        indent: 20.h,
        color: Colors.white.withOpacity(0.80),
        endIndent: 20,
      ),
      _buildRowView(
        context,
        user,
        "Genomsnittlig Hastighet",
        activityData['averageSpeed'] == null
            ? "..."
            : activityData['averageSpeed'].toStringAsFixed(2),
        ImageConstant.imgRun,
      ),
      SizedBox(height: 0.v),
      Divider(
        indent: 20.h,
        color: Colors.white.withOpacity(0.80),
        endIndent: 20,
      ),
      _buildRowView(
        context,
        user,
        "Kalorier brända",
        activityData['caloriesBurned'] == null
            ? "..."
            : activityData['caloriesBurned'].toString(),
        ImageConstant.imgFire,
      ),
      SizedBox(height: 0.v),
      Divider(
        indent: 20.h,
        color: Colors.white.withOpacity(0.80),
        endIndent: 20,
      ),
    ]);
  }

  Widget _buildRowView(BuildContext context, User user, String title,
      String detail, String imagePath) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 20, bottom: 3, right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 30.adaptSize,
            width: 30.adaptSize,
            decoration: BoxDecoration(
                color: appTheme.black900.withOpacity(0.00),
                borderRadius: BorderRadius.circular(0.h),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.contain,
                )),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 8.h,
              top: 7.v,
              bottom: 7.v,
            ),
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 7.v, horizontal: 10),
            child: Text(
              detail,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.white,
                  ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCardHeader(BuildContext context, String header) {
    return Padding(
      padding: EdgeInsets.only(
        left: 17.h,
        top: 8.v,
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          header,
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                fontSize: 26,
              ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 30.h,
      centerTitle: true,
      title: AppbarTitle(
        text: "Hemskärm",
      ),
      styleType: Style.bgFill,
    );
  }

  Widget _buildButton(String buttonText, Function()? f,
      MaterialStateProperty<Color> color, Decoration outline) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: outline,
      child: CustomOutlinedButton(
          margin: EdgeInsets.all(5),
          buttonStyle: ButtonStyle(
            side: MaterialStateBorderSide.resolveWith(
                (states) => BorderSide(style: BorderStyle.none)),
            shape: MaterialStateProperty.resolveWith<OutlinedBorder?>(
              (states) => RoundedRectangleBorder(
                  borderRadius: BorderRadiusStyle.roundedBorder6),
            ),
            backgroundColor: color,
          ),
          text: buttonText,
          buttonTextStyle:
              theme.textTheme.displayMedium!.copyWith(fontSize: 30),
          onPressed: f),
    );
  }

  Widget _buildCardLeaderboard(BuildContext context, User user, String header) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: appTheme.deepPurple500,
          width: 2.h,
        ),
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Container(
        height: 210.v,
        width: 360.h,
        padding: EdgeInsets.all(7.h),
        decoration: AppDecoration.outlinePurple.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder10,
        ),
        child: Stack(
          children: [
            Align(
              child: Container(
                height: 220.v,
                width: 330.h,
                decoration: BoxDecoration(
                  color: appTheme.deepPurple500,
                  borderRadius: BorderRadius.circular(
                    5.h,
                  ),
                ),
              ),
            ),
            _buildCardHeader(context, header),
          ],
        ),
      ),
    );
  }

  Widget _buildPageHeader() {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        width: 360.h,
        height: 70.v,
        decoration: BoxDecoration(
            borderRadius: BorderRadiusStyle.roundedBorder6,
            image: DecorationImage(
                image: Image.asset(ImageConstant.imgHomeScreenHeaderGif).image,
                fit: BoxFit.fill)),
        child: Center(
          child: Text("73 dagar kvar",
            style: theme.textTheme.displayMedium!.copyWith(fontSize: 45),         
          )
        ),
      ),
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
