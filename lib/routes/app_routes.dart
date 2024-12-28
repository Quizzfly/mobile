import 'package:flutter/material.dart';
import 'package:quizzfly_application_flutter/presentation/group/detail_post_screen/detail_post_screen.dart';
import '../core/app_export.dart';
import '../presentation/authentication/delete_account_screen/delete_account_screen.dart';
import '../presentation/authentication/login_screen/login_screen.dart';
import '../presentation/authentication/register_screen/register_screen.dart';
import '../presentation/group/community_screen/community_screen.dart';
import '../presentation/group/my_group_screen/my_group_screen.dart';
import '../presentation/personalization/home_screen/home_initial_page.dart';
import '../presentation/personalization/home_screen/home_screen.dart';
import '../presentation/personalization/profile_setting_screen/profile_setting_screen.dart';
import '../presentation/play_game/enter_pin_screen/enter_pin_screen.dart';
import '../presentation/play_game/input_nickname_screen/input_nick_name_screen.dart';
import '../presentation/personalization/quizzfly_setting_screen/quizzfly_setting_screen.dart';
import '../presentation/play_game/room_quiz_screen/room_quiz_screen.dart';
import '../presentation/play_game/waiting_room_screen/waiting_room_screen.dart';
import '../presentation/personalization/edit_profile_screen/edit_profile_screen.dart';
import '../presentation/personalization/quizzfly_detail_screen/quizzfly_detail_screen.dart';
import '../presentation/personalization/library_screen/library_screen.dart';
import '../presentation/authentication/reset_password_screen/reset_password_screen.dart';
import '../presentation/authentication/change_password_screen/change_password_screen.dart';
import '../presentation/authentication/forgot_password_screen/forgot_password_screen.dart';

class AppRoutes {
  static const String loginScreen = '/login_screen';
  static const String registerScreen = '/register_screen';
  static const String initialRoute = '/initialRoute';
  static const String forgotPasswordScreen = '/forgot_password_screen';
  static const String resetPassWordScreen = '/reset_password_screen';
  static const String editProfileScreen = '/edit_profile_screen';
  static const String privacyScreen = '/privacy_screen';
  static const String profileSettingScreen = '/profile_setting_screen';
  static const String changePasswordScreen = '/change_password_screen';
  static const String libraryScreen = '/library_screen';
  static const String quizzflyDetailScreen = "/quizzfly_detail_screen";
  static const String deleteAccountScreen = '/delete_account_screen';
  static const String quizzflySetting = "/quizzfly_setting_screen";
  static const String enterPinScreen = "/enter_pin_screen";
  static const String inputNickname = "/input_nickname_screen";
  static const String waitingRoom = "/waiting_room_screen";
  static const String leaderBoardScreen = "/leader_board_screen";
  static const String homeInitialPage = "/home_initial_page";
  static const String communityScreen = "/community_screen";
  static const String homeScreen = "/home_screen";
  static const String myGroupScreen = "/my_group_screen";
  static const String detailPostScreen = "/detail_post_screen";

  static Map<String, WidgetBuilder> get routes => {
        loginScreen: LoginScreen.builder,
        registerScreen: RegisterScreen.builder,
        forgotPasswordScreen: ForgotPasswordScreen.builder,
        changePasswordScreen: ChangePasswordScreen.builder,
        profileSettingScreen: ProfileSettingScreen.builder,
        resetPassWordScreen: ResetPasswordScreen.builder,
        libraryScreen: LibraryScreen.builder,
        quizzflyDetailScreen: QuizzflyDetailScreen.builder,
        deleteAccountScreen: DeleteAccountScreen.builder,
        quizzflySetting: QuizzflySettingScreen.builder,
        enterPinScreen: EnterPinScreen.builder,
        inputNickname: InputNicknameScreen.builder,
        waitingRoom: WaitingRoomScreen.builder,
        communityScreen: CommunityScreen.builder,
        homeInitialPage: HomeInitialPage.builder,
        homeScreen: HomeScreen.builder,
        myGroupScreen: MyGroupScreen.builder,
        detailPostScreen: DetailPostScreen.builder
      };

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      final int tokenExpires = PrefUtils().getTokenExpires();
      final int currentTime = DateTime.now().millisecondsSinceEpoch;

      if (tokenExpires > currentTime) {
        return MaterialPageRoute(
            builder: routes[homeScreen]!,
            settings: const RouteSettings(name: homeScreen));
      }

