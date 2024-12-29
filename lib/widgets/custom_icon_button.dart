import 'package:flutter/material.dart';
import 'package:quizzfly_application_flutter/core/app_export.dart';

extension IconButtonStyleHelper on CustomIconButton {
  static BoxDecoration get none => const BoxDecoration();
  static BoxDecoration get fillTeal => BoxDecoration(
        color: appTheme.tea150,
        borderRadius: BorderRadius.circular(28.h),
      );
}

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {super.key,
      this.alignment,
      this.height,
      this.width,
      this.decoration,
      this.padding,
      this.onTap,
      this.child});
  final Alignment? alignment;
  final double? height;
  final double? width;
  final BoxDecoration? decoration;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center, child: iconButtonWidget)
        : iconButtonWidget;
  }

  Widget get iconButtonWidget => SizedBox(
        height: height ?? 0,
        width: width ?? 0,
        child: DecoratedBox(
          decoration: decoration ?? const BoxDecoration(),
          child: IconButton(
            padding: padding ?? EdgeInsets.zero,
            onPressed: onTap,
            icon: child ?? Container(),
          ),
        ),
      );
}
