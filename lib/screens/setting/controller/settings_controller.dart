import 'dart:developer';

import 'package:event_booking/data/apiClient/api_client.dart';
import 'package:event_booking/data/api_Url/api_urls.dart';
import 'package:event_booking/routes/app_routes.dart';
import 'package:event_booking/screens/setting/model/about_Us_Model.dart';
import 'package:event_booking/screens/setting/model/delete_account_model.dart';
import 'package:event_booking/screens/setting/model/privacy_Policy_Model.dart';
import 'package:event_booking/screens/setting/model/terms_and_Conditions_Model.dart';
import 'package:event_booking/screens/setting/settings_common_screen/settings_common_Screen.dart';
import 'package:event_booking/utils/sharedpref.dart';
import 'package:event_booking/utils/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../res/appImages.dart';
import '../../../res/colors.dart';
import '../../../utils/loader.dart';

class SettingsController extends GetxController {
  var index = 0.obs;
  String aboutText = "";
  String termsDConditionsText = "";
  String privacyPolicyText = "";
  var firstName = "".obs;
  var lastName = "".obs;
  var selectedindex = false.obs;
  var phoneNumber = "".obs;
  var socialLogin = "".obs;
  RxString userToken = "".obs;
  RxString profilePic = "".obs;

  ApiClient apiClient = ApiClient();

  getSharedPreferenceValue() {
    SharedPref.getFirstName().then((value) {
      if (value != null) {
        firstName.value = value;
      }
    });
    SharedPref.getSocialLogin().then((value) {
      if (value != null) {
        socialLogin.value = value;
      }
    });

    SharedPref.getLastName().then((value) {
      if (value != null) {
        lastName.value = value;
      }
    });

    SharedPref.getPhoneNumber().then((value) {
      if (value != null) {
        phoneNumber.value = value;
      }
    });
    SharedPref.getUpdatedImage().then((value) {
      if (value != null) {
        profilePic.value = value;
        log("profilePic.value");
        log(profilePic.value);
      }
    });
    SharedPref.getAuthToken().then((value) {
      if (value != null) {
        userToken.value = value;
      }
    });
  }

  getAboutUsDetails() async {
    var response = await apiClient.callPostmanGetApi(ApiUrl.aboutUs);
    var aboutUsDetails = AboutUsModel.fromJson(response);

    if (aboutUsDetails.status == 200) {
      aboutText = aboutUsDetails.data!.aboutUs!;
    }
  }

  getTermsandConditionsDetails() async {
    var response = await apiClient.callPostmanGetApi(ApiUrl.termsAndConditions);
    var aboutUsDetails = TermsAndConditionsModel.fromJson(response);

    if (aboutUsDetails.status == 200) {
      termsDConditionsText = aboutUsDetails.data!.termsConditions!;
    }
  }

  getPrivacypolicyDetails() async {
    var response = await apiClient.callPostmanGetApi(ApiUrl.privacyPolicy);
    var aboutUsDetails = PrivacyPolicyModel.fromJson(response);

    if (aboutUsDetails.status == 200) {
      privacyPolicyText = aboutUsDetails.data!.privacyPolicy!;
    }
  }

  deleteAccountApi() async {
    Get.dialog(const Loader(), barrierDismissible: false);
    var response = await apiClient.callPostApi(ApiUrl.deleteAccount, {}, authToken: userToken.value);

    var deletedDetail = DeleteAccountModel.fromJson(response);
    Get.back();

    if (deletedDetail.status == 200) {
      showSnackBar("What's Poppins", deletedDetail.message, AppColor.light_blue);
      SharedPref.setSocialLogin("false");
      await SharedPref.clear();
      Get.offAllNamed(AppRoutes.login_Screen);
    } else {
      showSnackBar("What's Poppins", deletedDetail.message, AppColor.light_grey);
    }
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

  showDialogBox() {
    return Get.dialog(Container(
      padding: EdgeInsets.only(left: 18.w, right: 18.w),
      margin: EdgeInsets.only(top: 130.h, bottom: 170.h, left: 30.w, right: 30.w),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(17), color: AppColor.medium_grey),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10.h, left: 50.w, right: 50.w),
              height: 170.h,
              width: Get.width,
              decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(AppImages.popup_Image), fit: BoxFit.contain)),
            ),
            const Text(
              "Are you sure you want to logout?",
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  overflow: TextOverflow.clip,
                  decoration: TextDecoration.none,
                  fontSize: 25,
                  color: AppColor.white_Color,
                  fontFamily: "Roboto"),
            ),
            SizedBox(
              height: 10.h,
            ),
            Obx(
              () => MaterialButton(
                  onPressed: () {
                    if (selectedindex.value == false) {
                      selectedindex.value = true;
                      // Get.toNamed(AppRoutes.login_Screen);
                    } else {
                      log("not ok");
                    }
                    log("Selected");
                  },
                  child: Container(
                    height: 37,
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: selectedindex.value ? AppColor.white_Color : AppColor.medium_grey,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: AppColor.white_Color)),
                    child: Center(
                      child: Text("Yes",
                          style: TextStyle(
                              overflow: TextOverflow.clip,
                              decoration: TextDecoration.none,
                              fontSize: 14,
                              color: selectedindex.value ? AppColor.dark_grey : AppColor.white_Color,
                              fontFamily: "Roboto")),
                    ),
                  )),
            ),
            SizedBox(
              height: 10.h,
            ),
            Obx(
              () => MaterialButton(
                onPressed: () {
                  selectedindex.value = true;
                  if (selectedindex.value == true) {
                    selectedindex.value = false;
                    Get.back();
                  } else {
                    log("not ok");
                  }
                },
                child: Container(
                  height: 37,
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: selectedindex.value ? AppColor.medium_grey : AppColor.white_Color,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: AppColor.white_Color)),
                  child: Center(
                      child: Text("No",
                          style: TextStyle(
                              overflow: TextOverflow.clip,
                              decoration: TextDecoration.none,
                              fontSize: 14,
                              color: selectedindex.value ? AppColor.white_Color : AppColor.dark_grey,
                              fontFamily: "Roboto"))),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  @override
  void onInit() {
    getSharedPreferenceValue();
    getAboutUsDetails();
    getTermsandConditionsDetails();
    getPrivacypolicyDetails();
    super.onInit();
  }
}
