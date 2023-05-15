import 'package:event_booking/routes/app_routes.dart';
import 'package:event_booking/utils/sharedpref.dart';
import 'package:get/get.dart';

class SplashController extends GetxController{
  @override
  void onInit() {
    splashInit();
    super.onInit();
  }
  splashInit() async{
  await  Future.delayed(const Duration(seconds: 3),()async{
    SharedPref.getAuthToken().then((tokken){
      if(tokken == null){
        Get.toNamed(AppRoutes.login_Screen);
      }else{
        Get.toNamed(AppRoutes.bottom_nav_Screen);
      }
    });
  }
  );
  }

}