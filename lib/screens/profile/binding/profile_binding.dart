import 'package:event_booking/screens/profile/controller/profile_controller.dart';
import 'package:get/get.dart';

class ProfilrBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut(() => ProfileController());
  }
}
