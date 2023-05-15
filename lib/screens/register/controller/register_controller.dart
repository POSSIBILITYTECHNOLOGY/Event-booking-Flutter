import 'dart:developer';

import 'package:event_booking/data/apiClient/api_client.dart';
import 'package:event_booking/data/api_Url/api_urls.dart';
import 'package:event_booking/res/colors.dart';
import 'package:event_booking/routes/app_routes.dart';
import 'package:event_booking/screens/register/model/register_model.dart';
import 'package:event_booking/utils/sharedpref.dart';
import 'package:event_booking/utils/widgets/common_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/loader.dart';

class RegisterController extends GetxController {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();

  final GlobalKey<FormState> registerformKey = GlobalKey<FormState>();

  var isTandCSelected = false.obs;
  var isHidePassword = true.obs;
  var isHideCp = true.obs;

  ApiClient apiClient = ApiClient();

  onTapRegister() {
    if (registerformKey.currentState!.validate()) {
      if (isTandCSelected.value == true) {
        registerApi(firstNameController.text.trim().toString(), lastNameController.text.trim().toString(),
            emailController.text.trim().toString(), phoneNumController.text.trim().toString(), passwordController.text.trim().toString());
      } else {
        // showvalidationMsg(Get.context! , "Please Select Terms and Privacy Policy");
        showSnackBar("What's Poppin", "Please Select Terms and Privacy Policy", AppColor.light_grey);
      }

      log("onTapRegister Registered Successfully");
    } else {
      log("onTapRegister Not Registered");
    }
  }

  Future<dynamic> registerApi(String? firstName, String? lastName, String? email, String? phoneNumber, String password) async {
    Get.dialog(const Loader(), barrierDismissible: false);
    var response = await apiClient.callPostApi(ApiUrl.registerApi, {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "password": password,
      "phone_number": phoneNumber,
      "device_token": "",
      "device_type": ""
    });
    var registerDetail = RegisterModel.fromJson(response);
    log("${registerDetail.status}");
    log("${registerDetail.data}");
    // Get.back();
    if (registerDetail.status == 200) {
      SharedPref.setAuthToken(registerDetail.data!.accessToken!);

      SharedPref.setEmail(email ?? " ");
      SharedPref.setFirstName(firstName ?? " ");
      SharedPref.setLastName(lastName ?? " ");
      SharedPref.setPhoneNumber(phoneNumber ?? "");
      SharedPref.setUpdatedImage(registerDetail.data!.image ?? "");

      Get.back();
      Get.back();
      SharedPref.setSocialLogin("false");
      Get.toNamed(AppRoutes.bottom_nav_Screen);

      // showvalidationMsg(Get.context! , registerDetail.message ?? " ");

      // showSnackBar("What's Poppin", registerDetail.message.toString(), AppColor.light_blue);
    } else {
      Get.back(); // showvalidationMsg(Get.context! , registerDetail.message ?? " ");
      showSnackBar("What's Poppin", registerDetail.message.toString(), AppColor.light_blue);
    }
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneNumController.dispose();

    super.onClose();
  }
}
