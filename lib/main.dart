import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/app_export.dart';
import 'core/utils/deep_link_service.dart';
import 'routes/navigation_args.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Future.wait([
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  ]).then((value) {
    PrefUtils().init();
    final deepLinkService = DeepLinkService();
    deepLinkService.initialize();
    deepLinkService.handleInitialUri();
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final DeepLinkService _deepLinkService = DeepLinkService();
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _setupDeepLinkHandling();
  }

  void _setupDeepLinkHandling() {
    // Handle initial deep link after app is fully initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_deepLinkService.initialUri != null && !_isInitialized) {
        _isInitialized = true;
        _handleDeepLink(_deepLinkService.initialUri!);
      }
    });

    // Handle subsequent deep links
    _deepLinkService.deepLinkStream.listen((Uri uri) {
      if (mounted) {
        _handleDeepLink(uri);
      }
    });
  }

  void _handleDeepLink(Uri uri) {
    debugPrint('Handling deep link: $uri');
    
    if (uri.host == 'quizzfly.site' && uri.path.contains('/groups/joined')) {
      final groupId = uri.queryParameters['idGroup'];
      if (groupId != null) {
        // Wait for navigator to be ready
        Future.delayed(const Duration(milliseconds: 100), () {
          if (NavigatorService.navigatorKey.currentState != null) {
            NavigatorService.pushNamed(
              AppRoutes.myGroupScreen,
              arguments: {
                NavigationArgs.groupId: groupId,
                NavigationArgs.showJoinDialog: true,
              },
            );
          } else {
            // Retry a few times if navigator is not ready
            int retryCount = 0;
            Timer.periodic(const Duration(milliseconds: 200), (timer) {
              if (NavigatorService.navigatorKey.currentState != null) {
                NavigatorService.pushNamed(
                  AppRoutes.myGroupScreen,
                  arguments: {
                    NavigationArgs.groupId: groupId,
                    NavigationArgs.showJoinDialog: true,
                  },
                );
                timer.cancel();
              } else if (retryCount >= 5) { // Retry up to 5 times
                timer.cancel();
                debugPrint('Failed to navigate after retries');
              }
              retryCount++;
            });
          }
        });
      }
    }
  }

  @override
  void dispose() {
    _deepLinkService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return BlocProvider(
          create: (context) => ThemeBloc(
            ThemeState(
              themeType: PrefUtils().getThemeData(),
            ),
          ),
          child: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return MaterialApp(
                theme: theme,
                title: 'quizzfly_mobile',
                navigatorKey: NavigatorService.navigatorKey,
                debugShowCheckedModeBanner: false,
                localizationsDelegates: const [
                  AppLocalizationDelegate(),
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate
                ],
                supportedLocales: const [
                  Locale(
                    'en',
                  )
                ],
                routes: AppRoutes.routes,
                onGenerateRoute: AppRoutes.generateRoute,
              );
            },
          ),
        );
      },
    );
  }
}
