// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:studentloppet/theme/theme_helper.dart';
import 'package:studentloppet/utils/size_utils.dart';

extension on TextStyle {
  TextStyle get sansationLight {
    return copyWith(
      fontFamily: 'Sansation Light',
    );
  }

  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }

  TextStyle get robotoFlex {
    return copyWith(
      fontFamily: 'Roboto Flex',
    );
  }

  TextStyle get passionOne {
    return copyWith(
      fontFamily: 'Passion One',
    );
  }

  TextStyle get openSans {
    return copyWith(
      fontFamily: 'Open Sans',
    );
  }
}

class CustomTextStyles {
  static get bodyMediumPrimary => theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.primary,
      );
  static get bodySmall10 => theme.textTheme.bodySmall!.copyWith(
        fontSize: 10.fSize,
      );
  static get bodySmallPrimary => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.primary.withOpacity(0.5),
      );
  static get titleLargeGray600 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.gray600,
      );
  static get titleMedium16 => theme.textTheme.titleMedium!.copyWith(
        fontSize: 16.fSize,
      );
  static get titleMediumWhiteA700 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.whiteA700,
        fontSize: 16.fSize,
      );
  static get titleLargeSansationLight =>
      theme.textTheme.titleLarge!.sansationLight
          .copyWith(fontWeight: FontWeight.w300, color: Colors.white);

  static get bodySmallBlack900 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.black900.withOpacity(0.5),
        fontSize: 11.fSize,
      );
  static get bodySmallBlack900_1 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.black900.withOpacity(0.63),
      );
  static get smallTextWhite => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.whiteA700,
        fontSize: 13.fSize,
      );
  static get smallTextWhiteUnderlined => theme.textTheme.bodyLarge!.copyWith(
      color: appTheme.whiteA700,
      fontSize: 13.fSize,
      decoration: TextDecoration.underline);

  static get titleLargePassionOne =>
      theme.textTheme.titleLarge!.passionOne.copyWith(
        fontWeight: FontWeight.w300,
      );
}
