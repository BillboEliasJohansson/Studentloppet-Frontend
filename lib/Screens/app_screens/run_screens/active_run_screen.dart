import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:studentloppet/Constants/constants.dart';
import 'package:studentloppet/Screens/app_screens/run_screens/save_screen.dart';
import 'package:studentloppet/routes/app_routes.dart';
import 'package:studentloppet/theme/app_decoration.dart';
import 'package:studentloppet/theme/custom_text_style.dart';
import 'package:studentloppet/theme/theme_helper.dart';
import 'package:studentloppet/Constants/image_constant.dart';
import 'package:studentloppet/utils/size_utils.dart';
import 'package:studentloppet/utils/timer.utils.dart';
import 'package:studentloppet/widgets/ProfileHelpers/appbar_title_profile.dart';
import 'package:studentloppet/widgets/ProfileHelpers/custom_app_bar.dart';
import 'package:studentloppet/widgets/app_bar/appbar_leading_image.dart';

import 'package:studentloppet/widgets/custom_helpers/custom_outlined_button.dart';
import 'package:studentloppet/widgets/custom_helpers/metricslist_item_widget.dart';
import 'package:geolocator/geolocator.dart';

class ActiveRunScreen extends StatefulWidget {
  const ActiveRunScreen({super.key});

  @override
  State<ActiveRunScreen> createState() => _ActiveRunScreenState();
}

class _ActiveRunScreenState extends State<ActiveRunScreen> {
  Completer<GoogleMapController>? _controller;
  List<LatLng> polylineCoordinates = [];
  StreamSubscription<LocationData>? _locationSubscription;
  LocationData? currentLocation;
  LocationData? startLocation;
  bool activeRun = false;
  String buttonText = "Starta löprunda";
  Timer? _timer;
  DateTime? _startTime;
  Duration _elapsedTime = Duration.zero;
  double totalDistance = 0.0;

  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  @override
  void initState() {
    super.initState();
    _controller = Completer();
    getCurrentLocation();
    setCustomMarkers();
    getPolyPoints();
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel any running timer when disposing
    _locationSubscription?.cancel();
    _controller = null; // Avoid completing the controller after disposal
    super.dispose();
  }

