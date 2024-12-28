import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../../core/app_export.dart';

class CountdownTimer extends StatefulWidget {
  final int timeLimit;
  final VoidCallback? onTimerComplete;
  final bool isPaused;
  const CountdownTimer(
      {super.key,
      required this.timeLimit,
      this.onTimerComplete,
      this.isPaused = false});

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  late int _remainingSeconds;
  bool _isTimerActive = true;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.timeLimit;
    startTimer();
  }

  @override
  void didUpdateWidget(CountdownTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPaused && _isTimerActive) {
      _timer.cancel();
      _isTimerActive = false;
    } else if (widget.timeLimit != oldWidget.timeLimit && !widget.isPaused) {
      _timer.cancel();
      setState(() {
        _remainingSeconds = widget.timeLimit;
      });
      startTimer();
    }
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _timer.cancel();
        if (widget.onTimerComplete != null) {
          widget.onTimerComplete!();
        }
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String get timeDisplay {
    int seconds = _remainingSeconds % 60;
    return seconds.toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 24.h),
      width: 70.h,
      height: 40.h,
      decoration: BoxDecoration(
        color: appTheme.whiteA700.withOpacity(0.5),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          timeDisplay,
          style: CustomTextStyles.titleMediumRobotoBlack900,
        ),
      ),
    );
  }
}
