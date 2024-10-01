import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A class that offers pre-defined button styles for customizing button appearance.
class CustomButtonStyles {
// Filled button style
  static ButtonStyle get fillDeepOrange => ElevatedButton.styleFrom(
        backgroundColor: appTheme.deepOrange300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.h),
        ),
        elevation: 0,
        padding: EdgeInsets.zero,
      );
  static ButtonStyle get fillDeepPurpleTL12 => ElevatedButton.styleFrom(
        backgroundColor: appTheme.deepPurple600,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.h),
        ),
        elevation: 0,
        padding: EdgeInsets.zero,
      );
  static ButtonStyle get fillGray => ElevatedButton.styleFrom(
        backgroundColor: appTheme.gray10002,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.h),
        ),
        elevation: 0,
        padding: EdgeInsets.zero,
      );
  static ButtonStyle get fillPrimary => ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.h),
        ),
        elevation: 0,
        padding: EdgeInsets.zero,
      );
  static ButtonStyle get fillwhiteA => ElevatedButton.styleFrom(
        backgroundColor: appTheme.whiteA700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.h),
        ),
        elevation: 0,
        padding: EdgeInsets.zero,
      );
// text button style
  static ButtonStyle get none => ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
      elevation: MaterialStateProperty.all<double>(0),
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
      side: MaterialStateProperty.all<BorderSide>(
        BorderSide(color: Colors.transparent),
      ));
}
