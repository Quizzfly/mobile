import 'package:flutter/material.dart';
import '../../core/app_export.dart';

class AppBarLeadingImage extends StatelessWidget {
  const AppBarLeadingImage({
    super.key,
    this.imagePath,
    this.height,
    this.width,
    this.onTap,
    this.margin,
    this.color,
    this.containerPadding,
  });

  final double? height;
  final double? width;
  final String? imagePath;
  final Function? onTap;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final EdgeInsetsGeometry? containerPadding;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: containerPadding ?? EdgeInsets.zero,
      child: InkWell(
        onTap: () {
          onTap?.call();
        },
        child: CustomImageView(
          imagePath: imagePath!,
          height: height ?? 22.h,
          width: width ?? 28.h,
          fit: BoxFit.contain,
          color: color,
        ),
      ),
    );
  }
}
