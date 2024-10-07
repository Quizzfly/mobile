import 'package:flutter/material.dart';
import '../core/app_export.dart';

class AppDecoration {
// color decorations
  static BoxDecoration get colorPrimary => BoxDecoration(
        color: theme.colorScheme.primary,
      );
  static BoxDecoration get colorSecondary => BoxDecoration(
        color: appTheme.deepPurple300,
      );
  // Fill decorations
  static BoxDecoration get fillAmber => BoxDecoration(
        color: appTheme.amber300,
      );
  static BoxDecoration get fillDeepOrange => BoxDecoration(
        color: appTheme.deepOrange200,
      );
  static BoxDecoration get fillDeeporange20001 => BoxDecoration(
        color: appTheme.deepOrange20001,
      );
  static BoxDecoration get fillGray => BoxDecoration(
        color: appTheme.gray30001,
      );
  static BoxDecoration get fillIndigo => BoxDecoration(
        color: appTheme.indigo50,
      );
  static BoxDecoration get fillonPrimaryContainer => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer,
      );
  static BoxDecoration get fillPink => BoxDecoration(
        color: appTheme.pink10001,
      );
  static BoxDecoration get fillRed => BoxDecoration(
        color: appTheme.red10002,
      );
  static BoxDecoration get fillwhiteA => BoxDecoration(
        color: appTheme.whiteA700,
      );
  // Neutral decorations
  static BoxDecoration get neutralBlack => BoxDecoration(
        color: theme.colorScheme.onPrimary,
      );
  static BoxDecoration get neutralwhite => BoxDecoration(
        color: appTheme.whiteA700,
        border: Border.all(
          color: appTheme.deepPurple50,
          width: 2.h,
        ),
      );
  // Outline decorations
  static BoxDecoration get outlineGray => BoxDecoration(
        border: Border.all(
          color: appTheme.gray300,
          width: 1.5.h,
        ),
      );
}

class BorderRadiusStyle {
  // Circle borders
  static BorderRadius get circleBorder12 => BorderRadius.circular(
        12.h,
      );
  static BorderRadius get circleBorder24 => BorderRadius.circular(
        24.h,
      );
  static BorderRadius get circleBorder48 => BorderRadius.circular(
        48.h,
      );
  // Custom borders
  static BorderRadius get customBorderTL32 => BorderRadius.vertical(
        top: Radius.circular(32.h),
      );
  // Rounded borders
  static BorderRadius get roundedBorder20 => BorderRadius.circular(
        20.h,
      );
  static BorderRadius get roundedBorder4 => BorderRadius.circular(
        4.h,
      );
  static BorderRadius get roundedBorder5 => BorderRadius.circular(
    5.h,
  );
}
