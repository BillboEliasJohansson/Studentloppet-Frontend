import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentloppet/User/user.dart';
import 'package:studentloppet/routes/app_routes.dart';
import 'package:studentloppet/theme/theme_helper.dart';
import 'package:studentloppet/Constants/image_constant.dart';
import 'package:studentloppet/utils/size_utils.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context, user),
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 1.v),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildProfileHeader(context),
                _buildNameRow(context, user),
                _dividerWithSpacing(),
                _buildUniversityRow(context, user),
                _dividerWithSpacing(),
                _buildLongestTrackRow(context, user),
                _dividerWithSpacing(),
                _buildMinDistanceRow(context, user),
                _dividerWithSpacing(),
                _buildScoreRow(context, user),
                _dividerWithSpacing(),
                _buildFastest5kmRow(context, user),
                _dividerWithSpacing(),
                _buildFastest10kmRow(context, user),
                _dividerWithSpacing(),
                _buildUniversityFastestRow(context, user),
                _dividerWithSpacing(),
                _buildUniversityMostRegisteredRow(context, user),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, User user) {
    return AppBar(
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.homeScreen);
          }),
      title: Text("Hemskärm"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Varning"),
                    content: Text("Är du säker på att du vill logga ut?"),
                    actions: <Widget>[
                      TextButton(
                        child: Text("Avbryt"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text("Logga ut"),
                        onPressed: () {
                          Navigator.of(context).pop();
                          user.reset();
                          Navigator.pushNamed(context, AppRoutes.initialRoute);
                        },
                      ),
                    ],
                  );
                });
          },
        ),
      ],
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 7.v),
        Text(
          "StudentLoppet",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          "Min profil",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        SizedBox(height: 54.v),
      ],
    );
  }

  Widget _buildNameRow(BuildContext context, User user) {
    return _buildRowView(context, "Namn", user.firstName + " " + user.lastName,
        ImageConstant.imgHat);
  }

  Widget _buildUniversityRow(BuildContext context, User user) {
    return _buildRowView(context, "Universitet", user.university.toString(),
        ImageConstant.imgHat);
  }

  Widget _buildLongestTrackRow(BuildContext context, User user) {
    return _buildRowView(context, "Mitt Universitets längsta sträcka",
        user.firstName, ImageConstant.imgHat);
  }

  Widget _buildMinDistanceRow(BuildContext context, User user) {
    return _buildRowView(
        context, "Min lägsta sträcka", user.firstName, ImageConstant.imgHat);
  }

  Widget _buildFastest5kmRow(BuildContext context, User user) {
    return _buildRowView(
        context, "Mitt snabbaste 5km", user.firstName, ImageConstant.imgFive);
  }

  Widget _buildFastest10kmRow(BuildContext context, User user) {
    return _buildRowView(
        context, "Mitt snabbaste 10km", user.firstName, ImageConstant.imgTen);
  }

  Widget _buildUniversityFastestRow(BuildContext context, User user) {
    return _buildRowView(context, "Mitt Universitets \nsnabbaste sträcka",
        user.firstName, ImageConstant.imgHat);
  }

  Widget _buildUniversityMostRegisteredRow(BuildContext context, User user) {
    return _buildRowView(context, "Mitt Universitets flest \nregistrerade",
        user.firstName, ImageConstant.imgHat);
  }

  Widget _buildScoreRow(BuildContext context, User user) {
    return _buildRowView(
        context, "Mina poäng", user.score.toString(), ImageConstant.imgHat);
  }

  Widget _dividerWithSpacing() {
    return Column(
      children: [
        SizedBox(height: 10.v),
        Divider(),
        SizedBox(height: 6.v),
      ],
    );
  }

  Widget _buildRowView(
      BuildContext context, String title, String detail, String imagePath) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 32.adaptSize,
          width: 32.adaptSize,
          decoration: BoxDecoration(
              color: appTheme.black900.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16.h),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
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
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 7.v, horizontal: 10),
          child: Text(
            detail,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        )
      ],
    );
  }
}
