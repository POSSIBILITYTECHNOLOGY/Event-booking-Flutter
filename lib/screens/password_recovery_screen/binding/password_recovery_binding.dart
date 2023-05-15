import 'package:event_booking/screens/password_recovery_screen/controller/password_recovery_controller.dart';
import 'package:get/get.dart';

class PasswordRecoveryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PasswordRecoveryController());
  }
}
