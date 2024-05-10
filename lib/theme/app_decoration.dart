import 'package:flutter/material.dart';
import 'package:studentloppet/theme/theme_helper.dart';
import 'package:studentloppet/utils/size_utils.dart';

class AppDecoration {
  // Fill decorations
  static BoxDecoration get fillOnPrimaryContainer => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer,
      );
  static BoxDecoration get fillWhiteA => BoxDecoration(
        color: appTheme.whiteA700,
      );

  static BoxDecoration get fillPurple => BoxDecoration(
        color: appTheme.purple200,
      );

  static BoxDecoration get fillPurple300 => BoxDecoration(
        color: appTheme.purple300,
      );

// Outline decorations
  static BoxDecoration get outlineOnPrimary => BoxDecoration(
        border: Border.all(
          color: theme.colorScheme.onPrimary,
          width: 1.h,
        ),
      );
  static BoxDecoration get outlinePrimary => BoxDecoration(
        color: appTheme.whiteA700,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withOpacity(0.12),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: const Offset(
              0,
              0,
            ),
          )
        ],
      );
  static BoxDecoration get outlineOnPrimaryContainer => BoxDecoration(
        border: Border.all(
            color: Colors.black,
            width: 1.h,
            style: BorderStyle.solid,
            strokeAlign: BorderSide.strokeAlignCenter),
      );

  static BoxDecoration get outlineWhite => BoxDecoration(
        border: Border.all(
            color: Colors.white,
            width: 2.h,
            style: BorderStyle.solid,
            strokeAlign: BorderSide.strokeAlignOutside),
      );

  static BoxDecoration get outlineOrange => BoxDecoration(
        border: Border.all(
            color: appTheme.orange,
            width: 2.h,
            style: BorderStyle.solid,
            strokeAlign: BorderSide.strokeAlignOutside),
      );
  static BoxDecoration get outlinePurple => BoxDecoration(
        border: Border.all(
            color: appTheme.purple300,
            width: 2.h,
            style: BorderStyle.solid,
            strokeAlign: BorderSide.strokeAlignOutside),
      );

  static BoxDecoration get outlineDeepPurple => BoxDecoration(
        border: Border.all(
            color: appTheme.deepPurple500,
            width: 2.h,
            style: BorderStyle.solid,
            strokeAlign: BorderSide.strokeAlignOutside),
      );

  static BoxDecoration get roundedBoxNoOutline => BoxDecoration(
        border: Border(
          top: BorderSide(
              color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.1),
              width: 4.h,
              strokeAlign: BorderSide.strokeAlignCenter),
        ),
      );
}

class BorderRadiusStyle {
  // Rounded borders
  static BorderRadius get roundedBorder6 => BorderRadius.circular(
        6.h,
      );

  static BorderRadius get roundedBorder10 => BorderRadius.circular(
        10.h,
      );

  static BorderRadius get roundedBorder11 => BorderRadius.circular(
        10.h,
      );

  static BorderRadius get circleBorder => BorderRadius.circular(
        175.h,
      );
}
