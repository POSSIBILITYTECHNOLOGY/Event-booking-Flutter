// ignore_for_file: constant_identifier_names

import 'package:event_booking/screens/bottom_nav_bar/binding/bottom_nav_binding.dart';
import 'package:event_booking/screens/change_password/change_password_screen.dart';
import 'package:event_booking/screens/contact/binding/contact_binding.dart';
import 'package:event_booking/screens/contact/contact_Screen.dart';
import 'package:event_booking/screens/home/binding/home_binding.dart';
import 'package:event_booking/screens/home/home_screen.dart';
import 'package:event_booking/screens/home/screens/home_details_screen.dart';
import 'package:event_booking/screens/login/login_screen.dart';
import 'package:event_booking/screens/password_recovery_screen/password_recovery_screen.dart';
import 'package:event_booking/screens/profile/binding/profile_binding.dart';
import 'package:event_booking/screens/profile/profile_screen.dart';
import 'package:event_booking/screens/register/bindings/register_bindings.dart';
import 'package:event_booking/screens/splash/splash_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../screens/bottom_nav_bar/bottom_navigation_bar.dart';
import '../screens/change_password/binding/change_password_binding.dart';
import '../screens/login/binding/login_binding.dart';
import '../screens/password_recovery_screen/binding/password_recovery_binding.dart';
import '../screens/register/register_screen.dart';
import '../screens/splash/binding/splash_binding.dart';

class AppRoutes {
  static String initialRoute = "/initialRoute";
  static const String splash = "/splash";
  static const String login_Screen = "/login_Screen";
  static const String register_Screen = "/register_Screen";
  static const String recovery_password = "/recovery_password";

// * HOME
  static const String home_Screen = "/home_Screen";
  static const String homeScreenDetails = "/home-Screen-details";

  static const String bottom_nav_Screen = "/bottom_nav_Screen";
  static const String bottom_nav_Screen_View_Ticket = "/bottom_nav_Screen_view_ticket";
  static const String cahnge_Password_Screen = "/change_Password_Screen";
  static const String profile_Screen = "/profile_Screen";
  static const String contact_Screen = "/contact_Screen";

  static List<GetPage> pages = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
      bindings: [
        SplashBinding(),
      ],
    ),
    GetPage(
      name: login_Screen,
      page: () => LoginScreen(),
      bindings: [
        LoginBinding(),
      ],
    ),
    GetPage(
      name: register_Screen,
      page: () => RegisterScreen(),
      bindings: [
        RegisterBindings(),
      ],
    ),
    GetPage(
      name: recovery_password,
      page: () => PasswordRecoveryScreen(),
      bindings: [
        PasswordRecoveryBinding(),
      ],
    ),
    // * Home
    GetPage(
      name: home_Screen,
      page: () => const HomeScreen(),
      bindings: [
        HomeBinding(),
      ],
    ),
    GetPage(
      name: homeScreenDetails,
      page: () => HomeScreenDetails(),
      bindings: [
        HomeBinding(),
      ],
    ),
    GetPage(
      name: bottom_nav_Screen,
      page: () => const BottomNavigationScreen(),
      bindings: [
        BottomNavigationBinding(),
      ],
    ),
    GetPage(
      name: bottom_nav_Screen_View_Ticket,
      page: () => const BottomNavigationScreen(
        callFrom: "View Ticket",
      ),
      bindings: [
        BottomNavigationBinding(),
      ],
    ),
    GetPage(
      name: cahnge_Password_Screen,
      page: () => ChangePasswordScreen(),
      bindings: [
        ChangePasswordBinding(),
      ],
    ),
    GetPage(
      name: profile_Screen,
      page: () => ProfileScreen(),
      bindings: [
        ProfilrBinding(),
      ],
    ),
    GetPage(
      name: contact_Screen,
      page: () => ContactScreen(),
      bindings: [
        ContactBinding(),
      ],
    ),
  ];
}