  void setCustomMarkers() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, ImageConstant.imgBigMarker)
        .then((icon) => currentLocationIcon = icon);
  }

  void getCurrentLocation() async {
    Location location = Location();

    // Subscribe to location changes and update the camera
    _locationSubscription = location.onLocationChanged.listen((newLoc) async {
      currentLocation = newLoc;

      if (_controller != null && _controller!.isCompleted) {
        final controller = await _controller!.future;
        if (activeRun) {
          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                zoom: await controller.getZoomLevel(),
                target: LatLng(newLoc.latitude!, newLoc.longitude!),
              ),
            ),
          );
        }
      }

      // Only call setState if the widget is still mounted
      if (mounted) {
        setState(() {
          // Any additional state changes
        });
      }
    });
  }

  void getPolyPoints() async {
    Location location = Location();
    PolylinePoints polylinePoints = PolylinePoints();

    _locationSubscription = location.onLocationChanged.listen((newLoc) async {
      if (activeRun) {
        currentLocation = newLoc;
        PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          google_api_key,
          PointLatLng(startLocation!.latitude!, startLocation!.longitude!),
          PointLatLng(newLoc.latitude!, newLoc.longitude!),
        );

        if (polylineCoordinates.isNotEmpty) {
          final lastPoint = polylineCoordinates.last;
          totalDistance += Geolocator.distanceBetween(
            lastPoint.latitude,
            lastPoint.longitude,
            newLoc.latitude!,
            newLoc.longitude!,
          );
        }

        setState(() {
          polylineCoordinates = result.points
              .map(
                (point) => LatLng(point.latitude, point.longitude),
              )
              .toList();
        });
      }
    });
  }

  void startRun() {
    startLocation = currentLocation;

    _startTime = DateTime.now(); // Record the start time
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _elapsedTime = DateTime.now().difference(_startTime!);
        });
      }
    });

    setState(() {
      buttonText = "Stoppa löprunda";
      activeRun = true;
    });
  }

  void stopRun() {
    _timer?.cancel(); // Stop the timer

    setState(() {
      buttonText = "Starta löprunda";
      activeRun = false;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SaveScreen(
          startLocation: startLocation,
          endLocation: currentLocation,
          totalDistance: totalDistance,
          time: _elapsedTime,
          polylineCoordinates: polylineCoordinates,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 12.v),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMap(context),
              SizedBox(height: 20.v),
              Padding(
                padding: EdgeInsets.only(left: 12.h),
                child: Text(
                  "Statistics",
                  style: theme.textTheme.titleMedium,
                ),
              ),
              SizedBox(height: 1.v),
              Padding(
                padding: EdgeInsets.only(left: 12.h),
                child: Text(
                  "Distance, Time, Pace",
                  style: CustomTextStyles.bodySmallPrimary,
                ),
              ),
              SizedBox(height: 6.v),
              _buildMetricsList(context),
              SizedBox(height: 6.v),
              Padding(
                padding: EdgeInsets.only(left: 17, right: 17),
                child: _buildButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMap(BuildContext context) {
    return Center(
      child: Container(
        height: 290.adaptSize,
        width: SizeUtils.width,
        decoration: BoxDecoration(
          border: Border.symmetric(
              vertical: BorderSide.none,
              horizontal: BorderSide(color: appTheme.deepPurple500, width: 3)),
        ),
        child: currentLocation == null
            ? Center(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 200.0,
                  ),
                  SizedBox(
                    child: Center(child: CircularProgressIndicator()),
                    height: 50.0,
                    width: 50.0,
                  ),
                ],
              ))
            : GoogleMap(
                mapType: MapType.terrain,
                initialCameraPosition: CameraPosition(
                    target: LatLng(currentLocation!.latitude!,
                        currentLocation!.longitude!),
                    zoom: 15),
                polylines: {
                  Polyline(
                      polylineId: PolylineId("route"),
                      points: polylineCoordinates,
                      color: appTheme.purple200,
                      width: 6),
                },
                markers: {
                  Marker(
                    markerId: MarkerId("currentLocation"),
                    icon: currentLocationIcon,
                    position: LatLng(currentLocation!.latitude!,
                        currentLocation!.longitude!),
                  )
                },
                onMapCreated: (mapController) {
                  _controller!.complete(mapController);
                },
              ),
      ),
    );
  }

  Widget _buildMetricsList(BuildContext context) {
    return SizedBox(
        height: 70.v,
        child: Padding(
          padding: EdgeInsets.only(right: 0.h),
          child: ListView.separated(
            padding: EdgeInsets.only(left: 10.h),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => SizedBox(width: 3.h),
            itemCount: 2,
            itemBuilder: (context, index) {
              List<String> titles = ["Distance", "Time"];
              String distanceDisplay =
                  (totalDistance / 1000).toStringAsFixed(2) + " km";
              List<String> values = [
                distanceDisplay,
                formatDuration(_elapsedTime),
              ];
              return MetricslistItemWidget(
                upperText: titles[index],
                lowerText: values[index],
              );
            },
          ),
        ));
  }

  Widget _buildButton() {
    return Container(
      decoration: AppDecoration.outlineOrange.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: CustomOutlinedButton(
        margin: EdgeInsets.all(5),
        buttonStyle: ButtonStyle(
            side: MaterialStateBorderSide.resolveWith(
                (states) => BorderSide(style: BorderStyle.none)),
            shape: MaterialStateProperty.resolveWith<OutlinedBorder?>(
              (states) => RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(10)),
            ),
            backgroundColor:
                MaterialStateColor.resolveWith((states) => appTheme.orange)),
        text: buttonText,
        buttonTextStyle: theme.textTheme.displayMedium!.copyWith(fontSize: 30),
        onPressed: () {
          if (currentLocation == null) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Please Wait"),
                    actions: <Widget>[
                      TextButton(
                        child: Text("Dissmiss"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                });
            return;
          }
          if (activeRun) {
            stopRun();
          } else {
            startRun();
          }
        },
      ),
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
        text: "Ny löprunda",
      ),
      styleType: Style.bgFill,
    );
  }
}
