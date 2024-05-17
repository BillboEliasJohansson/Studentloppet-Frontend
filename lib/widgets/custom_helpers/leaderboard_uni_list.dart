import 'package:flutter/material.dart';
import 'package:studentloppet/Constants/image_constant.dart';
import 'package:studentloppet/theme/app_decoration.dart';
import 'package:studentloppet/theme/theme_helper.dart';
import 'package:studentloppet/utils/size_utils.dart';

class UniLeaderboardItemWidget extends StatelessWidget {
  final String uni;
  final String category;
  final List<String> names;
  final List<String> points;

  UniLeaderboardItemWidget(
      {Key? key,
      required this.uni,
      required this.category,
      required this.names,
      required this.points})
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
                _buildCardWithIcon(context, Color.fromARGB(255, 243, 142, 230),
                    names[0], points[0]),
                SizedBox(
                  height: 10.h,
                ),
                _buildCardWithNumber(
                    context, appTheme.orange, names[1], points[1], "2"),
                SizedBox(
                  height: 10.h,
                ),
                _buildCardWithNumber(
                    context, appTheme.purple300, names[2], points[2], "3"),
                SizedBox(
                  height: 10.h,
                ),
                _buildCardWithNumber(context, Color.fromARGB(255, 82, 217, 235),
                    names[3], points[3], "4"),
                SizedBox(
                  height: 10.h,
                ),
                _buildCardWithNumber(context, Color.fromARGB(255, 212, 93, 163),
                    names[4], points[4], "5"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardWithIcon(
      BuildContext context, Color color, String name, String points) {
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
              image: DecorationImage(
                image: AssetImage(ImageConstant.imgRunningGuy),
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
        ),
      ]),
    );
  }

  Widget _buildCardWithNumber(BuildContext context, Color color, String name,
      String points, String number) {
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
                image: AssetImage(ImageConstant.imgRunningGuy),
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