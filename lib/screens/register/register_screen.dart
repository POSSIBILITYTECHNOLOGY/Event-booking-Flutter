import 'package:animate_do/animate_do.dart';
import 'package:event_booking/screens/login/login_screen.dart';
import 'package:event_booking/screens/register/controller/register_controller.dart';
import 'package:event_booking/utils/commonMethods.dart';
import 'package:event_booking/utils/widgets/common_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../res/appImages.dart';
import '../../res/colors.dart';
import '../../utils/phone_number_us_formatter.dart';
import '../../utils/validation_functions.dart';
import '../../utils/widgets/common_Button.dart';
import '../../utils/widgets/common_Text_Widgets.dart';
import '../setting/controller/settings_controller.dart';

class RegisterScreen extends StatelessWidget {
  final _controller = Get.put(RegisterController());
  final _settingController = Get.put(SettingsController());

  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            CommonMethods.getInstance().hideKeyboard();
          },
          child: Stack(children: [
            Container(
              height: Get.height,
              width: Get.width,
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage(AppImages.login_bg_image), fit: BoxFit.cover),
              ),
            ),
            Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(end: Alignment.bottomCenter, begin: Alignment.topCenter, colors: [
              Colors.black.withOpacity(1),
              Colors.black.withOpacity(1),
              Colors.black.withOpacity(1),
              Colors.black.withOpacity(1),
              Colors.grey.shade900.withOpacity(0.8),
              Colors.grey.shade800.withOpacity(0.8),
              Colors.grey.shade600.withOpacity(0.6),
              Colors.grey.shade700.withOpacity(0.6),
            ]))),
            Positioned(left: 26.h, top: 20.h, right: 0, bottom: 0, child: const CommonBackButtom()),
            Form(
              key: _controller.registerformKey,
              child: Positioned(
                top: 40.h,
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.only(left: 27.w, right: 27.w, top: 20.h),
                  height: Get.height,
                  width: Get.width,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 35.h,
                        ),
                        FadeInRight(
                          animate: true,
                          child: SizedBox(
                              width: Get.width,
                              child: const Text(
                                "Register",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: AppColor.white_Color, fontSize: 32, fontFamily: "Rubik"),
                              )),
                        ),
                        FadeInUp(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 25.h,
                              ),
                              CommonTextFormFiiled(
                                textInputAction: TextInputAction.done,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                focusNode: FocusNode(),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter first name";
                                  }
                                  return null;
                                },
                                controller: _controller.firstNameController,
                                prefixIcon: Container(
                                    margin: const EdgeInsets.only(top: 15, bottom: 15, left: 5),
                                    child: Image.asset(AppImages.login_person_Icon, height: 3.h)),
                                hint: "First Name",
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              CommonTextFormFiiled(
                                textInputAction: TextInputAction.done,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                focusNode: FocusNode(),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter last name";
                                  }
                                  return null;
                                },
                                controller: _controller.lastNameController,
                                prefixIcon: Container(
                                    margin: const EdgeInsets.only(top: 15, bottom: 15, left: 5),
                                    child: Image.asset(AppImages.login_person_Icon, height: 3.h)),
                                hint: "Last Name",
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              CommonTextFormFiiled(
                                textInputAction: TextInputAction.done,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                focusNode: FocusNode(),
                                validator: (value) {
                                  if (!isValidEmail(value)) {
                                    return "Please enter valid email";
                                  }
                                  return null;
                                },
                                controller: _controller.emailController,
                                prefixIcon: Container(
                                    margin: const EdgeInsets.only(top: 15, bottom: 15, left: 5),
                                    child: Image.asset(AppImages.login_person_Icon, height: 3.h)),
                                hint: "Email",
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Obx(
                                () => CommonTextFormFiiled(
                                  isObscureText: _controller.isHidePassword.value,
                                  textInputAction: TextInputAction.done,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  focusNode: FocusNode(),
                                  validator: (value) {
                                    if (value == null || (!isValidPassword(value, isRequired: true))) {
                                      return "Password must be at least 8 characters and a combination of small & capital letters, digits and special character";
                                    }
                                    return null;
                                  },
                                  controller: _controller.passwordController,
                                  prefixIcon: Container(
                                      margin: const EdgeInsets.only(top: 15, bottom: 15, left: 5),
                                      child: Image.asset(AppImages.login_lock_Icon, height: 3.h)),
                                  hint: "Password",
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
                              SizedBox(
                                height: 10.h,
                              ),
                              Obx(
                                () => CommonTextFormFiiled(
                                  isObscureText: _controller.isHideCp.value,
                                  textInputAction: TextInputAction.done,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  focusNode: FocusNode(),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter confirm Password";
                                    } else if (value != _controller.passwordController.text) {
                                      return "Password does not match";
                                    }
                                    return null;
                                  },
                                  controller: _controller.confirmPasswordController,
                                  prefixIcon: Container(
                                      margin: const EdgeInsets.only(top: 15, bottom: 15, left: 5),
                                      child: Image.asset(AppImages.login_lock_Icon, height: 3.h)),
                                  hint: "Confirm Password",
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
                                height: 10.h,
                              ),
                              CommonTextFormFiiled(
                                inputFormatter: [PhoneNumberFormatter()],
                                maxLength: 12,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                focusNode: FocusNode(),
                                validator: (value) {
                                  if (_controller.phoneNumController.text.isEmpty) {
                                    return null;
                                  } else if (!isValidphoneInUSFormat(value)) {
                                    return "please enter valid phone number";
                                  }
                                  return null;
                                },
                                controller: _controller.phoneNumController,
                                prefixIcon: Container(
                                    margin: const EdgeInsets.only(top: 15, bottom: 15, left: 5),
                                    child: Image.asset(AppImages.call_Icon, height: 3.h)),
                                hint: "Phone Number (Optional)",
                              ),
                              Obx(
                                () => Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        _controller.isTandCSelected.value = !_controller.isTandCSelected.value;
                                      },
                                      child: Container(
                                        child: _controller.isTandCSelected.value == false
                                            ? const Icon(
                                                Icons.check_box_outline_blank,
                                                color: AppColor.grey,
                                                size: 22,
                                              )
                                            : const Icon(
                                                Icons.check_box_sharp,
                                                color: AppColor.light_grey,
                                                size: 22,
                                              ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.h,
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.7,
                                      child: RichText(
                                          overflow: TextOverflow.clip,
                                          softWrap: true,
                                          maxLines: 2,
                                          text: TextSpan(children: [
                                            TextSpan(
                                                recognizer: TapGestureRecognizer()
                                                  ..onTap = () {
                                                    _settingController.index.value = 1;
                                                    _settingController.navigateScreen();
                                                  },
                                                text: "I agree with Terms Conditions & ",
                                                style: const TextStyle(
                                                    overflow: TextOverflow.ellipsis,
                                                    fontFamily: "Rubik",
                                                    fontSize: 13,
                                                    color: AppColor.grey)),
                                            TextSpan(
                                                recognizer: TapGestureRecognizer()
                                                  ..onTap = () {
                                                    _settingController.index.value = 2;
                                                    _settingController.navigateScreen();
                                                  },
                                                text: "Privacy Policy",
                                                style: const TextStyle(fontFamily: "Rubik", fontSize: 13, color: AppColor.grey))
                                          ])),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 25.h,
                              ),
                              CommonButton(
                                bgColor: AppColor.white_Color,
                                onTap: () {
                                  _controller.onTapRegister();
                                },
                                text: "Sign Up",
                                textStyle: const TextStyle(fontFamily: "Rubik", fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Already member?",
                                    style: TextStyle(fontFamily: "Rubik", fontSize: 15, color: AppColor.white_Color),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.off(LoginScreen());
                                    },
                                    child: const Text(
                                      "LogIn",
                                      style: TextStyle(fontFamily: "Rubik", fontSize: 15, color: AppColor.white_Color),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

//register
