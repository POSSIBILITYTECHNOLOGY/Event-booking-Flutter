// ignore_for_file: file_names, depend_on_referenced_packages

import 'dart:developer';

import 'package:event_booking/res/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;

import '../res/appImages.dart';

class CommonMethods {
  static CommonMethods? _instance;

  static CommonMethods getInstance() {
    _instance ??= CommonMethods();
    return _instance!;
  }

  String checkImage(String file) {
    final extension = p.extension(file).replaceAll(RegExp(r'[^\w\s]+'), '');
    log(extension);
    if (extension.toString() != 'jpg') {
      return extension.toString();
    } else {
      return extension.toString();
    }
  }

  bool isValidEmail(String value) {
    RegExp regex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return regex.hasMatch(value);
  }

  bool isValidMobileNumber(String value) {
    RegExp regExp = RegExp(r'(^(?:[+0]9)?[0-9]$)');
    return regExp.hasMatch(value);
  }

  bool isValidUserName(String value) {
    RegExp regExp = RegExp("[a-zA-Z0-9]");
    return regExp.hasMatch(value);
  }

  bool isValidPassword(String password) {
    String pattern = r'^(?=.*?[a-zA-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~%():;<>?]).{8,}$';
    return RegExp(pattern).hasMatch(password);
  }

  showToast(String? message) {
    if (kDebugMode) {
      log("toast");
    }
    Get.snackbar("", message ?? "",
        titleText: const SizedBox(
          height: 0,
        ),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black38,
        colorText: Colors.white,
        margin: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 15),
        borderRadius: 6,
        animationDuration: const Duration(milliseconds: 400));
  }

  hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  colorTo(Color color) {
    return '#FF${color.value.toRadixString(16).substring(2, 8)}';
  }

  Color hex(String hexColor) {
    if (hexColor == "red") {
      hexColor = colorTo(Colors.red);
    } else if (hexColor == "green") {
      hexColor = colorTo(Colors.green);
    } else if (hexColor == "orange") {
      hexColor = colorTo(Colors.orange);
    }
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  showDialogBox(String? text, Function() onTap, Function() ontap) {
    return Get.dialog(Container(
      padding: EdgeInsets.only(left: 18.w, right: 18.w),
      margin: EdgeInsets.only(top: 130, bottom: 170, left: 30.w, right: 30.w),
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
            Text(
              text!,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  overflow: TextOverflow.clip,
                  decoration: TextDecoration.none,
                  fontSize: 25,
                  color: AppColor.white_Color,
                  fontFamily: "Roboto"),
            ),
            SizedBox(
              height: 10.h,
            ),
            MaterialButton(
              highlightColor: Colors.black,
              focusColor: Colors.black,
              splashColor: Colors.black,
              onPressed: onTap,
              child: Container(
                height: 37,
                width: Get.width,
                decoration: BoxDecoration(
                    color: AppColor.white_Color, borderRadius: BorderRadius.circular(5), border: Border.all(color: AppColor.white_Color)),
                child: const Center(
                  child: Text("Yes",
                      style: TextStyle(
                          overflow: TextOverflow.clip,
                          decoration: TextDecoration.none,
                          fontSize: 14,
                          color: AppColor.dark_grey,
                          fontFamily: "Roboto")),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            MaterialButton(
              onPressed: ontap,
              child: Container(
                height: 37,
                width: Get.width,
                decoration: BoxDecoration(
                    color: AppColor.medium_grey, borderRadius: BorderRadius.circular(5), border: Border.all(color: AppColor.white_Color)),
                child: const Center(
                    child: Text("No",
                        style: TextStyle(
                            overflow: TextOverflow.clip,
                            decoration: TextDecoration.none,
                            fontSize: 14,
                            color: AppColor.white_Color,
                            fontFamily: "Roboto"))),
              ),
            )
          ],
        ),
      ),
    ));
  }

  Widget customAppBar(String? markerIcon, String? location, String? address) {
    return Row(
      children: [
        Image.asset(
          markerIcon!,
          height: 33,
        ),
        const SizedBox(
          width: 12,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: Get.width * 0.52,
                    child: Text(
                      location!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: AppColor.white_Color, fontFamily: "Roboto", fontSize: 14),
                    )),
                Image.asset(
                  AppImages.drop_down_Icon,
                  height: 5,
                ),
              ],
            ),
            SizedBox(
                width: Get.width * 0.7,
                child: Text(
                  address!,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: AppColor.white_Color, fontFamily: "Roboto", fontSize: 9),
                ))
          ],
        ),
        const Spacer(),
        // Container(
        //   height: 40,
        //   width: 40,
        //   decoration: const BoxDecoration(
        //       shape: BoxShape.circle,
        //       image: DecorationImage(
        //           image: AssetImage(AppImages.user_image), fit: BoxFit.cover)),
        // )
      ],
    );
  }
}
