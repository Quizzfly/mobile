import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  const BaseButton(
      {super.key,
      required this.text,
      this.onPressed,
      this.buttonStyle,
      this.buttonTextStyle,
      this.isDisabled,
      this.height,
      this.width,
      this.margin,
      this.alignment,
      this.radius,
      this.backgroundColor});
  final String text;
  final VoidCallback? onPressed;
  final ButtonStyle? buttonStyle;
  final TextStyle? buttonTextStyle;
  final bool? isDisabled;
  final double? height;
  final double? width;
  final EdgeInsets? margin;
  final Alignment? alignment;
  final double? radius;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
