import 'package:flutter/material.dart';
import 'package:studentloppet/theme/app_decoration.dart';
import 'package:studentloppet/theme/theme_helper.dart';
import 'package:studentloppet/utils/size_utils.dart';

class MetricslistItemWidget extends StatelessWidget {
  const MetricslistItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 11.h,
        vertical: 12.v,
      ),
      decoration: AppDecoration.outlineOnPrimary.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder6,
      ),
      width: 150.h,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Placeholder",
            style: theme.textTheme.bodyMedium,
          ),
          SizedBox(height: 7.v),
          Text(
            "Placeholder",
            style: theme.textTheme.titleLarge,
          )
        ],
      ),
    );
  }
}