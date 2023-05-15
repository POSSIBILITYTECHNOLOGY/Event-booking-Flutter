import 'package:event_booking/res/appImages.dart';
import 'package:event_booking/screens/change_password/controller/change_password_controller.dart';
import 'package:event_booking/utils/commonMethods.dart';
import 'package:event_booking/utils/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../res/colors.dart';
import '../../utils/validation_functions.dart';
import '../../utils/widgets/common_Button.dart';
import '../../utils/widgets/common_Text_Widgets.dart';

class ChangePasswordScreen extends StatelessWidget {
  final ChangePasswordController _controller = Get.put(ChangePasswordController());

  ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            CommonMethods.getInstance().hideKeyboard();
          },
          child: Container(
            padding: EdgeInsets.only(left: 20.h, right: 20.h, top: 20.h),
            height: Get.height,
            width: Get.width,
            child: SingleChildScrollView(
              child: Form(
                key: _controller.formKey,
                child: Column(
                  children: [
                    const SettingsCommonAppBar(
                      text: "Change Password",
                    ),
                    SizedBox(
                      height: 52.h,
                    ),
                    Obx(() => CommonTextFormFilled2(
                          controller: _controller.currentPasswordController,
                          isObscureText: _controller.isHideMain.value,
                          textInputAction: TextInputAction.done,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          focusNode: FocusNode(),
                          validator: (value) {
                            if (value == null || (!isValidPassword(value, isRequired: true))) {
                              return "Please enter current password ";
                            }
                            return null;
                          },
                          prefixIcon: Container(
                              padding: const EdgeInsets.only(top: 15, bottom: 15, left: 5),
                              child: Image.asset(AppImages.login_lock_Icon, height: 2)),
                          hint: "Enter current password",
                          suffixIcon: InkWell(
                            onTap: () {
                              _controller.isHideMain.value = !_controller.isHideMain.value;
                            },
                            child: Container(
                                child: _controller.isHideMain.value == true
                                    ? Padding(
                                        padding: const EdgeInsets.all(13),
                                        child: Image.asset(
                                          AppImages.eye_Closed_Icon,
                                          height: 1,
                                          color: AppColor.light_grey,
                                          fit: BoxFit.contain,
                                        ),
                                      )
                                    : const Icon(
                                        Icons.remove_red_eye,
                                        color: AppColor.grey,
                                      )),
                          ),
                        )),
                    Obx(
                      () => CommonTextFormFilled2(
                        isObscureText: _controller.isHidePassword.value,
                        controller: _controller.newpasswordController,
                        // isObscureText: _controller.isHidePassword.value,
                        textInputAction: TextInputAction.done,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        focusNode: FocusNode(),
                        validator: (value) {
                          if (value == null || (!isValidPassword(value, isRequired: true))) {
                            return "Password must be at least 8 characters and a combination of small & capital letters, digits and special character";
                          } else if (value.trim().toString() == _controller.currentPasswordController.text.trim().toString()) {
                            return "New password cannot be the same as the current password. Please choose a different password";
                          }
                          return null;
                        },
                        prefixIcon: Container(
                            padding: const EdgeInsets.only(top: 15, bottom: 15, left: 5),
                            child: Image.asset(AppImages.login_lock_Icon, height: 2)),
                        hint: "Enter new password",
                        suffixIcon: InkWell(
                          onTap: () {
                            _controller.isHidePassword.value = !_controller.isHidePassword.value;
                          },
                          child: Container(
                              child: _controller.isHidePassword.value == true
                                  ? Padding(
                                      padding: const EdgeInsets.all(13),
                                      child: Image.asset(
                                        AppImages.eye_Closed_Icon,
                                        height: 1,
                                        color: AppColor.light_grey,
                                        fit: BoxFit.contain,
                                      ),
                                    )
                                  : const Icon(
                                      Icons.remove_red_eye,
                                      color: AppColor.grey,
                                    )),
                        ),
                      ),
                    ),
                    Obx(
                      () => CommonTextFormFilled2(
                        controller: _controller.confirmPasswordController,
                        isObscureText: _controller.isHideCp.value,
                        textInputAction: TextInputAction.done,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        focusNode: FocusNode(),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter confirm Password";
                          } else if (value != _controller.newpasswordController.text) {
                            return "New Password does not match with Confirm password";
                          }
                          return null;
                        },
                        prefixIcon: Container(
                            padding: const EdgeInsets.only(top: 15, bottom: 15, left: 5),
                            child: Image.asset(AppImages.login_lock_Icon, height: 2)),
                        hint: "Confirm new password",
                        suffixIcon: InkWell(
                          onTap: () {
                            _controller.isHideCp.value = !_controller.isHideCp.value;
                          },
                          child: Container(
                              child: _controller.isHideCp.value == true
                                  ? Padding(
                                      padding: const EdgeInsets.all(13),
                                      child: Image.asset(
                                        AppImages.eye_Closed_Icon,
                                        height: 1,
                                        color: AppColor.light_grey,
                                        fit: BoxFit.contain,
                                      ),
                                    )
                                  : const Icon(
                                      Icons.remove_red_eye,
                                      color: AppColor.grey,
                                    )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    CommonButton(
                      bgColor: AppColor.white_Color,
                      onTap: () {
                        _controller.onTapChangePassword();
                        // Get.toNamed(AppRoutes.bottom_nav_Screen);
                      },
                      text: "Save",
                      textStyle: const TextStyle(fontFamily: "Rubik", fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
