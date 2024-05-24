import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
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
import 'package:url_launcher/url_launcher.dart';
import 'package:studentloppet/Screens/app_screens/run_screens/run_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<University>? universityData;
  Map<String, dynamic> activityData = {};
  Map<String, dynamic> weeklyActivityData = {};
  bool dataFetched = false;
  final Uri _url =
      Uri.parse('https://midnattsloppet.com/anmalan-till-midnattsloppet/');
  final PageController _pageController = PageController();

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

  void fetchPersonalWeeklyData(user) async {
    try {
      Map<String, dynamic> data = await network.getWeeklyActivity(user.email);
      setState(() {
        weeklyActivityData = data;
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
      fetchPersonalWeeklyData(user);
      dataFetched = true;
    }
    return SafeArea(
      child: universityData == null
          ? Text("")
          : Scaffold(
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
                        children: <Widget>[
                          _buildPageHeader(),
                          SizedBox(height: 5.h),
                          _buildButton(
                              "Registering för Midnattsloppet",
                              () => _launchUrl(),
                              MaterialStateColor.resolveWith(
                                  (states) => appTheme.deepPurple500),
                              AppDecoration.outlineDeepPurple.copyWith(
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder10)),
                          SizedBox(height: 5.h),
                          _buildButton(
                              "Påbörja en ny löprunda",
                              () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RunScreen())),
                              MaterialStateColor.resolveWith(
                                  (states) => appTheme.orange),
                              AppDecoration.outlineOrange.copyWith(
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder10)),
                          SizedBox(height: 5.h),
                          Column(
                            children: [
                              Container(
                                height: 305, // Adjust height as necessary
                                child: PageView(
                                  controller: _pageController,
                                  children: [
                                    _buildPersonalStatisticsCard(
                                        context, user, "Min Löpstatistik"),
                                    _buildWeeklyPersonalStatisticsCard(context,
                                        user, "Min Löpstatistik denna vecka"),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              SmoothPageIndicator(
                                controller: _pageController,
                                count: 2,
                                effect: WormEffect(
                                  dotHeight: 10,
                                  dotWidth: 10,
                                  type: WormType.thin,
                                  strokeWidth: 5,
                                ),
                              ),
                            ],
                          ),
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
      child: IntrinsicHeight(
        child: Container(
          padding: EdgeInsets.all(7.h),
          decoration: AppDecoration.outlinePurple.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder10,
          ),
          child: Stack(
            children: [
              Align(
                child: Container(
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
      ),
    );
  }

  Widget _buildWeeklyPersonalStatisticsCard(
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
      child: IntrinsicHeight(
        child: Container(
          padding: EdgeInsets.all(7.h),
          decoration: AppDecoration.outlinePurple.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder10,
          ),
          child: Stack(
            children: [
              Align(
                child: Container(
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
              _buildWeeklyInfoCard(context, user),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeeklyInfoCard(BuildContext context, User user) {
    return Column(
      children: [
        SizedBox(height: 40),
        _buildRowView(
          context,
          user,
          "Tid",
          weeklyActivityData['totalDuration'] == null
              ? "..."
              : weeklyActivityData['totalDuration'].toStringAsFixed(2) + " min",
          ImageConstant.imgTimer,
        ),
        Divider(
          indent: 20.h,
          color: Colors.white.withOpacity(0.80),
          endIndent: 20,
        ),
        _buildRowView(
          context,
          user,
          "Avstånd",
          weeklyActivityData['totalDistance'] == null
              ? "..."
              : weeklyActivityData['totalDistance'].toStringAsFixed(2) + " km",
          ImageConstant.imgFeet,
        ),
        Divider(
          indent: 20.h,
          color: Colors.white.withOpacity(0.80),
          endIndent: 20,
        ),
        _buildRowView(
          context,
          user,
          "Genomsnittlig Hastighet",
          weeklyActivityData['averageSpeed'] == null
              ? "..."
              : weeklyActivityData['averageSpeed'].toStringAsFixed(2) + " km/h",
          ImageConstant.imgRun,
        ),
        Divider(
          indent: 20.h,
          color: Colors.white.withOpacity(0.80),
          endIndent: 20,
        ),
        _buildRowView(
          context,
          user,
          "Kalorier brända",
          weeklyActivityData['caloriesBurned'] == null
              ? "..."
              : weeklyActivityData['caloriesBurned'].toStringAsFixed(2) +
                  " kcal",
          ImageConstant.imgFire,
        ),
        Divider(
          indent: 20.h,
          color: Colors.white.withOpacity(0.80),
          endIndent: 20,
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildInfoCard(BuildContext context, User user) {
    return Column(
      children: [
        SizedBox(height: 40),
        _buildRowView(
          context,
          user,
          "Tid",
          activityData['totalDuration'] == null
              ? "..."
              : activityData['totalDuration'].toStringAsFixed(2) + " min",
          ImageConstant.imgTimer,
        ),
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
              : activityData['totalDistance'].toStringAsFixed(2) + " km",
          ImageConstant.imgFeet,
        ),
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
              : activityData['averageSpeed'].toStringAsFixed(2) + " km/h",
          ImageConstant.imgRun,
        ),
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
              : activityData['caloriesBurned'].toStringAsFixed(2) + " kcal",
          ImageConstant.imgFire,
        ),
        Divider(
          indent: 20.h,
          color: Colors.white.withOpacity(0.80),
          endIndent: 20,
        ),
        SizedBox(height: 20),
      ],
    );
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
        child: AutoSizeText(
          header,
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                fontSize: 26,
              ),
          maxLines: 1,
          minFontSize: 12,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 30.h,
      centerTitle: true,
      title: AppbarTitle(
        text: "Studentloppet",
      ),
      styleType: Style.bgFill,
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
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
        buttonTextStyle: theme.textTheme.displayMedium!.copyWith(fontSize: 30),
        onPressed: f,
      ),
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
        height: 300.v,
        width: 360.h,
        padding: EdgeInsets.all(7.h),
        decoration: AppDecoration.outlinePurple.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder10,
        ),
        child: Stack(
          children: [
            Align(
              child: Container(
                height: 300.v,
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
            _buildLeaderboardList(context)
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
            child: Text(
          "73 dagar kvar",
          style: theme.textTheme.displayMedium!.copyWith(fontSize: 45),
        )),
      ),
    );
  }

  Widget _buildLeaderboardList(BuildContext context) {
    List<String> titles = [
      universityData![0].university!.substring(0, 3),
      universityData![1].university!.substring(0, 3),
      universityData![2].university!.substring(0, 3),
      universityData![3].university!.substring(0, 3),
    ];

    List<BarChartGroupData> data = [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
              toY: universityData![0].score!.toDouble(),
              color: Colors.blue,
              width: 40,
              borderRadius: BorderRadius.zero)
        ],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
              toY: universityData![1].score!.toDouble(),
              color: Colors.orange,
              width: 40,
              borderRadius: BorderRadius.zero)
        ],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(
              toY: universityData![2].score!.toDouble(),
              color: Colors.deepPurple,
              width: 40,
              borderRadius: BorderRadius.zero)
        ],
      ),
      BarChartGroupData(
        x: 3,
        barRods: [
          BarChartRodData(
              toY: universityData![3].score!.toDouble(),
              color: Colors.red,
              width: 40,
              borderRadius: BorderRadius.zero)
        ],
      ),
    ];

    return BarChart(BarChartData(
      alignment: BarChartAlignment.spaceAround,
      maxY: universityData![0].score!.toDouble() + 1000000,
      barTouchData: BarTouchData(enabled: false),
      barGroups: data,
      borderData: FlBorderData(show: false),
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
            sideTitles: SideTitles(
          reservedSize: 35,
          showTitles: true,
          getTitlesWidget: (value, meta) {
            const style = TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 20,
            );
            switch (value.toInt()) {
              case 0:
                return SideTitleWidget(
                    child: Text(titles[0], style: style),
                    axisSide: AxisSide.bottom);
              case 1:
                return SideTitleWidget(
                    child: Text(titles[1], style: style),
                    axisSide: AxisSide.bottom);
              case 2:
                return SideTitleWidget(
                    child: Text(titles[2], style: style),
                    axisSide: AxisSide.bottom);
              case 3:
                return SideTitleWidget(
                    child: Text(titles[3], style: style),
                    axisSide: AxisSide.bottom);
              default:
                return SideTitleWidget(
                    child: Text("error", style: style),
                    axisSide: AxisSide.bottom);
            }
          },
        )),
      ),
    ));
  }
}

class University {
  String? university;
  int? score;
  double? distance;
  int? users;

  University({this.university, this.score, this.distance, this.users});

  factory University.scoreFromJson(Map<String, dynamic> json) {
    return University(
      university: json['universityDisplayName'] ?? '',
      score: json['metric'] ?? 0,
    );
  }

  factory University.distanceFromJson(Map<String, dynamic> json) {
    return University(
      university: json['universityDisplayName'] ?? '',
      distance: json['metric'] ?? 0,
    );
  }

  factory University.usercountFromJson(Map<String, dynamic> json) {
    return University(
      university: json['universityDisplayName'] ?? '',
      users: json['metric'] ?? 0,
    );
  }
}
