import 'package:event_booking/home_gridview/controller/home_gridView_controller.dart';
import 'package:get/get.dart';

class HomeGridBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeGridController());
  }
}
