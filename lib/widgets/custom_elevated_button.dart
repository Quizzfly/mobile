import 'package:flutter/material.dart';
import '../core/app_export.dart';
import 'base_button.dart';

class CustomElevatedButton extends BaseButton {
  const CustomElevatedButton(
      {super.key,
      this.decoration,
      this.leftIcon,
      this.rightIcon,
      this.gradientColors,
      this.borderColors,
      this.gradientBegin = Alignment.centerLeft,
      this.gradientEnd = Alignment.centerRight,
      this.borderWidth = 1.0,
      super.margin,
      super.onPressed,
      super.buttonStyle,
      super.alignment,
      super.buttonTextStyle,
      super.isDisabled,
      super.height,
      super.width,
      required super.text});

  final BoxDecoration? decoration;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final List<Color>? gradientColors;
  final List<Color>? borderColors;
  final Alignment gradientBegin;
  final Alignment gradientEnd;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: buildElevatedButtonWidget)
        : buildElevatedButtonWidget;
  }

  Widget get buildElevatedButtonWidget {
    final gradientDecoration = gradientColors != null
        ? BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors!,
              begin: gradientBegin,
              end: gradientEnd,
            ),
            borderRadius: BorderRadius.circular(20),
          )
        : decoration;

    final buttonContent = ElevatedButton(
      style: buttonStyle ??
          ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
      onPressed: isDisabled ?? false ? null : onPressed ?? () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          leftIcon ?? const SizedBox.shrink(),
          Text(
            text,
            style:
                buttonTextStyle ?? CustomTextStyles.titleSmallOnErrorContainer,
          ),
          rightIcon ?? const SizedBox.shrink()
        ],
      ),
    );

    if (borderColors == null) {
      return Container(
        height: height ?? 30.h,
        width: width ?? double.maxFinite,
        margin: margin,
        decoration: gradientDecoration,
        child: buttonContent,
      );
    }
    return Container(
      height: height ?? 30.h,
      width: width ?? double.maxFinite,
      margin: margin,
      child: CustomPaint(
        painter: GradientBorderPainter(
          borderColors: borderColors!,
          borderWidth: borderWidth,
          borderRadius: 20,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: buttonContent,
        ),
      ),
    );
  }
}

class GradientBorderPainter extends CustomPainter {
  final List<Color> borderColors;
  final double borderWidth;
  final double borderRadius;

  GradientBorderPainter({
    required this.borderColors,
    required this.borderWidth,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final borderPaint = Paint()
      ..shader = LinearGradient(
        colors: borderColors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final roundedRectPath = Path()
      ..addRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(borderWidth / 2, borderWidth / 2,
              size.width - borderWidth, size.height - borderWidth),
          Radius.circular(borderRadius)));

    canvas.drawPath(roundedRectPath, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
