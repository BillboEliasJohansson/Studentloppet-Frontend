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
import 'package:studentloppet/widgets/custom_helpers/custom_image_view.dart';
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

  Map<String, String>? userDataProfilePictures;
  Map<String, String>? userDataDistanceProfilePictures;
  Map<String, String>? userDataSpeedProfilePictures;

  String? uni;

  Map<String, dynamic> activityData = {};

  bool dataFetched = false;

  bool leaderBoardBuilt = false;

  @override
  void initState() {
    fetchLeaderboardData();
    fetchLeaderboardDataDistance();
    fetchLeaderboardDataUsercount();
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
                universityDataDistance == null ||
                universityDataUsers == null ||
                userData == null ||
                userDataDistance == null ||
                userDataSpeed == null ||
                userDataProfilePictures == null ||
                userDataDistanceProfilePictures == null ||
                userDataSpeedProfilePictures == null
            ? Scaffold(
                body: Container(
                  width: SizeUtils.width,
                  height: SizeUtils.height,
                  decoration: BoxDecoration(color: appTheme.purple200),
                  child: SizedBox(
                      width: SizeUtils.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomImageView(
                              imagePath: ImageConstant.imgLogo,
                              height: 56.v,
                              width: 400.h,
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text("Kom ihåg att dricka vatten!",
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                    fontSize: 20,
                                  )),
                          SizedBox(
                            height: 20.h,
                          ),
                          CircularProgressIndicator()
                        ],
                      )),
                ),
              )
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
                        _buildUniLeaderboard(),
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
      universityDataDistance![0].university!.substring(0, 3),
      universityDataDistance![1].university!.substring(0, 3),
      universityDataDistance![2].university!.substring(0, 3),
      universityDataDistance![3].university!.substring(0, 3),
    ];

    List<String> titles2 = [
      universityData![0].university!.substring(0, 3),
      universityData![1].university!.substring(0, 3),
      universityData![2].university!.substring(0, 3),
      universityData![3].university!.substring(0, 3),
    ];

    List<String> titles3 = [
      universityDataUsers![0].university!.substring(0, 3),
      universityDataUsers![1].university!.substring(0, 3),
      universityDataUsers![2].university!.substring(0, 3),
      universityDataUsers![3].university!.substring(0, 3),
    ];

    List<BarChartGroupData> data1 = [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
              toY: universityDataDistance![0].distance!.toDouble(),
              color: Colors.blue,
              width: 40,
              borderRadius: BorderRadius.zero)
        ],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
              toY: universityDataDistance![1].distance!.toDouble(),
              color: Colors.orange,
              width: 40,
              borderRadius: BorderRadius.zero)
        ],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(
              toY: universityDataDistance![2].distance!.toDouble(),
              color: Colors.green,
              width: 40,
              borderRadius: BorderRadius.zero)
        ],
      ),
      BarChartGroupData(
        x: 3,
        barRods: [
          BarChartRodData(
              toY: universityDataDistance![3].distance!.toDouble(),
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
              toY: universityDataUsers![0].users!.toDouble(),
              color: Colors.blue,
              width: 40,
              borderRadius: BorderRadius.zero)
        ],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
              toY: universityDataUsers![1].users!.toDouble(),
              color: Colors.orange,
              width: 40,
              borderRadius: BorderRadius.zero)
        ],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(
              toY: universityDataUsers![2].users!.toDouble(),
              color: Colors.green,
              width: 40,
              borderRadius: BorderRadius.zero)
        ],
      ),
      BarChartGroupData(
        x: 3,
        barRods: [
          BarChartRodData(
              toY: universityDataUsers![3].users!.toDouble(),
              color: Colors.red,
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
            List<String> category = [
              "Totala kilometer sprugna",
              "Totala mängd poäng",
              "Flest löpare registrerade"
            ];
            List<double> scale = [
              universityDataDistance![0].distance!.toDouble() + 500,
              universityData![0].score!.toDouble() + 50000,
              universityDataUsers![0].users!.toDouble() + 10
            ];

            return LeaderboardItemWidget(
              maxY: scale[index],
              category: category[index],
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

    List<List<String>> allProfilePictures = [
      namesDistance
          .map((name) => userDataDistanceProfilePictures![name]!)
          .toList(),
      names.map((name) => userDataProfilePictures![name]!).toList(),
      namesSpeed.map((name) => userDataSpeedProfilePictures![name]!).toList(),
    ];

    return SizedBox(
        height: 320.v,
        child: ListView.separated(
          cacheExtent: 4000,
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
              "Hastighet - min/km",
            ];
            print("Längd: " + allProfilePictures.length.toString());
            return UniLeaderboardItemWidget(
              uni: uni!,
              category: category[index],
              names: allNames[index],
              points: allScores[index],
              profilePictures: allProfilePictures[index],
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

  void fetchLeaderboardData() async {
    try {
      List<University> data = await network.getLeaderboard();
      print("DATA FETCHED LEADERBOARD DATA");
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
      print("DATA FETCHED LEADERBOARD DISTANCE");
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
      print("DATA FETCHED USER COUNT");
      setState(() {
        universityDataUsers = data;
      });
    } catch (e) {
      print("Error fetching leaderboard: $e");
    }
  }

  void fetchUniLeaderboardScore(User user) async {
    try {
      Map<String, Map<String, dynamic>> data =
          await network.getUniLeaderboardScore(user.university);
      print("DATA FETCHED SCORE");

      Map<String, int> userDataDistanceTemp = {};
      Map<String, String> userDataProfilePicturesTemp = {};

      data.forEach((userName, userInfo) {
        userDataDistanceTemp[userName] = userInfo['score'];
        userDataProfilePicturesTemp[userName] =
            userInfo['profilePictureBase64'];
      });

      setState(() {
        uni = user.universityDisplayName;
        userData = userDataDistanceTemp;
        userDataProfilePictures = userDataProfilePicturesTemp;
      });
    } catch (e) {
      print("Error fetching leaderboard: $e");
    }
  }

  void fetchUniLeaderboardDistance(User user) async {
    try {
      Map<String, Map<String, dynamic>> data =
          await network.getUniLeaderboardDistance(user.university);
      print("DATA FETCHED DISTANCE");

      Map<String, double> userDataDistanceTemp = {};
      Map<String, String> userDataProfilePicturesTemp = {};

      data.forEach((userName, userInfo) {
        userDataDistanceTemp[userName] = userInfo['score'];
        userDataProfilePicturesTemp[userName] =
            userInfo['profilePictureBase64'];
      });

      setState(() {
        userDataDistance = userDataDistanceTemp;
        userDataDistanceProfilePictures = userDataProfilePicturesTemp;
      });
    } catch (e) {
      print("Error fetching leaderboard: $e");
    }
  }

  void fetchUniLeaderboardSpeed(User user) async {
    try {
      Map<String, Map<String, dynamic>> data =
          await network.getUniLeaderboardSpeed(user.university);
      print("DATA FETCHED SPEED");

      Map<String, double> userDataDistanceTemp = {};
      Map<String, String> userDataProfilePicturesTemp = {};

      data.forEach((userName, userInfo) {
        userDataDistanceTemp[userName] = userInfo['score'];
        userDataProfilePicturesTemp[userName] =
            userInfo['profilePictureBase64'];
      });

      setState(() {
        userDataSpeed = userDataDistanceTemp;
        userDataSpeedProfilePictures = userDataProfilePicturesTemp;
      });
    } catch (e) {
      print("Error fetching leaderboard: $e");
    }
  }
}
