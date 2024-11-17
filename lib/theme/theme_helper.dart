import 'package:flutter/material.dart';
import '../core/app_export.dart';

LightCodeColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();

/// Helper class for managing themes and Colors.
// ignore_for_file: must_be_immutable
class ThemeHelper {
// The current app theme
  final _appTheme = PrefUtils().getThemeData();
// A map of custom Color themes supported by the app
  final Map<String, LightCodeColors> _supportedCustomColor = {
    'lightCode': LightCodeColors()
  };
// A map of Color schemes supported by the app
  final Map<String, ColorScheme> _supportedColorScheme = {
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
  static const lightCodeColorScheme = ColorScheme.light(
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
//Black
  Color get black900 => const Color(0XFF000000);
// Amber
  Color get amber300 => const Color(0XFFFFD54B);
  Color get amberA200 => const Color(0XFFFFC83D);
// Blue
  Color get blue100 => const Color(0XFFC4D0FB);
  Color get blue200 => const Color(0XFF8FC9FF);
  Color get blue300 => const Color(0XFF6BB8FF);
  Color get blue900 => const Color(0XFF013399);
//BlueGray
  Color get blueGray100 => const Color(0XFFCFDFE2);
  Color get blueGray10001 => const Color(0XFFCCCCCC);
  Color get blueGray10002 => const Color(0XFFD4D7E3);
  Color get blueGray300 => const Color(0XFF959CB5);
  Color get blueGray30001 => const Color(0XFF8796AD);
  Color get blueGray400 => const Color(0XFF858494);
  Color get blueGray500 => const Color(0XFF726E96);
  Color get blueGray800 => const Color(0XFF294956);
  Color get blueGray50 => const Color(0XFFE9EEF4);
  Color get blueGray900 => const Color(0XFF112830);
// Cyan
  Color get cyan200 => const Color(0XFF83E6D0);
// DeepOrange
  Color get deepOrange200 => const Color(0XFFFFB37F);
  Color get deepOrange20001 => const Color(0XFFF6B191);
  Color get deepOrange300 => const Color(0XFFFF9A56);
//DeepPurple
  Color get deepPurple100 => const Color(0XFFCDC9F3);
  Color get deepPurple10001 => const Color(0XFFD9D4F6);
  Color get deepPurple200 => const Color(0XFFB9B4E4);
  Color get deepPurple300 => const Color(0XFF9087E5);
  Color get deepPurple50 => const Color(0XFFEFEDFB);
  Color get deepPurple600 => const Color(0XFF5144B6);
  Color get deppPurplePrimary => const Color(0XFF6A5AE0);
// Gray
  Color get gray100 => const Color(0XFFFCF2F2);
  Color get gray10001 => const Color(0XFFF2F6FA);
  Color get gray10002 => const Color(0XFD4D3D7);
  Color get gray200 => const Color(0XFFECEBE7);
  Color get gray300 => const Color(0XFFE6E6E6);
  Color get gray30001 => const Color(0XFFE1E1E2);
  Color get gray400 => const Color(0XFFB5B5B5);
  Color get gray50 => const Color(0XFFF8FAFC);
  Color get gray500 => const Color(0XFF9E9E9E);
  Color get gray5001 => const Color(0XFFFCFBF2);
  Color get gray5002 => const Color(0XFFF7FBFF);
  Color get gray5003 => const Color(0XFFF2FCFB);
  Color get gray900 => const Color(0XFF001833);
  Color get gray90001 => const Color(0XFF101113);
  Color get gray90002 => const Color(0XFF24272D);
  Color get gray90003 => const Color(0XFF0B1420);
// Green
  Color get greenA200 => const Color(0XFF5DDEC2);
// Indigo
  Color get indigo200 => const Color(0XFFA9ADF3);
  Color get indigo50 => const Color(0XFFE7E5FA);
  Color get indigo700 => const Color(0XFF3789FF);
// LightGreen
  Color get lightGreen700 => const Color(0XFF0FD18D);
  Color get lightGreen900 => const Color(0XFF2E8D00);
//Orange
  Color get orangeA100 => const Color(0XFFFFD56B);
//Pink
  Color get pink100 => const Color(0XFFFFC2CC);
  Color get pink10001 => const Color(0XFFFFB2BF);
  Color get pink10002 => const Color(0XFFFFCCC);
  Color get pink300 => const Color(0XFFFF6B84);
  Color get pink900 => const Color(0XFF660011);
  Color get pinkA100 => const Color(0XFFFF8FA2);
// Red
  Color get red100 => const Color(0XFFFFD6DD);
  Color get red10001 => const Color(0XFFFFCBD6);
  Color get red10002 => const Color(0XFFFFCBD4);
  Color get red600 => const Color(0XFFF65655);
  Color get red700 => const Color(0XFFE31D1C);
  Color get red900 => const Color(0XFFC41918);
  Color get redA700 => const Color(0XFFEF0000);
  Color get redA70001 => const Color(0XFFF50100);
// Teal
  Color get tea150 => const Color(0XFFC9F2E9);
// White
  Color get whiteA700 => const Color(0XFFFFFFFF);
// Yellow
  Color get yellowA400 => const Color(0XFFFE8920);
}
