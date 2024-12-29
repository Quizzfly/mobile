import 'package:flutter/material.dart';
import 'base_button.dart';

// ignore: must_be_immutable
class CustomOutlinedButton extends BaseButton {
  CustomOutlinedButton(
      {super.key,
      this.decoration,
      this.leftIcon,
      this.rightIcon,
      this.label,
      this.borderColor,
      super.onPressed,
      super.buttonStyle,
      super.buttonTextStyle,
      super.isDisabled,
      super.alignment,
      super.height,
      super.width,
      super.margin,
      super.radius,
      required super.text});
  BoxDecoration? decoration;
  Widget? leftIcon;
  Widget? rightIcon;
  Widget? label;
  Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: buildOutlinedButtonWidget)
        : buildOutlinedButtonWidget;
  }

  Widget get buildOutlinedButtonWidget => Container(
        height: height ?? 30,
        width: width ?? double.maxFinite,
        margin: margin,
        decoration: decoration,
        child: OutlinedButton(
          style: buttonStyle ??
              OutlinedButton.styleFrom(
                side: BorderSide(
                  color: borderColor ?? Colors.white,
                  width: 1.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius ?? 0),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              ),
          onPressed: isDisabled ?? false ? null : onPressed ?? () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              leftIcon ?? const SizedBox.shrink(),
              Expanded(
                child: Text(
                  text,
                  style: buttonTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              rightIcon ?? const SizedBox.shrink()
            ],
          ),
        ),
      );
}
