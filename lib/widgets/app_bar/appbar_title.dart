import 'package:flutter/material.dart';
import '../../core/app_export.dart';

class AppbarTitle extends StatelessWidget {
  AppbarTitle({
    super.key,
    required this.text,
    this.onTap,
    this.padding,
    this.textColor, 
    this.textStyle, 
  });

  final String text;
  final Function? onTap;
  final EdgeInsetsGeometry? padding;
  final Color? textColor; 
  final TextStyle? textStyle; 

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: GestureDetector(
        onTap: () {
          onTap?.call();
        },
        child: Text(
          text,
          style: textStyle?.copyWith(color: textColor) ??
              CustomTextStyles.headlineSmallSFProRoundedGray90003
                  .copyWith(color: textColor),
        ),
      ),
    );
  }
}
