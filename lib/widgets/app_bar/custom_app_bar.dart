import 'package:flutter/material.dart';
import '../../core/app_export.dart';

enum Style { bgFillonErrorContainer, bgFillonPurple, bgTransparent }

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar(
      {super.key,
      this.height,
      this.leadingWidth,
      this.leading,
      this.title,
      this.centerTitle,
      this.styleType,
      this.actions,
      this.backgroundColor,
      this.contentPadding,
      this.padding});

  final double? height;
  final double? leadingWidth;
  final Widget? leading;
  final Widget? title;
  final Style? styleType;
  final bool? centerTitle;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: AppBar(
        elevation: 0,
        toolbarHeight: height ?? 30.h,
        backgroundColor: backgroundColor ?? Colors.transparent,
        automaticallyImplyLeading: false,
        leadingWidth: leadingWidth ?? 0,
        flexibleSpace: _getStyle(),
        leading: leading != null
            ? Padding(
                padding: contentPadding ?? EdgeInsets.zero,
                child: leading,
              )
            : null,
        title: title != null
            ? Padding(
                padding: contentPadding ?? EdgeInsets.zero,
                child: title,
              )
            : null,
        titleSpacing: 0,
        centerTitle: centerTitle ?? false,
        actions: actions
            ?.map((widget) => Padding(
                  padding: contentPadding ?? EdgeInsets.zero,
                  child: widget,
                ))
            .toList(),
      ),
    );
  }

  @override
  Size get preferredSize => Size(
        SizeUtils.width,
        height ?? 30.h,
      );

  _getStyle() {
    Color bgColor;
    switch (styleType) {
      case Style.bgFillonErrorContainer:
        bgColor = backgroundColor ?? appTheme.whiteA700;
        break;
      case Style.bgFillonPurple:
        bgColor = backgroundColor ?? appTheme.deppPurplePrimary;
        break;
      case Style.bgTransparent:
        bgColor = backgroundColor ?? Colors.transparent;
        break;
      default:
        bgColor = backgroundColor ?? Colors.transparent;
    }

    return Container(
      height: height ?? 56.h,
      width: 338.h,
      decoration: BoxDecoration(color: bgColor),
    );
  }
}
