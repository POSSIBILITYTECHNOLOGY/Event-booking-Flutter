import 'dart:developer';

import 'package:event_booking/data/apiClient/api_client.dart';
import 'package:event_booking/data/api_Url/api_urls.dart';
import 'package:event_booking/res/colors.dart';
import 'package:event_booking/screens/change_password/model/change_password_model.dart';
import 'package:event_booking/utils/loader.dart';
import 'package:event_booking/utils/sharedpref.dart';
import 'package:event_booking/utils/widgets/common_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  TextEditingController newpasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController currentPasswordController = TextEditingController();

  var isHidePassword = true.obs;
  var isHideCp = true.obs;
  var isHideMain = true.obs;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var getTocken = "".obs;

  ApiClient apiClient = ApiClient();

  // OnTap Change Password

  onTapChangePassword() {
    if (formKey.currentState!.validate()) {
      changePasswordApi(currentPasswordController.text.trim().toString(), newpasswordController.text.trim().toString());
    } else {
      log("onTapChangePassword error");
    }
  }
  // Change Password API

  Future<dynamic> changePasswordApi(String? currentPassword, String? password) async {
    Get.dialog(const Loader(), barrierDismissible: false);

    var response = await apiClient.callPostApi(
      ApiUrl.changePassword,
      {"current_password": currentPassword, "password": password},
      authToken: getTocken.value,
    );
    log("changePasswordApi =======$response");
    var changePasswordDetail = ChangePasswordModel.fromJson(response);
    Get.back();
    if (changePasswordDetail.status == 200) {
      Get.back();
      showSnackBar("What's Poppin", changePasswordDetail.message.toString(), AppColor.light_blue);
      // showvalidationMsg(Get.context! , changePasswordDetail.message ?? " ");
    } else {
      showSnackBar("What's Poppin", changePasswordDetail.message.toString(), AppColor.light_grey);
      // showvalidationMsg(Get.context! , changePasswordDetail.message ?? " ");
    }
  }

  // Get SharedPreference Value

  getSharedPreferenceValue() {
    SharedPref.getAuthToken().then((value) {
      if (value != null) {
        getTocken.value = value;
      }
    });
  }

  @override
  void onInit() {
    getSharedPreferenceValue();
    super.onInit();
  }
}
