import 'package:animate_do/animate_do.dart';
import 'package:event_booking/res/appImages.dart';
import 'package:event_booking/res/colors.dart';
import 'package:event_booking/routes/app_routes.dart';
import 'package:event_booking/screens/login/controller/login_controller.dart';
import 'package:event_booking/utils/commonMethods.dart';
import 'package:event_booking/utils/widgets/common_Button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/validation_functions.dart';
import '../../utils/widgets/common_Text_Widgets.dart';

class LoginScreen extends StatelessWidget {
  final LoginController _loginController = Get.put(LoginController());

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _loginController.scaffoldKey,
        body: SafeArea(
          child: GestureDetector(
            onTap: () {
              CommonMethods.getInstance().hideKeyboard();
            },
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(AppImages.login_bg_image), fit: BoxFit.fill)),
                ),
                Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(end: Alignment.bottomCenter, begin: Alignment.topCenter, colors: [
                  Colors.black.withOpacity(1),
                  Colors.black.withOpacity(1),
                  Colors.black.withOpacity(1),
                  Colors.black.withOpacity(1),
                  Colors.grey.shade900.withOpacity(1),
                  Colors.grey.shade700.withOpacity(0.7),
                  Colors.grey.shade700.withOpacity(0.7),
                  Colors.grey.shade900..withOpacity(0.8),
                ]))),
                Form(
                  key: _loginController.loginformKey,
                  child: Container(
                    padding: EdgeInsets.only(left: 27.w, right: 27.w),
                    height: Get.height,
                    width: Get.width,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // Container(
                          //   padding: EdgeInsets.only(
                          //       top: Get.height * 0.12,
                          //       left: Get.width * 0.2,
                          //       right: Get.width * 0.2),
                          //   child: FadeInDown(
                          //     animate: true,
                          //     duration: const Duration(seconds: 2),
                          //     child: const Text(
                          //       "LOGO",
                          //       style: TextStyle(
                          //           color: AppColor.white_Color,
                          //           fontSize: 45,
                          //           fontFamily: "Rubik",
                          //           fontWeight: FontWeight.bold),
                          //     ),
                          //   ),
                          // ),
                          SizedBox(
                            // height: 157,
                            height: Get.height * 0.1,
                          ),
                          FadeInRight(
                            animate: true,
                            child: Row(
                              children: [
                                const Flexible(
                                  child: Text(
                                    "Welcome",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: AppColor.white_Color, fontSize: 32, fontFamily: "Rubik"),
                                  ),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                const Flexible(
                                  child: Text(
                                    "Back",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: AppColor.light_blue, fontSize: 32, fontFamily: "Rubik"),
                                  ),
                                )
                              ],
                            ),
                          ),
                          FadeInUp(
                            animate: true,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 28.h,
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
                                  controller: _loginController.emailController,
                                  prefixIcon: Container(
                                      margin: const EdgeInsets.only(top: 15, bottom: 15, left: 5),
                                      child: Image.asset(
                                        AppImages.login_person_Icon,
                                        height: 3.h,
                                      )),
                                  hint: "Email",
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Obx(
                                  () => CommonTextFormFiiled(
                                    isObscureText: _loginController.isVisible.value,
                                    textInputAction: TextInputAction.done,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    focusNode: FocusNode(),
                                    validator: (value) {
                                      if (value == null || (!isValidPassword(value, isRequired: true))) {
                                        return "Password must be at least 8 characters and a combination of small & capital letters, digits and special character";
                                      }
                                      return null;
                                    },
                                    controller: _loginController.passwordController,
                                    prefixIcon: Container(
                                        padding: const EdgeInsets.only(top: 15, bottom: 15, left: 5),
                                        child: Image.asset(AppImages.login_lock_Icon, height: 3.h)),
                                    hint: "Password",
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        _loginController.isVisible.value = !_loginController.isVisible.value;
                                      },
                                      child: Container(
                                          child: _loginController.isVisible.value == true
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
                                  height: 15.h,
                                ),
                                CommonButton(
                                  bgColor: AppColor.white_Color,
                                  onTap: () {
                                    _loginController.onTapLogin();
                                    // Get.toNamed(AppRoutes.bottom_nav_Screen);
                                  },
                                  text: "Log In",
                                  textStyle: const TextStyle(fontFamily: "Rubik", fontSize: 14, fontWeight: FontWeight.w500),
                                ),

                                // InkWell(onTap: (){
                                //   Get.toNamed(AppRoutes.register_Screen);
                                // },
                                //   child: Container(
                                //     margin: EdgeInsets.only(left: 10,right: 10),
                                //     height: Get.height*0.06,
                                //     width: Get.width,
                                //     decoration: BoxDecoration(
                                //       color: AppColor.white_Color,
                                //       borderRadius: BorderRadius.circular(5),
                                //     ),
                                //     child: const Center(child: Text("LogIn",style: TextStyle(fontFamily: "Rubik",fontSize: 14),)),
                                //   ),
                                // ),
                                SizedBox(
                                  height: 35.h,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.recovery_password);
                                  },
                                  child: const Center(
                                    child: Text(
                                      "Forget Password?",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontFamily: "Rubik", fontSize: 15, color: AppColor.grey),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                const Text(
                                  "Or",
                                  style: TextStyle(fontFamily: "Rubik", fontSize: 15, color: AppColor.white_Color),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 8.w, right: 8.w),
                                      height: Get.height * 0.001,
                                      width: Get.width * 0.25,
                                      color: AppColor.white_Color,
                                    ),
                                    const Text(
                                      "Sign up with",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontFamily: "Rubik", fontSize: 15, color: AppColor.grey),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 8.w, right: 8.w),
                                      height: Get.height * 0.001,
                                      width: Get.width * 0.25,
                                      color: AppColor.white_Color,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Visibility(
                                  visible: GetPlatform.isIOS ? true : false,
                                  child: GestureDetector(
                                    onTap: () {
                                      _loginController.signInWithApple();
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 8.h),
                                      height: Get.height * 0.06,
                                      width: Get.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(color: AppColor.white_Color),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.apple,
                                            color: AppColor.white_Color,
                                          ),
                                          SizedBox(
                                            width: 12.h,
                                          ),
                                          const Text(
                                            "Sign in with Apple",
                                            style: TextStyle(fontFamily: "Rubik", fontSize: 14, color: AppColor.white_Color),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                CommonButton(
                                  border: Border.all(color: AppColor.white_Color),
                                  image: AppImages.google_Icon,
                                  text: "Login with Google",
                                  onTap: () {
                                    _loginController.googleSignInProcess();
                                  },
                                  textStyle: const TextStyle(fontFamily: "Rubik", fontSize: 14, color: AppColor.white_Color),
                                ),
                                // SizedBox(
                                //   height: 10.h,
                                // ),
                                // CommonButton(
                                //   border: Border.all(color: AppColor.white_Color),
                                //   image: AppImages.facebook_Icon,
                                //   text: "Login with Facebook",
                                //   textStyle: const TextStyle(fontFamily: "Rubik", fontSize: 14, color: AppColor.white_Color),
                                // ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Flexible(
                                      child: Text(
                                        "Don't have an account?",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontFamily: "Sora", fontSize: 15, color: AppColor.white_Color),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.toNamed(AppRoutes.register_Screen);
                                      },
                                      child: const Text(
                                        "Sign Up",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontFamily: "Sora", fontSize: 15, color: AppColor.white_Color),
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
              ],
            ),
          ),
        ));
  }
}
