import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentloppet/Constants/image_constant.dart';
import 'package:studentloppet/User/user.dart';
import 'package:studentloppet/networking/network.dart';

import 'package:studentloppet/Screens/app_screens/home_screen.dart';
import 'package:studentloppet/routes/app_routes.dart';
import 'package:studentloppet/theme/theme_helper.dart';
import 'package:studentloppet/utils/size_utils.dart';
import 'package:studentloppet/widgets/ProfileHelpers/custom_app_bar.dart';
import 'package:studentloppet/widgets/app_bar/appbar_leading_image.dart';
import 'package:studentloppet/widgets/custom_helpers/leaderboard_item_widget.dart';
import 'package:studentloppet/widgets/custom_helpers/leaderboard_uni_list.dart';
import 'package:studentloppet/widgets/custom_nav_bar.dart';

import '../../widgets/ProfileHelpers/appbar_title_profile.dart';

class Leaderboard extends StatefulWidget {
  @override
  LeaderboardState createState() => LeaderboardState();
}

class LeaderboardState extends State<Leaderboard> {
  List<University>? universityData;
  List<University>? universityDataDistance;
  List<University>? universityDataUsers;
  Map<String, int>? userData;
  Map<String, double>? userDataDistance;
  Map<String, double>? userDataSpeed;

  String? uni;

  Map<String, dynamic> activityData = {};

  bool dataFetched = false;

  @override
  void initState() {
    fetchLeaderboardData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!dataFetched) {
      final user = Provider.of<User>(context);
      fetchUniLeaderboardScore(user);
      fetchUniLeaderboardDistance(user);
      fetchUniLeaderboardSpeed(user);
      dataFetched = true;
    }

    return SafeArea(
        child: universityData == null ||
                userData == null ||
                userDataDistance == null ||
                userDataSpeed == null
            ? Text("")
            : Scaffold(
                appBar: _buildAppBar(context),
                body: Container(
                  padding: EdgeInsets.only(top: 2.h),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 10.v),
                        Text(
                          "Universitetstävlingen",
                          style: theme.textTheme.headlineSmall!
                              .copyWith(fontSize: 20),
                        ),
                        SizedBox(height: 10.v),
                        _buildLeaderboardList(
                          context,
                        ),
                        SizedBox(height: 10.v),
                        Text("Mitt universitet",
                            style: theme.textTheme.headlineSmall!
                                .copyWith(fontSize: 20)),
                        _buildUniLeaderboard()
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
    List<String> titles1 = [
      universityData![0].university!.substring(0, 3),
      universityData![1].university!.substring(0, 3),
      universityData![2].university!.substring(0, 3),
      universityData![3].university!.substring(0, 3),
    ];

    List<String> titles2 = [
      universityData![0].university!.substring(0, 3),
      universityData![1].university!.substring(0, 3),
      universityData![2].university!.substring(0, 3),
      universityData![3].university!.substring(0, 3),
    ];

    List<String> titles3 = [
      universityData![0].university!.substring(0, 3),
      universityData![1].university!.substring(0, 3),
      universityData![2].university!.substring(0, 3),
      universityData![3].university!.substring(0, 3),
    ];

    List<BarChartGroupData> data1 = [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
              toY: 50000,
              color: Colors.blue,
              width: 40,
              borderRadius: BorderRadius.zero)
        ],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
              toY: 30000,
              color: Colors.orange,
              width: 40,
              borderRadius: BorderRadius.zero)
        ],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(
              toY: 70000,
              color: Colors.green,
              width: 40,
              borderRadius: BorderRadius.zero)
        ],
      ),
      BarChartGroupData(
        x: 3,
        barRods: [
          BarChartRodData(
              toY: 10000,
              color: Colors.pink,
              width: 40,
              borderRadius: BorderRadius.zero)
        ],
      ),
    ];

    List<BarChartGroupData> data2 = [
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

    List<BarChartGroupData> data3 = [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
              toY: 50000,
              color: Colors.blue,
              width: 40,
              borderRadius: BorderRadius.zero)
        ],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
              toY: 2,
              color: Colors.blue,
              width: 40,
              borderRadius: BorderRadius.zero)
        ],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(
              toY: 2,
              color: Colors.blue,
              width: 40,
              borderRadius: BorderRadius.zero)
        ],
      ),
      BarChartGroupData(
        x: 3,
        barRods: [
          BarChartRodData(
              toY: 8,
              color: Colors.blue,
              width: 40,
              borderRadius: BorderRadius.zero)
        ],
      ),
    ];

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
            List<List<BarChartGroupData>> data = [data1, data2, data3];
            List<List<String>> titles = [titles1, titles2, titles3];

            return LeaderboardItemWidget(
              data: data[index],
              titles: titles[index],
            );
          },
        ));
  }

  Widget _buildUniLeaderboard() {
    List<String> names = userData!.keys.toList();
    List<double> points = userData!.values.map((e) => e.toDouble()).toList();
    // Avrunda poängen och konvertera till strängar
    List<String> pointsString =
        points.map((e) => e.round().toString()).toList();

    List<String> namesDistance = userDataDistance!.keys.toList();
    List<double> distance =
        userDataDistance!.values.map((e) => e.toDouble()).toList();
    // Konvertera till strängar med två decimaler
    List<String> distanceString =
        distance.map((e) => e.toStringAsFixed(2)).toList();

    List<String> namesSpeed = userDataSpeed!.keys.toList();
    List<double> speed =
        userDataSpeed!.values.map((e) => e.toDouble()).toList();
    // Konvertera till strängar med två decimaler
    List<String> speedString = speed.map((e) => e.toStringAsFixed(2)).toList();

    List<List<String>> allNames = [namesDistance, names, namesSpeed];
    List<List<String>> allScores = [distanceString, pointsString, speedString];

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
            List<String> category = [
              "Kilometer sprunga",
              "Totala mängd poäng",
              "Kalorier brända",
            ];
            return UniLeaderboardItemWidget(
                uni: uni!,
                category: category[index],
                names: allNames[index],
                points: allScores[index]);
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

  void fetchLeaderboardDataDistance() async {
    try {
      List<University> data = await network.getLeaderboardDistance();
      setState(() {
        universityDataDistance = data;
      });
    } catch (e) {
      print("Error fetching leaderboard: $e");
    }
  }

  void fetchLeaderboardDataUsercount() async {
    try {
      List<University> data = await network.getLeaderboardUsercount();
      setState(() {
        universityDataUsers = data;
      });
    } catch (e) {
      print("Error fetching leaderboard: $e");
    }
  }

  void fetchUniLeaderboardScore(User user) async {
    try {
      Map<String, int> data =
          await network.getUniLeaderboardScore(user.university);
      print("DATA FETCHED SCORE");
      setState(() {
        uni = user.university;
        userData = data;
      });
    } catch (e) {
      print("Error fetching leaderboard: $e");
    }
  }

  void fetchUniLeaderboardDistance(User user) async {
    try {
      Map<String, double> data =
          await network.getUniLeaderboardDistance(user.university);
      print("DATA FETCHED DISTANCE");
      setState(() {
        userDataDistance = data;
      });
    } catch (e) {
      print("Error fetching leaderboard: $e");
    }
  }

  void fetchUniLeaderboardSpeed(User user) async {
    try {
      Map<String, double> data =
          await network.getUniLeaderboardSpeed(user.university);
      print("DATA FETCHED SPEED");
      setState(() {
        userDataSpeed = data;
      });
    } catch (e) {
      print("Error fetching leaderboard: $e");
    }
  }
}
