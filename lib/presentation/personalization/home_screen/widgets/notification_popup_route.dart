import 'package:flutter/material.dart';

class NotificationPopupRoute extends PopupRoute<void> {
  final RelativeRect position;
  final Widget child;

  NotificationPopupRoute({
    required this.position,
    required this.child,
  });

  @override
  Color? get barrierColor => Colors.transparent;

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => null;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            color: Colors.transparent,
          ),
        ),
        Positioned(
          top: position.top,
          right: position.right,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        ),
      ],
    );
  }
}
