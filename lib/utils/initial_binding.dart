import 'package:event_booking/home_gridview/controller/home_gridView_controller.dart';
import 'package:event_booking/screens/change_password/controller/change_password_controller.dart';
import 'package:event_booking/screens/login/controller/login_controller.dart';
import 'package:event_booking/screens/setting/controller/settings_controller.dart';
import 'package:event_booking/screens/splash/controller/splash_controller.dart';
import 'package:get/get.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
    Get.put(HomeGridController());
    Get.put(LoginController());
    Get.put(SettingsController());
    Get.put(ChangePasswordController());
    // Get.put(BottomNavigationController());
  }
}
