import 'package:event_booking/screens/register/controller/register_controller.dart';
import 'package:get/get.dart';

class RegisterBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController());
  }
}
