import 'package:flutter/material.dart';
import '../../core/app_export.dart';

enum Style {bgFillonErrorContainer}
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar(
      {Key? key,
      this.height,
      this.leadingWidth,
      this.leading,
      this.title,
      this.centerTitle,
      this.styleType,
      this.actions})
      : super(
          key: key,
        );
  final double? height;
  final double? leadingWidth;
  final Widget? leading;
  final Widget? title;
  final Style? styleType;
  final bool? centerTitle;
  final List<Widget>? actions;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: height ?? 30.h,
      automaticallyImplyLeading: false,
      leadingWidth: leadingWidth ?? 0,
      flexibleSpace: _getStyle(),
      leading: leading,
      title: title,
      titleSpacing: 0,
      centerTitle: centerTitle ?? false,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size(
        SizeUtils.width,
        height ?? 30.h,
      );
  _getStyle() {
    switch (styleType) {
      case Style.bgFillonErrorContainer:
        return Container(
          height: 22.h,
          width: 338.h,
          decoration: BoxDecoration(color: appTheme.whiteA700),
        );
      default:
        return null;
    }
  }
}
