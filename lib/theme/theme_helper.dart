// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:studentloppet/utils/size_utils.dart';

String _appTheme = "primary";
PrimaryColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();

class ThemeHelper {
  // A map of custom color themes supported by the app
  final Map<String, PrimaryColors> _supportedCustomColor = {
    'primary': PrimaryColors()
  };

// A map of color schemes supported by the app
  final Map<String, ColorScheme> _supportedColorScheme = {
    'primary': ColorSchemes.primaryColorScheme
  };

  /// Changes the app theme to [_newTheme].
  void changeTheme(String _newTheme) {
    _appTheme = _newTheme;
  }

  /// Returns the primary colors for the current theme.
  PrimaryColors _getThemeColors() {
    return _supportedCustomColor[_appTheme] ?? PrimaryColors();
  }

  /// Returns the current theme data.
  ThemeData _getThemeData() {
    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.primaryColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      textTheme: TextThemes.textTheme(colorScheme),
      scaffoldBackgroundColor: appTheme.whiteA700,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          side: BorderSide(
            color: colorScheme.primary,
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.onPrimaryContainer,
      ),
      dividerTheme: DividerThemeData(
        thickness: 1,
        space: 1,
        color: colorScheme.onPrimary,
      ),
    );
  }

  /// Returns the primary colors for the current theme.
  PrimaryColors themeColor() => _getThemeColors();

  /// Returns the current theme data.
  ThemeData themeData() => _getThemeData();
}

/// Class containing the supported text theme styles.
class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
        bodyMedium: TextStyle(
          color: colorScheme.primary.withOpacity(0.5),
          fontSize: 14.fSize,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
        ),
        bodySmall: TextStyle(
          color: colorScheme.primary,
          fontSize: 12.fSize,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
        ),
        labelLarge: TextStyle(
          color: appTheme.gray600,
          fontSize: 12.fSize,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
        ),
        titleLarge: TextStyle(
          color: colorScheme.primary,
          fontSize: 20.fSize,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
        ),
        titleMedium: TextStyle(
          color: colorScheme.primary,
          fontSize: 18.fSize,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
        ),
        titleSmall: TextStyle(
          color: colorScheme.primary,
          fontSize: 14.fSize,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
        ),
      );
}

/// Class containing the supported color schemes.
class ColorSchemes {
  static const primaryColorScheme = ColorScheme.light(
    primary: Color(0XFF000000),
    onPrimary: Color(0X19000000),
    onPrimaryContainer: Color(0X0C000000),
  );
}

/// Class containing custom colors for a primary theme.
class PrimaryColors {
  // BlueGray
  Color get blueGray400 => const Color(0XFF888888);
// Gray
  Color get gray600 => const Color(0XFF787676);
// White
  Color get whiteA700 => const Color(0XFFFFFFFF);
}
