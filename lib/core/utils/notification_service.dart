import 'package:flutter/material.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  final GlobalKey<ScaffoldMessengerState> _messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  // Getter for messenger key
  GlobalKey<ScaffoldMessengerState> get messengerKey => _messengerKey;

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal();

  void showNotification({
    required String title,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    if (_messengerKey.currentState != null) {
      _messengerKey.currentState!.showSnackBar(
        SnackBar(
          duration: duration,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(message),
            ],
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(16),
        ),
      );
    }
  }
}
