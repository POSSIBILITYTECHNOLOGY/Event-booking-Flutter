import 'package:event_booking/screens/favourite_screen/controller/favourite_screen_controller.dart';
import 'package:get/get.dart';

class FavouriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FavouriteController());
  }
}
