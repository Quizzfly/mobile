import 'package:flutter/material.dart';
import '../core/app_export.dart';

LightCodeColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();

/// Helper class for managing themes and Colors.
// ignore_for_file: must_be_immutable
class ThemeHelper {
// The current app theme
  var _appTheme = PrefUtils().getThemeData();
// A map of custom Color themes supported by the app
  Map<String, LightCodeColors> _supportedCustomColor = {
    'lightCode': LightCodeColors()
  };
// A map of Color schemes supported by the app
  Map<String, ColorScheme> _supportedColorScheme = {
    'lightCode': ColorSchemes.lightCodeColorScheme
  };

  /// Returns the lightCode Colors for the current theme.
  LightCodeColors _getThemeColors() {
    return _supportedCustomColor[_appTheme] ?? LightCodeColors();
  }

//Returns the current theme data
  ThemeData _getThemeData() {
    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.lightCodeColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      textTheme: TextThemes.textTheme(colorScheme),
      scaffoldBackgroundColor: colorScheme.primary,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: appTheme.deepPurple300,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: colorScheme.onError,
          side: BorderSide(
            color: appTheme.deepPurple300,
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
      ),
      dividerTheme: DividerThemeData(
        thickness: 1,
        space: 1,
        color: appTheme.whiteA700.withOpacity(0.3),
      ),
    );
  }

  /// Returns the lightCode Colors for the current theme.
  LightCodeColors themeColor() => _getThemeColors();

  /// Returns the current theme data.
  ThemeData themeData() => _getThemeData();
}

/// class containing the supported text theme styles.
class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
        bodyLarge: TextStyle(
          color: appTheme.whiteA700,
          fontSize: 16.fSize,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          color: appTheme.blueGray400,
          fontSize: 14.fSize,
          fontFamily: 'Rubik',
          fontWeight: FontWeight.w400,
        ),
        bodySmall: TextStyle(
          color: appTheme.blueGray400,
          fontSize: 12.fSize,
          fontFamily: 'Rubik',
          fontWeight: FontWeight.w400,
        ),
        displayLarge: TextStyle(
          color: appTheme.whiteA700,
          fontSize: 60.fSize,
          fontFamily: 'Graphik',
          fontWeight: FontWeight.w600,
        ),
        headlineLarge: TextStyle(
          color: appTheme.whiteA700,
          fontSize: 32.fSize,
          fontFamily: 'Rubik',
          fontWeight: FontWeight.w700,
        ),
        headlineSmall: TextStyle(
          color: appTheme.whiteA700,
          fontSize: 24.fSize,
          fontFamily: 'Graphik',
          fontWeight: FontWeight.w500,
        ),
        labelLarge: TextStyle(
          color: appTheme.blueGray400,
          fontSize: 12.fSize,
          fontFamily: 'Rubik',
          fontWeight: FontWeight.w500,
        ),
        titleLarge: TextStyle(
          color: colorScheme.onPrimary.withOpacity(1),
          fontSize: 20.fSize,
          fontFamily: 'Rubik',
          fontWeight: FontWeight.w500,
        ),
        titleMedium: TextStyle(
          color: colorScheme.onPrimary.withOpacity(1),
          fontSize: 16.fSize,
          fontFamily: 'Rubik',
          fontWeight: FontWeight.w500,
        ),
        titleSmall: TextStyle(
          color: appTheme.whiteA700,
          fontSize: 14.fSize,
          fontFamily: 'Rubik',
          fontWeight: FontWeight.w500,
        ),
      );
}

/// class containing the supported Color schemes.
class ColorSchemes {
  static final lightCodeColorScheme = ColorScheme.light(
    primary: Color(0XFF6A5AE0),
    primaryContainer: Color(0X7F181254),
    secondaryContainer: Color(0XFFEA4335),
    errorContainer: Color(0XFF313957),
    onError: Color(0XFF5B4EC3),
    onErrorContainer: Color(0XFF060101),
    onPrimary: Color(0X7F0B082A),
    onPrimaryContainer: Color(0XFFBF83FF),
  );
}

