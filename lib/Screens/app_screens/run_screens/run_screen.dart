import 'dart:async';
import 'package:flutter/material.dart';
import 'package:studentloppet/theme/custom_text_style.dart';
import 'package:studentloppet/utils/string_utils.dart';
import 'package:studentloppet/widgets/custom_helpers/custom_image_view.dart';
import 'package:weather/weather.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:studentloppet/Constants/constants.dart';
import 'package:studentloppet/User/user.dart';
import 'package:studentloppet/routes/app_routes.dart';
import 'package:studentloppet/theme/app_decoration.dart';
import 'package:studentloppet/theme/theme_helper.dart';
import 'package:studentloppet/Constants/image_constant.dart';
import 'package:studentloppet/utils/size_utils.dart';
import 'package:studentloppet/utils/timer.utils.dart';
import 'package:studentloppet/widgets/ProfileHelpers/appbar_title_profile.dart';
import 'package:studentloppet/widgets/ProfileHelpers/custom_app_bar.dart';
import 'package:studentloppet/widgets/app_bar/appbar_leading_image.dart';
import 'package:studentloppet/networking/network.dart';

import 'package:studentloppet/widgets/custom_helpers/custom_outlined_button.dart';
import 'package:studentloppet/widgets/custom_helpers/metricslist_item_widget.dart';
import 'package:geolocator/geolocator.dart';

class RunScreen extends StatefulWidget {
  const RunScreen({super.key});

  @override
  State<RunScreen> createState() => _RunScreenState();
}

class _RunScreenState extends State<RunScreen> {
  Completer<GoogleMapController>? _controller;
  List<LatLng> polylineCoordinates = [];
  StreamSubscription<LocationData>? _locationSubscription;
  LocationData? currentLocation;
  LocationData? startLocation;
  bool activeRun = false;
  RunState currentState = RunState.before;
  String buttonText = "Starta en ny löprunda";
  Timer? _timer;
  DateTime? _startTime;
  Duration _elapsedTime = Duration.zero;
  double totalDistance = 0.0;

