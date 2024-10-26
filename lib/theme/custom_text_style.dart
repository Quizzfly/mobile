import 'package:flutter/material.dart';
import '../core/app_export.dart';

extension on TextStyle {
  TextStyle get roboto {
    return copyWith(
      fontFamily: 'Roboto',
    );
  }

  TextStyle get rubik {
    return copyWith(
      fontFamily: 'Rubik',
    );
  }

  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }

  TextStyle get plusJakartaSans {
    return copyWith(
      fontFamily: 'Plus Jakarta Sans',
    );
  }

  TextStyle get sFProDisplay {
    return copyWith(
      fontFamily: 'SF Pro Display',
    );
  }

  TextStyle get graphik {
    return copyWith(
      fontFamily: 'Graphik',
    );
  }

  TextStyle get sFProRounded {
    return copyWith(
      fontFamily: 'SF Pro Rounded',
    );
  }
}

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific
class CustomTextStyles {
  // Body text style
  static get bodyLargeBluegray900 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.blueGray900,
      );
  static get bodyLargeErrorContainer => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.errorContainer,
      );
  static get bodyLargeErrorContainer_1 => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.errorContainer,
      );
  static get bodyMediumErrorContainer => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.red700,
      );
  static get bodyMediumBlack900_1 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.black900,
      );
  static get bodyLargePrimary => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.deppPurplePrimary,
      );
  static get bodyLargeRubikDeeppurple200 =>
      theme.textTheme.bodyLarge!.rubik.copyWith(
        color: appTheme.deepPurple200,
      );
  static get bodyLargeRubikGray300 => theme.textTheme.bodyLarge!.rubik.copyWith(
        color: appTheme.gray300,
      );
  static get bodyMediumGraphik => theme.textTheme.bodyMedium!.graphik;
  static get bodyMediumRobotoWhiteA700 =>
      theme.textTheme.bodyMedium!.roboto.copyWith(
        color: appTheme.whiteA700,
      );
  static get bodyMediumOnPrimary => theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(1),
      );
  static get bodyMediumOnPrimary_1 => theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.onPrimary,
      );
  static get bodyMediumRobotoBluegray300 =>
      theme.textTheme.bodyMedium!.roboto.copyWith(
        color: appTheme.blueGray300,
      );
  static get bodyMediumRobotoBluegray30001 =>
      theme.textTheme.bodyMedium!.roboto.copyWith(
        color: appTheme.blueGray30001,
      );
  static get bodyMediumRobotoBluegray800 =>
      theme.textTheme.bodyMedium!.roboto.copyWith(
        color: appTheme.blueGray800,
      );
  static get bodyMediumRobotoFontGray90003 =>
      theme.textTheme.bodyMedium!.roboto.copyWith(
        color: appTheme.gray90003,
        fontWeight: FontWeight.w600,
      );
  static get bodyMediumRobotoGray90003 =>
      theme.textTheme.bodyMedium!.roboto.copyWith(
        color: appTheme.gray90003,
      );
  static get bodySmallGray90001 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray90003,
      );
  static get bodyMediumRobotoPrimary =>
      theme.textTheme.bodyMedium!.roboto.copyWith(
        color: appTheme.deppPurplePrimary,
      );
  static get bodyMediumSFProDisplayErrorContainer =>
      theme.textTheme.bodyMedium!.sFProDisplay.copyWith(
        color: theme.colorScheme.errorContainer,
        fontSize: 15.fSize,
      );
  static get bodyMediumWhiteA700 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.whiteA700,
      );
  static get bodySmallWhiteA700 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.whiteA700.withOpacity(0.7),
      );
// Graphik text style
  static get graphikwhiteA700 => TextStyle(
        color: appTheme.whiteA700,
        fontSize: 100.fSize,
        fontWeight: FontWeight.w600,
      ).graphik;
  static get graphikwhiteA700SemiBold => TextStyle(
        color: appTheme.whiteA700,
        fontSize: 80.fSize,
        fontWeight: FontWeight.w600,
      ).graphik;
