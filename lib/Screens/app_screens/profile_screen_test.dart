import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:studentloppet/User/user.dart';
import 'package:studentloppet/networking/network.dart';
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
import 'package:studentloppet/widgets/custom_nav_bar.dart';
import 'package:image_cropper/image_cropper.dart';

class ProfileScreenTest extends StatefulWidget {
  @override
  _ProfileScreenTestState createState() => _ProfileScreenTestState();
}

class _ProfileScreenTestState extends State<ProfileScreenTest> {
  late TextEditingController textController;
  Map<String, dynamic> activityData = {};
  Map<String, dynamic> userRankData = {};
  bool dataFetched = false;
  CroppedFile? _image;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(
      text: "",
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        cropStyle: CropStyle.circle,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 90,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Beskär bild',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true,
          ),
          IOSUiSettings(
            minimumAspectRatio: 1.0,
          ),
        ],
      );

      if (croppedFile != null) {
        setState(() {
          _image = CroppedFile(croppedFile.path);
        });
        // Ladda upp bilden till servern
        await _setProfilePicture(context);
      }
    }
  }

  Future<void> _setProfilePicture(BuildContext context) async {
    User user = Provider.of<User>(context, listen: false);
    String email = user.email;

    if (_image == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Vänligen välj en bild")));
      return;
    }

    try {
      final response = await network.uploadProfilePicture(email, _image!);

      if (response.statusCode == 200) {
        if (response.body.contains("Profile picture uploaded successfully")) {
          final profileResponse = await network.getProfilePicture(email);
          if (profileResponse.statusCode == 200) {
            final base64Image = base64Encode(profileResponse.bodyBytes);
            final profilePictureUrl = 'data:image/jpeg;base64,$base64Image';
            user.updateProfilePicture(profilePictureUrl);
          }
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Profilbild uppladdad")));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Misslyckades med att ladda upp profilbild")));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Fel vid uppladdning av profilbild")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Fel: $e")));
    }
  }

  void fetchLeaderboardData(user) async {
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

  void fetchRank(user) async {
    try {
      Map<String, dynamic> data = await network.getUniRank(user.email);
      setState(() {
        userRankData = data;
      });
      return;
    } catch (e) {
      print("Error fetching leaderboard: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!dataFetched) {
      // Anropa funktionerna bara om data inte redan har hämtats
      User user = Provider.of<User>(context);
      fetchLeaderboardData(user);
      fetchRank(user);
      dataFetched =
          true; // Uppdatera flaggan när data hämtats för första gången
    }
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: SizeUtils.width,
          height: SizeUtils.height,
          padding: EdgeInsets.only(
            top: 13.v,
            left: 10,
            right: 10,
            bottom: 1,
          ),
          child: SingleChildScrollView(
            child: Consumer<User>(
              builder: (context, user, _) {
                return Column(
                  children: [
                    SizedBox(height: 5.h),
                    _buildTopCard(context, user),
                    SizedBox(height: 5.h),
                    _buildCard2(context, user, "Mitt Midnattslopp"),
                    SizedBox(height: 5.h),
                    _buildCard3(context, user, "Min Löpstatistik"),
                    SizedBox(height: 5.h),
                    _buildCard4(context, user, "Min statistik på universitet"),
                    SizedBox(height: 5.h),
                  ],
                );
              },
            ),
          ),
        ),
        bottomNavigationBar: CustomNavBar(
          PageIndex: 3,
        ),
      ),
    );
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
      child: IntrinsicHeight(
        child: Container(
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
                  width: 330.h,
                  decoration: BoxDecoration(
                    color: appTheme.deepPurple500,
                    borderRadius: BorderRadius.circular(5.h),
                  ),
                ),
              ),
              _buildCardHeader(context, header),
              _buildInfoCard2(context, user),
            ],
          ),
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
      child: IntrinsicHeight(
        child: Container(
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
                  width: 330.h,
                  decoration: BoxDecoration(
                    color: appTheme.deepPurple500,
                    borderRadius: BorderRadius.circular(5.h),
                  ),
                ),
              ),
              _buildCardHeader(context, header),
              _buildInfoCard3(context, user),
            ],
          ),
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
      child: IntrinsicHeight(
        child: Container(
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
                  width: 330.h,
                  decoration: BoxDecoration(
                    color: appTheme.deepPurple500,
                    borderRadius: BorderRadius.circular(5.h),
                  ),
                ),
              ),
              _buildCardHeader(context, header),
              _buildInfoCard4(context, user),
            ],
          ),
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
        "PlaceHolder",
        "PlaceHolder",
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
      ),
      SizedBox(height: 10),
    ]);
  }

  Widget _buildInfoCard3(
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
            : activityData['totalDuration'].toStringAsFixed(2) + " min",
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
            : activityData['totalDistance'].toStringAsFixed(2) + " km",
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
            : activityData['averageSpeed'].toStringAsFixed(2) + " km/m",
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
            : activityData['caloriesBurned'].toStringAsFixed(2) + " kcal",
        ImageConstant.imgFire,
      ),
      SizedBox(height: 0.v),
      Divider(
        indent: 20.h,
        color: Colors.white.withOpacity(0.80),
        endIndent: 20,
      ),
      SizedBox(height: 10),
    ]);
  }

  Widget _buildInfoCard4(
    context,
    user,
  ) {
    return Column(children: [
      SizedBox(height: 40),
      _buildRowView(
        context,
        user,
        "Totalt med poäng",
        userRankData['scoreRank'] == null
            ? "..."
            : userRankData["scoreRank"].toString() + ":a plats",
        ImageConstant.imgTrophy,
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
        "Totalt sprunga kilometer",
        userRankData['distanceRank'] == null
            ? "..."
            : userRankData["distanceRank"].toString() + ":a plats",
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
        "Hastighet",
        userRankData['speedRank'] == null
            ? "..."
            : userRankData["speedRank"].toString() + ":a plats",
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
        "Totala kalorier brända",
        userRankData['caloriesRank'] == null
            ? "..."
            : userRankData["caloriesRank"].toString() + ":a plats",
        ImageConstant.imgFire,
      ),
      SizedBox(height: 0.v),
      Divider(
        indent: 20.h,
        color: Colors.white.withOpacity(0.80),
        endIndent: 20,
      ),
      SizedBox(height: 10),
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
          title == "Universitet"
              ? Flexible(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 7.v, horizontal: 10),
                    child: Text(
                      detail,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.white,
                            fontSize: 10, // Mindre textstorlek
                          ),
                      maxLines: 2, // Tillåter texten att gå till nästa rad
                      overflow: TextOverflow
                          .ellipsis, // Lägger till ellips för overflowed text
                    ),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(vertical: 7.v, horizontal: 10),
                  child: Text(
                    detail,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
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
            _buildProfilePicture(context, user),
            _buildProfileText(context),
            _buildEditButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfilePicture(BuildContext context, User user) {
    return Container(
      height: 90.adaptSize,
      width: 90.adaptSize,
      margin: EdgeInsets.only(
        top: 5.v,
        bottom: 20.v,
        left: 10.v,
      ),
      child: Stack(
        children: [
          Container(
            height: 90.adaptSize,
            width: 90.adaptSize,
            padding: EdgeInsets.all(2.h),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2.h),
            ),
            child: ClipOval(
              child: user.profilePictureBytes == null
                  ? Image.asset(
                      ImageConstant.imgRunner,
                      height: 78.adaptSize,
                      width: 78.adaptSize,
                      fit: BoxFit.contain,
                    )
                  : Image.memory(
                      user.profilePictureBytes!,
                      fit: BoxFit.cover,
                      width: 78,
                      height: 78,
                    ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: _pickImage,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Icon(
                    Icons.add_a_photo,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
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
              style: CustomTextStyles.bodySmall10.copyWith(
                color: Colors.white,
              ),
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
        ),
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "Profil",
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.logout, color: Colors.white),
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.initialRoute);
          },
        ),
      ],
      styleType: Style.bgFill,
    );
  }
}