      return MaterialPageRoute(
          builder: routes[loginScreen]!,
          settings: const RouteSettings(name: loginScreen));
    }

    // Get the route builder
    final routeBuilder = routes[settings.name];
    if (routeBuilder == null) return null;

    // Check token expiry for protected routes
    if (_isProtectedRoute(settings.name!)) {
      final tokenExpires = PrefUtils().getTokenExpires();
      final currentTime = DateTime.now().millisecondsSinceEpoch;

      if (tokenExpires <= currentTime) {
        return MaterialPageRoute(
            builder: routes[loginScreen]!,
            settings: const RouteSettings(name: loginScreen));
      }
    }

    // Return the original route
    return MaterialPageRoute(builder: routeBuilder, settings: settings);
  }

  static bool _isProtectedRoute(String routeName) {
    final publicRoutes = [
      loginScreen,
      registerScreen,
      forgotPasswordScreen,
      resetPassWordScreen,
    ];
    return !publicRoutes.contains(routeName);
  }

  // Custom method to handle slide transition navigation for specific routes
  static Future<T?> navigateWithSlide<T>(
    BuildContext context,
    WidgetBuilder builder, {
    bool replace = false,
    Duration duration = const Duration(milliseconds: 400),
    Offset begin = const Offset(1.0, 0.0),
    Curve curve = Curves.easeInOut,
  }) {
    final PageRoute<T> pageRoute = PageRouteBuilder<T>(
      transitionDuration: duration,
      pageBuilder: (context, animation, secondaryAnimation) => builder(context),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const end = Offset.zero;
        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );

    if (replace) {
      return Navigator.pushReplacement(context, pageRoute);
    }
    return Navigator.push(context, pageRoute);
  }

  // Example screen-specific navigation methods using the generic method
  static Future<void> navigateToDeleteAccount(BuildContext context) {
    return navigateWithSlide(
      context,
      DeleteAccountScreen.builder,
    );
  }

  static Future<void> navigateToEditProfile(BuildContext context) {
    return navigateWithSlide(
      context,
      EditProfileScreen.builder,
    );
  }

  static Future<void> navigateToChangePassword(BuildContext context) {
    return navigateWithSlide(
      context,
      ChangePasswordScreen.builder,
    );
  }

  static Future<void> navigateToProfileSetting(BuildContext context) {
    return navigateWithSlide(
      context,
      ProfileSettingScreen.builder,
      // Example of customizing transition
      begin: const Offset(0.0, 1.0), // Slide up instead of right
    );
  }

  // Example of navigation with replacement (removes previous screen from stack)
  static Future<void> navigateToLogin(BuildContext context) {
    return navigateWithSlide(
      context,
      LoginScreen.builder,
      replace: true, // Will replace current screen
    );
  }

  static Future<void> navigateToForgotPasswordScreen(BuildContext context) {
    return navigateWithSlide(
      context,
      ForgotPasswordScreen.builder,
      replace: false, // Will replace current screen
    );
  }

  static Future<void> navigateToRegisterScreen(BuildContext context) {
    return navigateWithSlide(
      context,
      RegisterScreen.builder,
      replace: false, // Will replace current screen
    );
  }

  static Future<void> navigateToQuizzflyDetailScreen(BuildContext context) {
    return navigateWithSlide(
      context,
      QuizzflyDetailScreen.builder,
      replace: false, // Will replace current screen
    );
  }

  static Future<void> navigateToQuizzflySettingScreen(BuildContext context) {
    return navigateWithSlide(
      context,
      QuizzflySettingScreen.builder,
      replace: false, // Will replace current screen
    );
  }

  static Future<void> navigateToEnterPinScreen(BuildContext context) {
    return navigateWithSlide(
      context,
      EnterPinScreen.builder, replace: false, // Will replace current screen
    );
  }

  static Future<void> navigateToInputNickNameScreen(BuildContext context) {
    return navigateWithSlide(
      context,
      InputNicknameScreen.builder,
      replace: false, // Will replace current screen
    );
  }

  static Future<void> navigateToWaitingRoomScreen(BuildContext context) {
    return navigateWithSlide(
      context,
      WaitingRoomScreen.builder, replace: false, // Will replace current screen
    );
  }

  static Future<void> navigateToRoomQuizScreen(BuildContext context) {
    return navigateWithSlide(
      context,
      RoomQuizScreen.builder, replace: false, // Will replace current screen
    );
  }

  static Future<void> navigateToCommunityScreen(BuildContext context) {
    return navigateWithSlide(
      context,
      CommunityScreen.builder, replace: false, // Will replace current screen
    );
  }

  static Future<void> navigateToHomeScreen(BuildContext context) {
    return navigateWithSlide(
      context,
      HomeScreen.builder, replace: false, // Will replace current screen
    );
  }
}
