import 'dart:developer';

import 'package:event_booking/data/apiClient/api_client.dart';
import 'package:event_booking/data/api_Url/api_urls.dart';
import 'package:event_booking/res/colors.dart';
import 'package:event_booking/utils/sharedpref.dart';
import 'package:event_booking/utils/widgets/common_Widget.dart';
import 'package:get/get.dart';

class FavouriteController extends GetxController {
  @override
  void onInit() {
    getSharedPrefValues();
    listAllFavourite();
    super.onInit();
  }

// * Variables
  var apiClient = ApiClient();
  var authToken = "".obs;

  var isLoading = false.obs;
  var favItemList = [].obs;

  // * Shared Pred
  getSharedPrefValues() {
    SharedPref.getAuthToken().then((value) {
      if (value != null) {
        log("getSharedPrefValues $value");
        authToken.value = value;
      }
    });
  }

// * Tickets Fetch
  Future<dynamic> listAllFavourite() async {
    favItemList.clear();

    isLoading(true);

    await getSharedPrefValues();

    var response = await apiClient.callPostmanGetApi(ApiUrl.listFavourite, token: authToken.value);
    // log("listAllFavourite ${response['data'][0]}");

    // Get.back();

    if (response['status'] == 200) {
      favItemList.value = response['data'];

      isLoading(false);

      return true;
    } else {
      isLoading(false);
      // Get.back();
      log("listAllFavourite ${response['message']}");

      showSnackBar("What's Poppin", response['message'].toString(), AppColor.light_grey);
      return false;
    }
  }
}
