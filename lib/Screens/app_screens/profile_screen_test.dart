import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentloppet/User/user.dart';
import 'package:studentloppet/routes/app_routes.dart';
import 'package:studentloppet/theme/app_decoration.dart';
import 'package:studentloppet/theme/custom_text_style.dart';
import 'package:studentloppet/theme/theme_helper.dart';
import 'package:studentloppet/Constants/image_constant.dart';
import 'package:studentloppet/utils/size_utils.dart';
import 'package:studentloppet/widgets/ProfileHelpers/appbar_title_profile.dart';
import 'package:studentloppet/widgets/app_bar/appbar_leading_image.dart';

import 'package:studentloppet/widgets/ProfileHelpers/custom_app_bar.dart';
import 'package:studentloppet/widgets/custom_helpers/custom_image_view.dart';

class ProfileScreenTest extends StatefulWidget {
  @override
  _ProfileScreenTestState createState() => _ProfileScreenTestState();
}

class _ProfileScreenTestState extends State<ProfileScreenTest> {
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(
      text: "",
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return SafeArea(
        child: Scaffold(
      appBar: _buildAppBar(context),
      body: Container(
          width: SizeUtils.width,
          height: SizeUtils.height,
          padding: EdgeInsets.symmetric(
            horizontal: 12.h,
            vertical: 13.v,
          ),
          child: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: 5.h,
              ),
              _buildTopCard(context, user),
              SizedBox(
                height: 5.h,
              ),
              _buildCard2(context, user, "Mitt Midnattslopp"),
              SizedBox(
                height: 5.h,
              ),
              _buildCard3(context, user, "Min Löpstatistik"),
              SizedBox(
                height: 5.h,
              ),
              _buildCard4(context, user, "Min statistik på universitet"),
              SizedBox(
                height: 5.h,
              ),
              _buildCard5(context, user, "Min statistik på universitet"),
              SizedBox(
                height: 20,
              )
            ]),
          )),
    ));
  }

  Widget _buildCard2(BuildContext context, User user, String header) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      margin: EdgeInsets.all(1),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: appTheme.purple200,
          width: 2.h,
        ),
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Container(
        height: 160.v,
        width: 340.h,
        padding: EdgeInsets.all(7.h),
        decoration: AppDecoration.outlinePurple.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder10,
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 200.v,
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
            _buildInfoCard2(context, user),
          ],
        ),
      ),
    );
  }

  Widget _buildCard3(BuildContext context, User user, String header) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      margin: EdgeInsets.all(1),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: appTheme.purple200,
          width: 2.h,
        ),
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Container(
        height: 160.v,
        width: 340.h,
        padding: EdgeInsets.all(7.h),
        decoration: AppDecoration.outlinePurple.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder10,
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 200.v,
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
            _buildInfoCard3(context, user),
          ],
        ),
      ),
    );
  }

  Widget _buildCard4(BuildContext context, User user, String header) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      margin: EdgeInsets.all(1),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: appTheme.purple200,
          width: 2.h,
        ),
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Container(
        height: 160.v,
        width: 340.h,
        padding: EdgeInsets.all(7.h),
        decoration: AppDecoration.outlinePurple.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder10,
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 200.v,
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
            _buildInfoCard4(context, user),
          ],
        ),
      ),
    );
  }

  Widget _buildCard5(BuildContext context, User user, String header) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      margin: EdgeInsets.all(1),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: appTheme.purple200,
          width: 2.h,
        ),
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Container(
        height: 160.v,
        width: 340.h,
        padding: EdgeInsets.all(7.h),
        decoration: AppDecoration.outlinePurple.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder10,
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Align(
              alignment: Alignment.center,
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
            Image.network(
                "https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExNXJ2eXE0aW5za2V1ZTg4dWoxamJ6NWdtOTF4dWd6NW5nb211emRwYSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/etOX3h7ApZuDe7Fc5w/giphy-downsized-large.gif"),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard2(
    context,
    user,
  ) {
    return Column(children: [
      SizedBox(height: 30),
      _buildRowView(
        context,
        user,
        "Namn",
        user.firstName.toString() + " " + user.lastName.toString(),
        ImageConstant.imgRunner,
      ),
      SizedBox(height: 0.v),
      Divider(
        indent: 20.h,
        color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.80),
        endIndent: 20,
      ),
      _buildRowView(
        context,
        user,
        "cow",
        "cat",
        ImageConstant.imgCloud,
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
        "Universitet",
        user.university,
        ImageConstant.imgHatNew,
      ),
      SizedBox(height: 0.v),
      Divider(
        indent: 20.h,
        color: Colors.white.withOpacity(0.80),
        endIndent: 20,
      )
    ]);
  }

  Widget _buildInfoCard3(
    context,
    user,
  ) {
    return Column(children: [
      SizedBox(height: 30),
      _buildRowView(
        context,
        user,
        "Snabb?",
        "Som Fan",
        ImageConstant.imgUmbrella,
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
        "Stark?",
        "Såklart",
        ImageConstant.imgWind,
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
        "Hotell?",
        "Trivago",
        ImageConstant.imgBigMarker,
      ),
      SizedBox(height: 0.v),
      Divider(
        indent: 20.h,
        color: Colors.white.withOpacity(0.80),
        endIndent: 20,
      )
    ]);
  }

  Widget _buildInfoCard4(
    context,
    user,
  ) {
    return Column(children: [
      SizedBox(height: 30),
      _buildRowView(
        context,
        user,
        "Test",
        "ing",
        ImageConstant.imgUmbrella,
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
        "banan",
        "choklad",
        ImageConstant.imgWind,
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
        "gurka",
        "tomat",
        ImageConstant.imgBigMarker,
      ),
      SizedBox(height: 0.v),
      Divider(
        indent: 20.h,
        color: Colors.white.withOpacity(0.80),
        endIndent: 20,
      )
    ]);
  }

  Widget _buildCardHeader(BuildContext context, String header) {
    return Padding(
      padding: EdgeInsets.only(
        left: 10.h,
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

  Widget _buildTopCard(BuildContext context, User user) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      margin: EdgeInsets.all(1),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: appTheme.orange.withOpacity(0.94),
          width: 2.h,
        ),
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Container(
        height: 130.v,
        width: 340.h,
        padding: EdgeInsets.all(7.h),
        decoration: AppDecoration.outlineOrange.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder10,
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 135.v,
                width: 330.h,
                decoration: BoxDecoration(
                  color: appTheme.orange.withOpacity(0.94),
                  borderRadius: BorderRadius.circular(
                    5.h,
                  ),
                ),
              ),
            ),
            _buildInfoTopCard(context, user),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTopCard(BuildContext context, User user) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: 10.v),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildProfilePicture(),
            _buildProfileText(context),
            _buildEditButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfilePicture() {
    return Container(
      height: 90.adaptSize,
      width: 90.adaptSize,
      margin: EdgeInsets.only(
        top: 5.v,
        bottom: 20.v,
        left: 10.v,
      ),
      padding: EdgeInsets.all(2.h),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2.h),
      ),
      child: CustomImageView(
        imagePath: ImageConstant.imgFrog,
        height: 78.adaptSize,
        width: 78.adaptSize,
        radius: BorderRadius.circular(39.h),
        alignment: Alignment.center,
      ),
    );
  }

  Widget _buildProfileText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 15.h,
        top: 8.v,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Provider.of<User>(context).firstName,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          SizedBox(
            width: 141.h,
            child: Text(
              textController.text,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: CustomTextStyles.bodySmall10,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildEditButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _editText(context),
      child: CustomImageView(
        imagePath: ImageConstant.imgEdit,
        height: 20.v,
        width: 21.h,
        margin: EdgeInsets.only(
          left: 34.h,
          bottom: 89.v,
        ),
      ),
    );
  }

  void _editText(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Redigera Text"),
          content: TextField(
            controller: textController,
            maxLines: null,
            keyboardType: TextInputType.multiline,
          ),
          actions: [
            TextButton(
              child: Text('Spara'),
              onPressed: () {
                setState(() {
                  // Update the text with the new value from the text field
                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        );
      },
    );
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
        text: "Profil",
      ),
      styleType: Style.bgFill,
    );
  }
}
