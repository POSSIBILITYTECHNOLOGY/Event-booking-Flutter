import 'dart:developer';

import 'package:event_booking/data/apiClient/api_client.dart';
import 'package:event_booking/data/api_Url/api_urls.dart';
import 'package:event_booking/res/colors.dart';
import 'package:event_booking/screens/password_recovery_screen/model/password_recovery_model.dart';
import 'package:event_booking/utils/widgets/common_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/loader.dart';

class PasswordRecoveryController extends GetxController {
  TextEditingController emailContoller = TextEditingController();

  GlobalKey<FormState> recoveryformKey = GlobalKey<FormState>();
  ApiClient apiClient = ApiClient();

  onTapRecovery() {
    if (recoveryformKey.currentState!.validate()) {
      forgetPassword(emailContoller.text.trim().toString());
    } else {
      log("onTapRecovery error");
    }
  }

  Future<dynamic> forgetPassword(String? email) async {
    Get.dialog(const Loader(), barrierDismissible: false);

    var response = await apiClient.callPostApi(ApiUrl.forgetPassword, {
      "email": email,
    });
    log("forgetPassword -----$response");
    var data = PasswordRecoveryModel.fromJson(response);
    Get.back();
    if (data.status == 200) {
      Get.back();
      showSnackBar("What's Poppin", data.message.toString(), AppColor.light_blue);
      // showvalidationMsg(Get.context! , data.message ?? " ");
    } else {
      showSnackBar("What's Poppin", data.message.toString(), AppColor.light_grey);
      // showvalidationMsg(Get.context! , data.message ?? " ");
    }
    log("$data");
  }
}
