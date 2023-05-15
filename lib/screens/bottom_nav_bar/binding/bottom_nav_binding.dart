import 'package:get/get.dart';

import '../controller/bottom_nav_controller.dart';

class BottomNavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BottomNavigationController());
    // Get.put(BottomNavigationController());
  }
}
