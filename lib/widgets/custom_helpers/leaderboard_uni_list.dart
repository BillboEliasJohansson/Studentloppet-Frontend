import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

import 'package:studentloppet/theme/app_decoration.dart';
import 'package:studentloppet/theme/theme_helper.dart';
import 'package:studentloppet/utils/size_utils.dart';

class UniLeaderboardItemWidget extends StatelessWidget {
  final String uni;
  final String category;
  final List<String> names;
  final List<String> points;
  final List<String> profilePictures;

  UniLeaderboardItemWidget(
      {Key? key,
      required this.uni,
      required this.category,
      required this.names,
      required this.points,
      required this.profilePictures})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        padding: EdgeInsets.all(5.h),
        decoration: AppDecoration.outlinePurple.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder10,
        ),
        width: 330,
        height: 200,
        child: Container(
          width: 330,
          height: 330,
          decoration: BoxDecoration(
            color: appTheme.deepPurple500,
            borderRadius: BorderRadius.circular(
              5.h,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (names.length < 5)
                  Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Text(
                        "Ditt universitet har inte tillräckligt många registerade studenter",
                        style:
                            Theme.of(context).textTheme.displaySmall!.copyWith(
                                  fontSize: 26,
                                )),
                  )
                else ...[
                  Text(
                    uni,
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontSize: 26,
                        ),
                  ),
                  Text(
                    category,
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontSize: 13, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  _buildCardWithIcon(
                      context,
                      Color.fromARGB(255, 243, 142, 230),
                      names[0],
                      points[0],
                      profilePictures[0]),
                  SizedBox(
                    height: 10.h,
                  ),
                  _buildCardWithNumber(context, appTheme.orange, names[1],
                      points[1], "2", profilePictures[1]),
                  SizedBox(
                    height: 10.h,
                  ),
                  _buildCardWithNumber(context, appTheme.purple300, names[2],
                      points[2], "3", profilePictures[2]),
                  SizedBox(
                    height: 10.h,
                  ),
                  _buildCardWithNumber(
                      context,
                      Color.fromARGB(255, 82, 217, 235),
                      names[3],
                      points[3],
                      "4",
                      profilePictures[3]),
                  SizedBox(
                    height: 10.h,
                  ),
                  _buildCardWithNumber(
                      context,
                      Color.fromARGB(255, 212, 93, 163),
                      names[4],
                      points[4],
                      "5",
                      profilePictures[4]),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardWithIcon(BuildContext context, Color color, String name,
      String points, String base64Image) {
    Uint8List imageBytes = base64Decode(base64Image);
    return Container(
      height: 45.h,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(
          10.h,
        ),
      ),
      child: Row(children: [
        SizedBox(
          width: 10,
        ),
        Container(
            child: Icon(
          Icons.emoji_events_outlined,
          color: Colors.white,
          size: 40,
        )),
        SizedBox(
          width: 25,
        ),
        Container(
          height: 30.adaptSize,
          width: 30.adaptSize,
          decoration: BoxDecoration(
            color: appTheme.black900.withOpacity(0.00),
            borderRadius: BorderRadius.circular(30.h),
            image: base64Image.isEmpty
                ? null
                : DecorationImage(
                    image: MemoryImage(imageBytes),
                    fit: BoxFit.contain,
                  ),
          ),
          child: base64Image.isEmpty
              ? Icon(Icons.person,
                  size: 30) // Visa en standardikon om ingen bild finns
              : null,
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          child: Text(
            name,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontSize: 12,
                ),
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            points,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontSize: 26,
                ),
          ),
        ),
      ]),
    );
  }

  Widget _buildCardWithNumber(BuildContext context, Color color, String name,
      String points, String number, String base64Image) {
    Uint8List imageBytes = base64Decode(base64Image);
    return Container(
      height: 45.h,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(
          10.h,
        ),
      ),
      child: Row(children: [
        SizedBox(
          width: 23,
        ),
        Container(
            child: Text(
          number,
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                fontSize: 26,
              ),
        )),
        SizedBox(
          width: 40,
        ),
        Container(
          height: 30.adaptSize,
          width: 30.adaptSize,
          decoration: BoxDecoration(
              color: appTheme.black900.withOpacity(0.00),
              borderRadius: BorderRadius.circular(30.h),
              image: DecorationImage(
                image: MemoryImage(imageBytes),
                fit: BoxFit.contain,
              )),
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          child: Text(
            name,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontSize: 12,
                ),
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            points,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontSize: 26,
                ),
          ),
        )
      ]),
    );
  }
}
