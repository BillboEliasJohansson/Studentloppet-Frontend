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
      body: SingleChildScrollView(
        child: Container(
            width: SizeUtils.width,
            height: SizeUtils.height,
            padding: EdgeInsets.symmetric(
              horizontal: 12.h,
              vertical: 13.v,
            ),
            child: Column(children: [
              SizedBox(
                height: 5.h,
              ),
              _buildTopCard(context, user),
              SizedBox(
                height: 5.h,
              ),
              _buildCard(context, user),
              SizedBox(
                height: 5.h,
              ),
              _buildCard(context, user),
              SizedBox(
                height: 5.h,
              ),
              _buildCard(context, user),
            ])),
      ),
    ));
  }

  Widget _buildCard(BuildContext context, User user) {
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
        height: 130.v,
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
                height: 135.v,
                width: 330.h,
                decoration: BoxDecoration(
                  color: appTheme.deepPurple500,
                  borderRadius: BorderRadius.circular(
                    5.h,
                  ),
                ),
              ),
            ),
            _buildCardHeader(context),
            _buildInfoCard(context, user),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(context, user) {
    return Column(children: [
      _buildTestRow(context, user),
    ]);
  }

  Widget _buildTestRow(BuildContext context, User user) {
    return _buildRowView(context, "Test", user.firstName + " " + user.lastName,
        ImageConstant.imgHat);
  }

  Widget _buildCardHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 10.h,
        top: 3.v,
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          "Mitt Midnattslopp",
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
    );
  }

  Widget _buildRowView(
      BuildContext context, String title, String detail, String imagePath) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 36.adaptSize,
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
