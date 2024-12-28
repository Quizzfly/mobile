import 'dart:async';
import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';

class DeepLinkService {
  static final DeepLinkService _instance = DeepLinkService._internal();
  factory DeepLinkService() => _instance;
  DeepLinkService._internal();

  final _deepLinkController = StreamController<Uri>.broadcast();
  Stream<Uri> get deepLinkStream => _deepLinkController.stream;
  Uri? _initialUri;
  bool _initialUriIsHandled = false;

  // Add getter for initial URI
  Uri? get initialUri => _initialUri;

  Future<void> handleInitialUri() async {
    if (!_initialUriIsHandled) {
      _initialUriIsHandled = true;
      try {
        final uri = await getInitialUri();
        if (uri != null) {
          _initialUri = uri;
          _deepLinkController.add(uri);
        }
      } catch (e) {
        debugPrint('Deep link initial uri error: $e');
      }
    }
  }

  void initialize() {
    uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        _deepLinkController.add(uri);
      }
    }, onError: (err) {
      debugPrint('Deep link error: $err');
    });
  }

  void dispose() {
    _deepLinkController.close();
  }
}