  Weather? w;
  WeatherFactory wf =
      new WeatherFactory(weather_api_key, language: Language.SWEDISH);

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
      currentState = RunState.during;
      buttonText = "Avsluta löprundan";
      activeRun = true;
    });
  }

  void stopRun() {
    _timer?.cancel(); // Stop the timer

    setState(() {
      currentState = RunState.after;
      buttonText = "Klar!";
      activeRun = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(
                decelerationRate: ScrollDecelerationRate.fast),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMap(context),
                buildContentBasedOnState(user),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDuringRunContent() {
    return Container(
      decoration: AppDecoration.roundedBoxNoOutline.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Column(
        children: [
          SizedBox(height: 20.v),
          Padding(
            padding: EdgeInsets.only(left: 12.h),
            child: Text(
              "Pågående löprunda",
              style: theme.textTheme.headlineSmall,
            ),
          ),
          SizedBox(height: 7.v),
          _buildMetricsList(context),
          SizedBox(height: 6.v),
          Padding(
            padding: EdgeInsets.only(left: 17, right: 17),
            child: _buildButton(User()),
          )
        ],
      ),
    );
  }

  Widget buildBeforeRunContent(User user) {
    return Container(
      decoration: AppDecoration.roundedBoxNoOutline.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Column(
        children: [
          SizedBox(height: 20.v),
          Padding(
            padding: EdgeInsets.only(left: 17, right: 17),
            child: _buildButton(user),
          ),
          SizedBox(height: 10.v),
          Padding(
            padding: EdgeInsets.only(left: 12.h),
            child: Text("Idag",
                style: theme.textTheme.headlineSmall!
                    .copyWith(fontStyle: FontStyle.normal)),
          ),
          Padding(
            padding: EdgeInsets.only(left: 12.h),
            child: Text(
              DateTime.now().toString().substring(0, 10),
              style: theme.textTheme.headlineSmall!
                  .copyWith(fontSize: 15, fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Card(
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
              height: 295.v,
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
                      height: 295.v,
                      width: 330.h,
                      decoration: BoxDecoration(
                        color: appTheme.deepPurple500,
                        borderRadius: BorderRadius.circular(
                          5.h,
                        ),
                      ),
                    ),
                  ),
                  if (w == null) // Kontrollerar om datan laddas
                    Container(
                      height: 295.v,
                      width: 340.h,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  else
                    _buildColumns(context),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          )
        ],
      ),
    );
  }

  Future<void> getWeather() async {
    w = await wf.currentWeatherByLocation(
        currentLocation!.latitude!, currentLocation!.longitude!);
  }

  Widget buildAfterRunContent(User user) {
    return Container(
      decoration: AppDecoration.roundedBoxNoOutline.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Column(
        children: [
          SizedBox(height: 10.v),
          Padding(
            padding: EdgeInsets.only(left: 12.h),
            child: Text(
              "Dagens Löprunda",
              style: theme.textTheme.headlineSmall,
            ),
          ),
          SizedBox(height: 10.v),
          _buildMetricsList(context),
          SizedBox(height: 10.v),
          Padding(
            padding: const EdgeInsets.only(left: 17, right: 17),
            child: _buildInformationCard(
                "Tempo",
                calculatePace(_elapsedTime, totalDistance),
                ImageConstant.imgRunner),
          ),
          SizedBox(height: 10.v),
          Padding(
            padding: const EdgeInsets.only(left: 17, right: 17),
            child: _buildInformationCard(
                "Genomsnitlig Hastighet",
                calculateSpeed(_elapsedTime, totalDistance),
                ImageConstant.imgHatNew),
          ),
          SizedBox(height: 10.v),
          Padding(
            padding: EdgeInsets.only(left: 17, right: 17),
            child: _buildButton(user),
          ),
          SizedBox(height: 10.v),
        ],
      ),
    );
  }

  Widget _buildInformationCard(String label, String value, String imagePath) {
    return Container(
      padding: EdgeInsets.all(3.h),
      decoration: AppDecoration.outlineDeepPurple.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: appTheme.deepPurple500,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0) + EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align text to the left
                  children: [
                    Text(
                      label,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                        height:
                            3.v), // Adjustable spacing between label and value
                    Text(
                      value,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              Image.asset(
                imagePath,
                width: 32.h, // Adjust the size based on your layout needs
                height: 32.v,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String calculateSpeed(Duration time, double distance) {
    double distanceInKilometers = distance / 1000; //convert to kilometers
    double timeInHours = time.inSeconds / 3600.0; //convert to hours
    if (timeInHours == 0) return "0 hm/h";

    double speed = distanceInKilometers / timeInHours;
    return speed.toStringAsFixed(2) + " km/h";
  }

  String calculatePace(Duration time, double distance) {
    double distanceInKilometers =
        distance / 1000; // Convert meters to kilometers
    double timeInMinutes = time.inSeconds / 60.0; // Convert seconds to minutes
    if (distanceInKilometers == 0) return "0 min/km"; // Avoid division by zero

    double minutesPerKilometer = timeInMinutes / distanceInKilometers;
    return minutesPerKilometer.toStringAsFixed(2) + " min/km";
  }

  Widget buildContentBasedOnState(User user) {
    switch (currentState) {
      case RunState.before:
        currentLocation == null ? CircularProgressIndicator() : getWeather();
        return buildBeforeRunContent(user);

      case RunState.during:
        return buildDuringRunContent();

      case RunState.after:
        return buildAfterRunContent(user);
      default:
        return SizedBox.shrink();
    }
  }

  Widget _buildMap(BuildContext context) {
    return Center(
      child: Container(
        height: 400.h,
        width: SizeUtils.width,
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

  Widget _buildButton(User user) {
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
          if (currentState == RunState.during) {
            stopRun();
          } else if (currentState == RunState.after) {
            sendActivity(context, user);
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

  Future<void> sendActivity(BuildContext context, User user) async {
    if (totalDistance == 0) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          GifImage(
            controller: controller1,
            image:
                AssetImage(ImageConstant.imgRunningGuy), // Sökväg till din GIF
          );

          return AlertDialog(
            backgroundColor: Color.fromARGB(255, 217, 238, 248),
            title: Row(
              children: [
                Icon(
                  Icons.warning,
                  color: Color.fromARGB(255, 158, 14, 4),
                ),
                SizedBox(width: 10),
                Text(
                  "Distance är noll",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Prova att röra på dig för att registrera en löprunda.",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 10),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    final response =
        await network.postActivity(user.email, totalDistance, _elapsedTime);

    if (response.statusCode == 200) {
      print("Response: " + response.body);
      if (response.body.contains("id")) {
        Navigator.pushNamed(context, AppRoutes.homeScreen);
      } else {}
    } else {}
  }

  Widget _buildColumns(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 1.h),
      padding: EdgeInsets.symmetric(
        horizontal: 10.h,
        vertical: 13.v,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 4.v),
          Padding(
            padding: EdgeInsets.only(
              left: 3.h,
              right: 10.h,
            ),
            child: w == null
                ? Center(child: CircularProgressIndicator())
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgCloud,
                        height: 51.v,
                        width: 69.h,
                        margin: EdgeInsets.only(bottom: 9.v),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 11.h),
                          child: buildWeatherInfoOrLoading(
                            (weather) => Text(
                              "${weather.temperature!.celsius!.toStringAsFixed(0)}",
                              style: theme.textTheme.displayMedium,
                            ),
                          )),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 6.v,
                          bottom: 17.v,
                        ),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "°",
                                style: CustomTextStyles.titleMediumWhiteA700,
                              ),
                              TextSpan(
                                text: "C",
                                style: CustomTextStyles.titleMediumWhiteA700,
                              )
                            ],
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 26.h,
                          top: 8.v,
                          bottom: 8.v,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildWeatherInfoOrLoading(
                              (weather) => Text(
                                "${weather.weatherDescription!.capitalize()}",
                                style: CustomTextStyles.titleLargePassionOne
                                    .copyWith(color: appTheme.whiteA700),
                              ),
                            ),
                            buildWeatherInfoOrLoading(
                              (weather) => Text(
                                "Känns som ${weather.tempFeelsLike!.celsius!.toStringAsFixed(0)}°",
                                style: CustomTextStyles.titleSmallWhiteA70014,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
          ),
          SizedBox(height: 18.v),
          Divider(
            indent: 1.h,
            color: Colors.white.withOpacity(0.80),
          ),
          SizedBox(height: 10.v),
          Padding(
              padding: EdgeInsets.only(
                left: 1.h,
                right: 55.h,
              ),
              child: w == null
                  ? Visibility(
                      child: Text("Gone"),
                      visible: false,
                    )
                  : _buildColumn(
                      context,
                      upperText: "Nederbörd",
                      lowerText: calculateRainfall(),
                      upperText2: "Luftfuktighet",
                      lowerText2: w!.humidity.toString(),
                      imagePath: ImageConstant.imgUmbrella,
                    )),
          SizedBox(height: 9.v),
          Divider(
            indent: 1.h,
            color: Colors.white.withOpacity(0.80),
          ),
          SizedBox(height: 10.v),
          Padding(
            padding: EdgeInsets.only(
              left: 1.h,
              right: 60.h,
            ),
            child: w == null
                ? Visibility(
                    child: Text("Gone"),
                    visible: false,
                  )
                : _buildColumn(
                    context,
                    upperText: "Soluppgång",
                    lowerText: w!.sunrise!.toString().substring(10, 16),
                    upperText2: "Solnedgång",
                    lowerText2: w!.sunset!.toString().substring(10, 16),
                    imagePath: ImageConstant.imgSun,
                  ),
          ),
          SizedBox(height: 11.v),
          Divider(
            indent: 1.h,
            color: Colors.white.withOpacity(0.80),
          ),
          SizedBox(height: 10.v),
          Padding(
              padding: EdgeInsets.only(
                left: 1.h,
                right: 72.h,
              ),
              child: w == null
                  ? Visibility(
                      child: Text("Gone"),
                      visible: false,
                    )
                  : _buildColumn(
                      context,
                      upperText: "Vind",
                      lowerText: calculateWind() + " m/s",
                      upperText2: "Lufttryck",
                      lowerText2: w!.pressure.toString(),
                      imagePath: ImageConstant.imgWind,
                    )),
          SizedBox(height: 10.v),
          Divider(
            indent: 1.h,
            color: Colors.white.withOpacity(0.80),
          )
        ],
      ),
    );
  }

  String calculateRainfall() {
    if (w!.rainLast3Hours.toString() != "null")
      return w!.rainLast3Hours.toString();
    else
      return "Inget regn";
  }

  String calculateWind() {
    if (w!.windSpeed.toString() != "null")
      return w!.windSpeed.toString();
    else
      return "Ingen vind";
  }

  Widget buildWeatherInfoOrLoading(Widget Function(Weather) buildContent) {
    if (w == null) {
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20.h),
            SizedBox(
              child: Center(child: CircularProgressIndicator()),
              height: 5.0,
              width: 5.0,
            ),
          ],
        ),
      );
    } else {
      return buildContent(w!);
    }
  }

  Widget _buildColumn(BuildContext context,
      {required String upperText,
      required String lowerText,
      required String upperText2,
      required String lowerText2,
      required String imagePath}) {
    return Row(
      children: [
        CustomImageView(
          imagePath: imagePath,
          height: 24.adaptSize,
          width: 24.adaptSize,
          margin: EdgeInsets.only(bottom: 9.v),
        ),
        Padding(
          padding: EdgeInsets.only(left: 22.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(upperText, style: CustomTextStyles.titleSmallWhiteA700),
              SizedBox(height: 3.v),
              Text(
                lowerText,
                style: CustomTextStyles.titleMediumWhiteA700,
              )
            ],
          ),
        ),
        Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              upperText2,
              style: CustomTextStyles.titleSmallWhiteA700,
            ),
            SizedBox(height: 3.v),
            Text(
              lowerText2,
              style: CustomTextStyles.titleMediumWhiteA700,
            )
          ],
        )
      ],
    );
  }
}

enum RunState { before, during, after }
