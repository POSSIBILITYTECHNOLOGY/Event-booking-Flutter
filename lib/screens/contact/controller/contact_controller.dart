import 'dart:developer';

import 'package:event_booking/data/apiClient/api_client.dart';
import 'package:event_booking/data/api_Url/api_urls.dart';
import 'package:event_booking/res/colors.dart';
import 'package:event_booking/screens/contact/model/contact_model.dart';
import 'package:event_booking/utils/widgets/common_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../utils/loader.dart';

class ContactController extends GetxController {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  GlobalKey<FormState> contactformKey = GlobalKey<FormState>();

  final ApiClient _apiClient = ApiClient();

  onTapSendMessage() {
    if (contactformKey.currentState!.validate()) {
      sendContactApi(firstNameController.text.trim().toString(), lastNameController.text.trim().toString(),
          emailController.text.trim().toString(), messageController.text.trim().toString());
      log("Success");
    } else {
      log("error");
    }
  }

  sendContactApi(String? firstName, String? lastName, String? email, String? message) async {
    Get.dialog(const Loader(), barrierDismissible: false);
    var response = await _apiClient
        .callPostApi(ApiUrl.contact_Us, {"first_name": firstName, "last_name": lastName, "email": email, "message": message});
    var contactDetail = ContactModel.fromJson(response);
    Get.back();

    if (contactDetail.status == 200) {
      Get.back();
      showSnackBar("What's Poppins", contactDetail.message, AppColor.light_blue);
    }
  }
}
