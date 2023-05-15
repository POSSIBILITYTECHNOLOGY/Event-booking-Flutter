// ignore_for_file: avoid_types_as_parameter_names

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:event_booking/data/apiClient/api_client.dart';
import 'package:event_booking/data/api_Url/api_urls.dart';
import 'package:event_booking/res/colors.dart';
import 'package:event_booking/screens/profile/model/update_profile_model.dart';
import 'package:event_booking/utils/loader.dart';
import 'package:event_booking/utils/widgets/common_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../../utils/sharedpref.dart';
import '../../setting/controller/settings_controller.dart';

class ProfileController extends GetxController {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  GlobalKey<FormState> updateProfileKey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = ImagePicker();
  // List<XFile>? imageFileList;

  File? pickedImaage;

  // XFile? pickImage ;
  RxString pickImage = "".obs;
  RxString firstName = "".obs;
  RxString lastName = "".obs;
  RxString email = "".obs;
  RxString phone = "".obs;
  RxString authTocken = "".obs;
  RxString updatedImage = "".obs;

  ApiClient apiClient = ApiClient();

  // void _setImageFileListFromFile(XFile? value) {
  //   imageFileList = value == null ? null : <XFile>[value];
  // }

  // Get Data in Shared Preference

  getSharedPrefValues() {
    SharedPref.getFirstName().then((value) {
      if (value != null) {
        firstName.value = value;
        firstNameController.text = firstName.value;
        // emailValue.value = value;
        // emailController.text = emailValue.value;
      }
    });

    SharedPref.getLastName().then((value) {
      if (value != null) {
        lastName.value = value;
        lastNameController.text = lastName.value;
      }
    });

    SharedPref.getEmail().then((value) {
      if (value != null) {
        email.value = value;
        emailController.text = email.value;
      }
    });
    SharedPref.getPhoneNumber().then((value) {
      if (value != null) {
        phone.value = value;
        phoneNumberController.text = phone.value;
      }
    });
    SharedPref.getAuthToken().then((value) {
      if (value != null) {
        authTocken.value = value;
      }
    });

    SharedPref.getUpdatedImage().then((value) {
      if (value != null) {
        updatedImage.value = value;
      }
    });
  }

  // pick Image from Gallery

  pickImageGallery() async {
    try {
      final XFile? pickedImage = await _imagePicker.pickImage(source: ImageSource.gallery, maxHeight: 400, maxWidth: 400);
      if (pickedImage != null) {
        pickedImaage = File(pickedImage.path);
        pickImage.value = pickedImage.path;

        // pickImage = XFile(pickedImage.path);
        // _setImageFileListFromFile(pickedImage.path)
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  // Update Profile APIs

  Future<dynamic> updateProfileApi(String? firstName, String? lastName, var num, String? image) async {
    try {
      Get.dialog(const Loader(), barrierDismissible: false);
      // final FormData formData = FormData({
      //   "username": username,
      //   "password": password,
      //   "password_confirmation": confirm_pswd,
      //   "device_type": deviceType,
      //   "device_token": deviceToken,
      //   "image": image != null
      //       ? await MultipartFile.fromFile(image.path,
      //       filename: image.path.split('/').last)
      //       : null,
      // });

      Map<String, String> req = {};

      req["first_name"] = firstName ?? "";
      req["last_name"] = lastName ?? "";
      req["phone_number"] = num;
      // req["countryCode"] = countryCode;

      // try {
      var url = Uri.parse(ApiUrl.updateProfile);
      http.MultipartRequest request = http.MultipartRequest('POST', url);
      http.MultipartFile multipartFile;
      if (image != null) {
        multipartFile = await http.MultipartFile.fromPath("image", image);
        request.files.add(multipartFile);
        req["image"] = multipartFile.filename!;
      } else {
        log("file is null");
      }
      request.fields.addAll(req);
      var headers = {"Content-type": "application/json", "Authorization": "Bearer ${authTocken.value}"};
      request.headers.addAll(headers);
      var response = await request.send();

      // http.MultipartFile multipartFile;
      // if (image != null) {
      //   multipartFile =
      //   await http.MultipartFile.fromPath("image", image);
      //   req["image"] = multipartFile.filename!;
      // } else {
      //   log("file is null");
      // }

      //
      // var response = await apiClient.callPostApi(ApiUrl.updateProfile,
      //     request,
      //     // {
      //     //   "first_name": firstName,
      //     //   "last_name": lastName,
      //     //   "phone_number": num,
      //     //   "image": image
      //     //       != null
      //     //       ? await
      //     //   http.MultipartFile.fromString("image", image,filename:"",)
      //     //   // MultipartFile(image,
      //     //   //     filename: image.split('/').last)
      //     //       : null,
      //     // },
      //     authToken: authTocken.value);
      // log(response);

      response.stream.transform(utf8.decoder).listen((String res) {
        log("rrrrrrrrrr-->$res");
        var data = UpdateProfileModel.fromJson(jsonDecode(res));
// log("response ${response.reasonPhrase}");
        log("response-->${data.toJson()}");

        Get.back();
        if (data.status == 200) {
          SharedPref.setFirstName(firstName ?? " ");
          SharedPref.setLastName(lastName ?? " ");
          SharedPref.setPhoneNumber(num ?? " ");
          SharedPref.setUpdatedImage(data.data!.image ?? " ");

          Get.find<SettingsController>().firstName.value = firstName ?? "";

          Get.find<SettingsController>().lastName.value = lastName ?? "";

          Get.find<SettingsController>().phoneNumber.value = num ?? "";

          Get.find<SettingsController>().profilePic.value = data.data!.image ?? "";

          Get.back();
          showSnackBar("What's Poppin", data.message.toString(), AppColor.light_blue);
        } else {
          showSnackBar("What's Poppin", data.message.toString(), AppColor.light_grey);
        }
      });
    } catch (e) {
      log(e.toString());
    }
  }

  // Ontap Update Profile

  onTapUpdateProfile() {
    if (updateProfileKey.currentState!.validate()) {
      updateProfileApi(firstNameController.text.trim().toString(), lastNameController.text.trim().toString(),
          phoneNumberController.text.trim().toString(), pickedImaage?.path);
      // phoneNumberController.text.trim().toString(), pickedImaage == null ? null : pickedImaage?.path);
    }
  }

  @override
  void onInit() {
    getSharedPrefValues();

    super.onInit();
  }
}
