import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:event_booking/res/colors.dart';
import 'package:event_booking/routes/app_routes.dart';
import 'package:event_booking/screens/setting/controller/settings_controller.dart';
import 'package:event_booking/screens/setting/screens/nft_setting_screen.dart';
import 'package:event_booking/utils/commonMethods.dart';
import 'package:event_booking/utils/sharedpref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../res/appImages.dart';

class SettingsScreen extends StatelessWidget {
  final SettingsController _settingsController = Get.put(SettingsController());

  SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _settingsController.getSharedPreferenceValue();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          //  * Hide Keyboard
          child: GestureDetector(
            onTap: () {
              CommonMethods.getInstance().hideKeyboard();
            },
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    log(_settingsController.profilePic.value);
                    log(_settingsController.firstName.value);
                    log(_settingsController.lastName.value);
                  },
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Settings",
                      style: TextStyle(color: AppColor.white_Color, fontFamily: "Roboto", fontWeight: FontWeight.w600, fontSize: 25),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Column(
                  children: [
                    Obx(
                      () => settingProfile(_settingsController.profilePic.value,
                          "${_settingsController.firstName.value} ${_settingsController.lastName.value}", Icons.navigate_next, () {
                        Get.toNamed(AppRoutes.profile_Screen, arguments: [_settingsController.profilePic.value]);
                      }),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    settingsData(AppImages.about_us_Icon, "About Us", Icons.navigate_next, () {
                      _settingsController.index.value = 0;
                      _settingsController.navigateScreen();
                    }),
                    settingsData(AppImages.terms_d_Condition_Icon, "Terms and Conditions ", Icons.navigate_next, () {
                      _settingsController.index.value = 1;
                      _settingsController.navigateScreen();
                    }),
                    settingsData(AppImages.about_us_Icon, "Privacy Policy", Icons.navigate_next, () {
                      _settingsController.index.value = 2;
                      _settingsController.navigateScreen();
                    }),
                    Obx(() => _settingsController.socialLogin.value == "false"
                        ? settingsData(AppImages.change_password_Icon, "Change Password", Icons.navigate_next, () {
                            Get.toNamed(AppRoutes.cahnge_Password_Screen);
                          })
                        : Container()),
                    settingsData(AppImages.delete_Icon, "Delete Account", Icons.navigate_next, () {
                      CommonMethods.getInstance().showDialogBox("Are you sure you want to Delete your account?", () {
                        _settingsController.deleteAccountApi();
                      }, () {
                        Get.back();
                      });
                    }),
                    settingsData(AppImages.contact_us_Icon, "Contact Us", Icons.navigate_next, () {
                      Get.toNamed(AppRoutes.contact_Screen);
                    }),
                    settingsData(AppImages.nft_Icon, "NFT", Icons.navigate_next, () {
                      Get.to(() => const NftSettingScreen());
                    }),
                    settingsData(AppImages.logout_Icon, "Logout", Icons.navigate_next, () {
                      CommonMethods.getInstance().showDialogBox("Are you sure you want to logout?", () async {
                        await SharedPref.clear();
                        SharedPref.setSocialLogin("false");

                        // Get.offAll(() => LoginScreen());
                        Get.offAllNamed(AppRoutes.login_Screen);
                      }, () {
                        Get.back();
                      });
                    }),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget settingProfile(String image, String? name, IconData? icon, Function()? ontap) {
    return FadeInLeft(
      animate: true,
      child: InkWell(
        splashColor: AppColor.light_black,
        onTap: _settingsController.socialLogin.value == "false" ? ontap : null,
        child: Container(
          padding: EdgeInsets.only(left: 32.w, top: 8.h, bottom: 8.h, right: 30.w),
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.light_grey.withOpacity(0.09)),
            borderRadius: const BorderRadius.horizontal(right: Radius.circular(16)),
            color: AppColor.light_grey.withOpacity(0.2),
          ),
          child: Row(
            children: [
              Hero(
                tag: image,
                child: image.isNotEmpty
                    ? Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            image: DecorationImage(
                                image: NetworkImage(image),
                                // AssetImage(image),
                                fit: BoxFit.fill)
                            // : DecorationImage(image: FileImage(File(_settingsController.profilePic.value.toString())),fit: BoxFit.fill ),
                            ),
                      )
                    : SizedBox(
                        height: 50.h,
                        width: 50.w,
                        child: const Center(
                            child: CircularProgressIndicator(
                          strokeWidth: 3,
                          color: AppColor.light_blue,
                        ))),
              ),
              SizedBox(
                width: 21.w,
              ),
              SizedBox(
                  width: Get.width * 0.4,
                  child: Text(
                    name!,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(color: AppColor.white_Color, fontSize: 20, fontFamily: "Roboto"),
                  )),
              const Spacer(),
              Icon(
                icon!,
                color: AppColor.white_Color,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget settingsData(String? image, String? text, IconData? icon, Function()? onTap) {
    return FadeInUp(
      animate: true,
      child: InkWell(
        splashColor: AppColor.light_black,
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 13.h),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.h),
                    child: Image.asset(
                      image!,
                      height: 17,
                    ),
                  ),
                  SizedBox(
                    width: 20.h,
                  ),
                  SizedBox(
                      width: Get.width * 0.4,
                      child: Text(
                        text!,
                        overflow: TextOverflow.ellipsis,
                        style:
                            const TextStyle(color: AppColor.white_Color, fontWeight: FontWeight.w500, fontSize: 14, fontFamily: "Roboto"),
                      )),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                      icon,
                      color: AppColor.white_Color,
                      size: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              const Divider(
                thickness: 0.3,
              )
            ],
          ),
        ),
      ),
    );
  }
}
