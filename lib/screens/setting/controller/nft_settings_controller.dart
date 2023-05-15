import 'dart:developer';

import 'package:event_booking/data/apiClient/api_client.dart';
import 'package:event_booking/data/api_Url/api_urls.dart';
import 'package:event_booking/res/colors.dart';
import 'package:event_booking/screens/setting/settings_common_screen/settings_common_Screen.dart';
import 'package:event_booking/utils/loader.dart';
import 'package:event_booking/utils/sharedpref.dart';
import 'package:get/get.dart';

import '../../../utils/widgets/common_Widget.dart';

class NftSettingsController extends GetxController {
  var index = 0.obs;
  var currentTabId = "4".obs;
  String aboutText = "";
  String termsDConditionsText = "";
  String privacyPolicyText = "";
  var firstName = "".obs;
  var lastName = "".obs;

  var isLoading = false.obs;
  var selectedindex = false.obs;
  var phoneNumber = "".obs;
  RxString userToken = "".obs;
  RxString profilePic = "".obs;

  var eventList = [].obs;

  ApiClient apiClient = ApiClient();

  getSharedPreferenceValue() {
    SharedPref.getAuthToken().then((value) {
      if (value != null) {
        userToken.value = value;
      }
    });
  }

  // getSharePreferenceData(){
  //   SharedPref.
  // }

  navigateScreen() {
    if (index.value == 0) {
      Get.to(() => SettingCommonScreen(
            text: "About Us",
            data: aboutText,
          ));
    } else if (index.value == 1) {
      Get.to(() => SettingCommonScreen(
            text: "Terms & Conditions",
            data: termsDConditionsText,
          ));
    } else if (index.value == 2) {
      Get.to(() => SettingCommonScreen(
            text: "Privacy Policy",
            data: privacyPolicyText,
          ));
    }
  }

  Future<dynamic> fetchEventsforSelectedId() async {
    isLoading(true);
    await getSharedPreferenceValue();
    log("fetchEventsforSelectedId");
    Get.dialog(const Loader(), barrierDismissible: false);
    var response = await apiClient.callPostmanGetApi("${ApiUrl.hoByEventsbyCategory}/7", token: userToken.value);
    // log("fetchCategoryList Response $response");
    // var data = UpdateProfileModel.fromJson(response);
    // Get.back();
    if (response['status'] == 200) {
      eventList.clear();

      eventList.value = response['data'];

      // eventByCategoryImageList.value = response['data']['images'];
      Get.back();
      // log("fetchEventsforSelectedId Response ${eventList[0]['favorite']}");

      // log("fetchEventsforSelectedId Response ${eventByCategoryList[0]}");
      isLoading(false);

      // showSnackBar("What's Poppin", response['message'].toString(), AppColor.light_blue);
    } else {
      isLoading(false);
      Get.back();
      log("fetchEventsforSelectedId ${response['message']}");

      // showSnackBar("What's Poppin", response['message'].toString(), AppColor.light_grey);
    }
    isLoading(false);
  }

  // * Favourite
  Future<dynamic> favouriteEvent(eventId, {categoryId, callFrom}) async {
    await getSharedPreferenceValue();

    // isLoading(true);
    log("favouriteEvent");
    // Get.dialog(Loader(), barrierDismissible: false);
    var response = await apiClient.callPostApi(ApiUrl.favEvent, {"event_id": eventId}, authToken: userToken.value);
    log("favouriteEvent Response $response");
    // var data = UpdateProfileModel.fromJson(response);
    // Get.back();

    if (response['status'] == 200) {
      await fetchEventsforSelectedId();
      return true;
    } else {
      // Get.back();
      log("favouriteEvent ${response['message']}");
      showSnackBar("What's Poppin", response['message'].toString(), AppColor.light_grey);
      return false;
    }
    // isLoading(false);
  }

  Future<dynamic> deleteFavouriteEvent(eventId, {categoryId, callFrom}) async {
    await getSharedPreferenceValue();

    // isLoading(true);
    log("deleteFavouriteEvent");
    // Get.dialog(Loader(), barrierDismissible: false);
    var response = await apiClient.callDeleteApi(ApiUrl.removeFavEvent, query: {"event_id": eventId.toString()}, token: userToken.value);
    log("deleteFavouriteEvent Response $response");
    // var data = UpdateProfileModel.fromJson(response);
    // Get.back();

    if (response['status'] == 200) {
      // await fetchEventsforSelectedId(currentTabId);
      await fetchEventsforSelectedId();

      return true;
    } else {
      // Get.back();
      log("deleteFavouriteEvent ${response['message']}");
      showSnackBar("What's Poppin", response['message'].toString(), AppColor.light_grey);
      return false;
    }
    // isLoading(false);
  }

  @override
  void onInit() {
    getSharedPreferenceValue();
    fetchEventsforSelectedId();
    super.onInit();
  }
}
