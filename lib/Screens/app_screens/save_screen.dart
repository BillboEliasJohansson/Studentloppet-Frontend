import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:studentloppet/User/user.dart';
import 'package:studentloppet/routes/app_routes.dart';
import 'package:studentloppet/theme/custom_text_style.dart';
import 'package:studentloppet/theme/theme_helper.dart';
import 'package:studentloppet/utils/image_constant.dart';
import 'package:studentloppet/utils/size_utils.dart';
import 'package:studentloppet/utils/timer.utils.dart';
import 'package:studentloppet/widgets/custom_elevated_button.dart';
import 'package:studentloppet/networking/network.dart';

class SaveScreen extends StatelessWidget {
  SaveScreen(
      {super.key,
      required this.startLocation,
      required this.endLocation,
      required this.totalDistance,
      required this.time,
      required this.polylineCoordinates});

  final LocationData? startLocation;
  final LocationData? endLocation;
  final double totalDistance;
  final Duration time;
  final List<LatLng> polylineCoordinates;

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
                _buildMap(context),
                SizedBox(height: 20.v),
                _buildDistanceRow(context),
                _dividerWithSpacing(),
                _buildTimeRow(context),
                _dividerWithSpacing(),
                _buildPaceRow(context),
                SizedBox(height: 40.v),
                _buildSaveRun(context, user)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMap(BuildContext context) {
    return Center(
      child: Container(
        height: 386.adaptSize,
        width: 336.adaptSize,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: GoogleMap(
          mapType: MapType.terrain,
          initialCameraPosition: CameraPosition(
              target: LatLng(endLocation!.latitude!, endLocation!.longitude!),
              zoom: 15),
          polylines: {
            Polyline(
                polylineId: PolylineId("route"),
                points: polylineCoordinates,
                color: Colors.purple,
                width: 6),
          },
          markers: {
            Marker(
              markerId: MarkerId("startLocation"),
              position:
                  LatLng(startLocation!.latitude!, startLocation!.longitude!),
            ),
            Marker(
              markerId: MarkerId("endLocation"),
              position: LatLng(endLocation!.latitude!, endLocation!.longitude!),
            )
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, User user) {
    return AppBar(
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.runScreen);
          }),
      title: Text("Save Run"),
    );
  }

  Widget _buildDistanceRow(BuildContext context) {
    return _buildRowView(
        context,
        "Distance",
        (totalDistance / 1000).toStringAsFixed(2) + " km",
        ImageConstant.imgHat);
  }

  Widget _buildTimeRow(BuildContext context) {
    return _buildRowView(
        context, "Time", formatDuration(time) + " min", ImageConstant.imgHat);
  }

  Widget _buildPaceRow(BuildContext context) {
    return _buildRowView(context, "Pace", calculatePace(time, totalDistance),
        ImageConstant.imgFrog);
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

  String calculatePace(Duration time, double distance) {
    double distanceInKilometers =
        distance / 1000; // Convert meters to kilometers
    double timeInMinutes = time.inSeconds / 60.0; // Convert seconds to minutes
    if (distanceInKilometers == 0) return "0 min/km"; // Avoid division by zero

    double minutesPerKilometer = timeInMinutes / distanceInKilometers;
    return minutesPerKilometer.toStringAsFixed(2) + " min/km";
  }

  Widget _buildSaveRun(BuildContext context, User user) {
    return CustomElevatedButton(
      buttonStyle: ButtonStyle(
          backgroundColor:
              MaterialStateColor.resolveWith((states) => Colors.green)),
      text: "Save Run",
      margin: EdgeInsets.only(
        left: 12.h,
        right: 12.h,
        bottom: 12.v,
      ),
      buttonTextStyle: CustomTextStyles.titleMediumWhiteA700,
      onPressed: () {
        sendActivity(context, user);
      },
    );
  }

  Future<void> sendActivity(BuildContext context, User user) async {
    final response =
        await network.postActivity(user.email, totalDistance, time);

    if (response.statusCode == 200) {
      print("Response: " + response.body);
      if (response.body.contains("id")) {
        Navigator.pushNamed(context, AppRoutes.homeScreen);
      } else {}
    } else {}
  }
}
