import 'package:flutter/material.dart';
import '../presentation/quizzfly_detail_screen/quizzfly_detail_screen.dart';
import '../presentation/library_screen/library_screen.dart';
import '../presentation/reset_password_screen/reset_password_screen.dart';
import '../presentation/change_password_screen/change_password_screen.dart';
import '../presentation/profile_setting_screen/profile_setting_screen.dart';
import '../presentation/forgot_password_screen/forgot_password_screen.dart';
// import '../presentation/app_navigation_screen/app_navigation_screen.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/register_screen/register_screen.dart';

class AppRoutes {
  static const String loginScreen = '/login_screen';
  static const String registerScreen = '/register_screen';
  // static const String appNavigationScreen = '/app_navigation_screen';
  static const String initialRoute = '/initialRoute';
  static const String forgotPasswordScreen = '/forgot_password_screen';
  static const String resetPassWordScreen = '/reset_password_screen';
  static const String editProfileScreen = '/edit_profile_screen';
  static const String privacyScreen = '/privacy_screen';
  static const String profileSettingScreen = '/profile_setting_screen';
  static const String changePasswordScreen = '/change_password_screen';
  static const String libraryScreen = '/library_screen';
  static const String quizzflyDetailScreen = "/quizzfly_detail_screen";

  static Map<String, WidgetBuilder> get routes => {
        loginScreen: LoginScreen.builder,
        registerScreen: RegisterScreen.builder,
        forgotPasswordScreen: ForgotPasswordScreen.builder,
        // appNavigationScreen: AppNavigationScreen.builder,
        changePasswordScreen: ChangePasswordScreen.builder,
        profileSettingScreen: ProfileSettingScreen.builder,
        resetPassWordScreen: ResetPasswordScreen.builder,
        libraryScreen: LibraryScreen.builder,
        quizzflyDetailScreen : QuizzflyDetailScreen.builder,
        initialRoute: LoginScreen.builder,
      };

  // static Widget initialRouteWidget(BuildContext context) {
  //   return FutureBuilder(
  //     future: PrefUtils().init(),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.done) {
  //         final accessToken = PrefUtils().getAccessToken();
  //         if (accessToken.isEmpty) {
  //           return LoginScreen.builder(context);
  //         } else {
  //           return ProfileSettingScreen.builder(context);
  //         }
  //       }
  //       // You might want to show a loading indicator here
  //       return const CircularProgressIndicator();
  //     },
  //   );
  // }

  // static Widget initialRouteWidget(BuildContext context) {
  //   return FutureBuilder(
  //     future: PrefUtils().init(),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.done) {
  //         final accessToken = PrefUtils().getAccessToken();
  //         if (accessToken.isEmpty) {
  //           return LoginScreen.builder(context);
  //         } else {
  //           return ProfileSettingScreen.builder(context);
  //         }
  //       }
  //       // You might want to show a loading indicator here
  //       return const CircularProgressIndicator();
  //     },
  //   );
  // }

  // static Route<dynamic> generateRoute(RouteSettings settings) {
  //   switch (settings.name) {
  //     case initialRoute:
  //       return MaterialPageRoute(
  //         builder: (context) => initialRouteWidget(context),
  //       );
  //     // Add cases for other routes if needed
  //     default:
  //       return MaterialPageRoute(
  //         builder: (_) => const Scaffold(
  //           body: Center(child: Text('Route not found!')),
  //         ),
  //       );
  //   }
  // }
  // static Route<dynamic> generateRoute(RouteSettings settings) {
  //   switch (settings.name) {
  //     case initialRoute:
  //       return MaterialPageRoute(
  //         builder: (context) => initialRouteWidget(context),
  //       );
  //     // Add cases for other routes if needed
  //     default:
  //       return MaterialPageRoute(
  //         builder: (_) => const Scaffold(
  //           body: Center(child: Text('Route not found!')),
  //         ),
  //       );
  //   }
  // }

  // Custom method to handle slide transition navigation for specific routes
  static void navigateToRegisterScreen(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration:
            const Duration(milliseconds: 400), // Set duration to 400ms
        pageBuilder: (context, animation, secondaryAnimation) =>
            LibraryScreen.builder(context),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Slide from right to left
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  static void navigateToForgotPasswordScreen(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration:
            const Duration(milliseconds: 400), // Set duration to 400ms
        pageBuilder: (context, animation, secondaryAnimation) =>
            ProfileSettingScreen.builder(context),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Slide from right to left
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }
}
