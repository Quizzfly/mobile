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
  static ButtonStyle get fillDeepPurple50TL12 => ElevatedButton.styleFrom(
        backgroundColor: appTheme.deepPurple50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.h),
        ),
        elevation: 0,
        padding: EdgeInsets.zero,
      );
  static ButtonStyle get fillGray => ElevatedButton.styleFrom(
        backgroundColor: appTheme.gray10002.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.h),
        ),
        elevation: 0,
        padding: EdgeInsets.zero,
      );
  static ButtonStyle get fillBlackGray => ElevatedButton.styleFrom(
        backgroundColor: appTheme.gray500.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.h),
        ),
        elevation: 0,
        padding: EdgeInsets.zero,
      );
  static ButtonStyle get fillPrimaryRadius12 => ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.h),
        ),
        elevation: 0,
        padding: EdgeInsets.zero,
      );
  static ButtonStyle get fillErrorRadius5 => ElevatedButton.styleFrom(
        backgroundColor: appTheme.red10001.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.h),
        ),
        elevation: 0,
        padding: EdgeInsets.zero,
      );
  static ButtonStyle get fillErrorRadius20 => ElevatedButton.styleFrom(
        backgroundColor: appTheme.red600,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.h),
        ),
        elevation: 0,
        padding: EdgeInsets.zero,
      );
  static ButtonStyle get fillPrimaryRadius20 => ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.h),
        ),
        elevation: 0,
        padding: EdgeInsets.zero,
      );
  static ButtonStyle get fillWhiteRadius30 => ElevatedButton.styleFrom(
        backgroundColor: appTheme.whiteA700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.h),
        ),
        elevation: 4.h,
        padding: EdgeInsets.zero,
      );
  static ButtonStyle get fillRedRadius20 => ElevatedButton.styleFrom(
        backgroundColor: appTheme.red700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.h),
        ),
        elevation: 0,
        padding: EdgeInsets.zero,
      );
  static ButtonStyle get outlineDeepPurple20 => ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.h),
        ),
        elevation: 0,
        padding: EdgeInsets.zero,
      );
// text button style
  static ButtonStyle get none => ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
      elevation: WidgetStateProperty.all<double>(0),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
      side: WidgetStateProperty.all<BorderSide>(
        const BorderSide(color: Colors.transparent),
      ));
}
