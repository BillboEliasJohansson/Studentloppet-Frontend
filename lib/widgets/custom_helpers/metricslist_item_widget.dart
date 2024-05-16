import 'package:flutter/material.dart';
import 'package:studentloppet/theme/app_decoration.dart';
import 'package:studentloppet/theme/theme_helper.dart';
import 'package:studentloppet/utils/size_utils.dart';

class MetricslistItemWidget extends StatelessWidget {
  final String upperText;
  final String lowerText;

  const MetricslistItemWidget({
    Key? key,
    required this.upperText,
    required this.lowerText,
  }) : super(key: key);

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
        width: 160.h,
        child: Container(
          width: 160.h,
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
                  upperText,
                  style: theme.textTheme.labelSmall!.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal),
                ),
                SizedBox(height: 2.v),
                Text(
                  lowerText,
                  style: theme.textTheme.displayMedium!.copyWith(fontSize: 25),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