// Headline text style
  static get headlineLargeOnPrimary => theme.textTheme.headlineLarge!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(1),
      );
  static get headlineLargeOnPrimary_1 =>
      theme.textTheme.headlineLarge!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(1),
      );
  static get headlineSmallRobotoGray90003 =>
      theme.textTheme.headlineSmall!.roboto.copyWith(
        color: appTheme.gray90003,
        fontWeight: FontWeight.w400,
      );



  static get headlineSmallRobotoBlueGray10001 =>
      theme.textTheme.headlineSmall!.roboto.copyWith(
        color: appTheme.blueGray10001,
        fontWeight: FontWeight.w800,
      );
  static get headlineSmallRubik => theme.textTheme.headlineSmall!.rubik;
  static get headlineSmallRubikOnPrimary =>
      theme.textTheme.headlineSmall!.rubik.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(1),
      );
  static get headlineSmallSFProRoundedGray90003 =>
      theme.textTheme.headlineSmall!.sFProRounded.copyWith(
        color: appTheme.gray90003,
        fontWeight: FontWeight.w600,
      );
  static get headlineSmallSFProRoundedGray90003Regular =>
      theme.textTheme.headlineSmall!.sFProRounded.copyWith(
        color: appTheme.gray90003,
        fontWeight: FontWeight.w400,
      );
// Label text style
  static get labelLargeGray300 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.gray300,
      );
  static get labelLargeOnPrimary => theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(1),
      );
  static get labelMediumBlack900 => theme.textTheme.labelMedium!.copyWith(
        color: appTheme.black900.withOpacity(0.5),
        fontSize: 10.h,
      );
  static get labelLargeRed100 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.red100,
      );
  static get labelLargeWhiteA700 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.whiteA700,
      );
  static get labelLargeGray500 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.gray500,
      );

  static get labelSmallRoboto => theme.textTheme.labelSmall!.roboto.copyWith(
        color: appTheme.whiteA700,
      );
  static get labelSmallRobotoGray =>
      theme.textTheme.labelSmall!.roboto.copyWith(
        color: appTheme.gray10002.withOpacity(0.75),
      );
  static get labelSmallRed700 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.red700.withOpacity(0.5),
      );

// Title text style
  static get titleLargePrimary => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.deppPurplePrimary,
      );
  static get titleLargeWhiteA700 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.whiteA700,
      );
  static get titleMediumGraphik => theme.textTheme.titleMedium!.graphik;
  static get titleMediumPink900 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.pink900,
        fontSize: 18.fSize,
      );
  static get titleMediumPrimaryContainer =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.deppPurplePrimary,
      );
  static get titleMediumWhiteA700 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.whiteA700,
      );
  static get titleMediumWhiteA70018 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.whiteA700,
        fontSize: 18.fSize,
      );
  static get titleMediumWhiteA700Bold => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.whiteA700,
        fontWeight: FontWeight.w700,
      );
  static get bodyMediumInterBluegray800 => theme.textTheme.bodyMedium!.inter
      .copyWith(color: appTheme.blueGray800, fontSize: 15.fSize);
  static get titleSmallPink900 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.pink900.withOpacity(0.5),
      );
  static get titleSmallPrimary => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.deppPurplePrimary,
      );
  static get titleSmallPrimaryBold => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.deppPurplePrimary,
        fontWeight: FontWeight.w700,
      );
  static get titleSmallWhiteA700 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.whiteA700.withOpacity(0.8),
        fontSize: 9.h,
      );
  static get titleMediumGray500 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray500,
        fontSize: 9.h,
      );
      static get titleSmallGray500 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray500,
      );
  //Title text
  static get titleSmallOnErrorContainer =>
      theme.textTheme.titleSmall!.roboto.copyWith(
        color: appTheme.whiteA700,
      );
  static get titleSmallRobotoSansBlack900 =>
      theme.textTheme.titleSmall!.roboto.copyWith(
        color: appTheme.black900.withOpacity(0.5),
        fontSize: 12.h
      );
  static get titleMediumRobotoBlack900 =>
      theme.textTheme.titleMedium!.roboto.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w700,
      );
}