/// Class containing custom Colors for a lightCode theme.
class LightCodeColors {
// Amber
  Color get amber300 => Color(0XFFFFD54B);
  Color get amberA200 => Color(0XFFFFC83D);
// Blue
  Color get blue100 => Color(0XFFC4D0FB);
  Color get blue200 => Color(0XFF8FC9FF);
  Color get blue300 => Color(0XFF6BB8FF);
  Color get blue900 => Color(0XFF013399);
//BlueGray
  Color get blueGray100 => Color(0XFFCFDFE2);
  Color get blueGray10001 => Color(0XFFCCCCCC);
  Color get blueGray10002 => Color(0XFFD4D7E3);
  Color get blueGray300 => Color(0XFF959CB5);
  Color get blueGray30001 => Color(0XFF8796AD);
  Color get blueGray400 => Color(0XFF858494);
  Color get blueGray500 => Color(0XFF726E96);
  Color get blueGray800 => Color(0XFF294956);
  Color get blueGray900 => Color(0XFF112830);
// Cyan
  Color get cyan200 => Color(0XFF83E6D0);
// DeepOrange
  Color get deepOrange200 => Color(0XFFFFB37F);
  Color get deepOrange20001 => Color(0XFFF6B191);
  Color get deepOrange300 => Color(0XFFFF9A56);
//DeepPurple
  Color get deepPurple100 => Color(0XFFCDC9F3);
  Color get deepPurple10001 => Color(0XFFD9D4F6);
  Color get deepPurple200 => Color(0XFFB9B4E4);
  Color get deepPurple300 => Color(0XFF9087E5);
  Color get deepPurple50 => Color(0XFFEFEDFB);
  Color get deepPurple600 => Color(0XFF5144B6);
// Gray
  Color get gray100 => Color(0XFFFCF2F2);
  Color get gray10001 => Color(0XFFF2F6FA);
  Color get gray10002 => Color(0XFFF3F9FA);
  Color get gray200 => Color(0XFFECEBE7);
  Color get gray300 => Color(0XFFE6E6E6);
  Color get gray30001 => Color(0XFFE1E1E2);
  Color get gray400 => Color(0XFFB5B5B5);
  Color get gray50 => Color(0XFFF2F9FC);
  Color get gray500 => Color(0XFF9E9E9E);
  Color get gray5001 => Color(0XFFFCFBF2);
  Color get gray5002 => Color(0XFFF7FBFF);
  Color get gray5003 => Color(0XFFF2FCFB);
  Color get gray900 => Color(0XFF001833);
  Color get gray90001 => Color(0XFF2B1B17);
  Color get gray90002 => Color(0XFF24272D);
  Color get gray90003 => Color(0XFF0B1420);
// Green
  Color get greenA200 => Color(0XFF5DDEC2);
// Indigo
  Color get indigo200 => Color(0XFFA9ADF3);
  Color get indigo50 => Color(0XFFE7E5FA);
  Color get indigo700 => Color(0XFF2E42A4);
// LightGreen
  Color get lightGreen700 => Color(0XFF5DA922);
  Color get lightGreen900 => Color(0XFF2E8D00);
//Orange
  Color get orangeA100 => Color(0XFFFFD56B);
//Pink
  Color get pink100 => Color(0XFFFFC2CC);
  Color get pink10001 => Color(0XFFFFB2BF);
  Color get pink10002 => Color(0XFFFFCCC);
  Color get pink300 => Color(0XFFFF6B84);
  Color get pink900 => Color(0XFF660011);
  Color get pinkA100 => Color(0XFFFF8FA2);
// Red
  Color get red100 => Color(0XFFFFD6DD);
  Color get red10001 => Color(0XFFFFCBD6);
  Color get red10002 => Color(0XFFFFCBD4);
  Color get red700 => Color(0XFFE31D1C);
  Color get red900 => Color(0XFFC41918);
  Color get redA700 => Color(0XFFEF0000);
  Color get redA70001 => Color(0XFFF50100);
// Teal
  Color get tea150 => Color(0XFFC9F2E9);
// White
  Color get whiteA700 => Color(0XFFFFFFFF);
// Yellow
  Color get yellowA400 => Color(0XFFF9E813);
}
