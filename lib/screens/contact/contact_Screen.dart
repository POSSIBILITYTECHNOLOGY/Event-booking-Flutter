// ignore_for_file: file_names

import 'package:event_booking/res/colors.dart';
import 'package:event_booking/screens/contact/controller/contact_controller.dart';
import 'package:event_booking/utils/commonMethods.dart';
import 'package:event_booking/utils/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/validation_functions.dart';
import '../../utils/widgets/common_Button.dart';
import '../../utils/widgets/common_Text_Widgets.dart';

class ContactScreen extends StatelessWidget {
  final contactController = Get.put(ContactController());
  ContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            CommonMethods.getInstance().hideKeyboard();
          },
          child: Form(
            key: contactController.contactformKey,
            child: Container(
              padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 20.h),
              height: Get.height,
              width: Get.width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SettingsCommonAppBar(
                      text: "Contact Us",
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CommonTextFormFilled2(
                      errorColor: Colors.white,
                      controller: contactController.firstNameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter first name";
                        }
                        return null;
                      },
                      // prefixIcon: Container(
                      //     padding:
                      //     const EdgeInsets.only(top: 15, bottom: 15, left: 5),
                      //     child:
                      //     Image.asset(AppImages.login_lock_Icon, height: 2)),
                      hint: "First Name",
                      // suffixIcon: const Icon(
                      //   Icons.remove_red_eye_outlined,
                      //   color: AppColor.grey,
                      // ),
                    ),
                    CommonTextFormFilled2(
                      errorColor: Colors.white,
                      controller: contactController.lastNameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter last name";
                        }
                        return null;
                      },
                      // prefixIcon: Container(
                      //     padding:
                      //     const EdgeInsets.only(top: 15, bottom: 15, left: 5),
                      //     child:
                      //     Image.asset(AppImages.login_lock_Icon, height: 2)),
                      hint: "Last Name",
                      // suffixIcon: const Icon(
                      //   Icons.remove_red_eye_outlined,
                      //   color: AppColor.grey,
                      // ),
                    ),
                    CommonTextFormFilled2(
                      errorColor: Colors.white,
                      controller: contactController.emailController,
                      validator: (value) {
                        if (!isValidEmail(value)) {
                          return "Please enter valid email";
                        }
                        return null;
                      },
                      // prefixIcon: Container(
                      //     padding:
                      //     const EdgeInsets.only(top: 15, bottom: 15, left: 5),
                      //     child:
                      //     Image.asset(AppImages.login_lock_Icon, height: 2)),
                      hint: "Email",
                      // suffixIcon: const Icon(
                      //   Icons.remove_red_eye_outlined,
                      //   color: AppColor.grey,
                      // ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      width: double.infinity,
                      height: 154,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: AppColor.light_grey)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextFormField(
                          textInputAction: TextInputAction.done,
                          style: const TextStyle(color: AppColor.white_Color),
                          // validator: (value){
                          //   if(value!.isEmpty){
                          //     return "please enter message";
                          //   }
                          //   return null;
                          // },
                          maxLines: 5,
                          minLines: 1,
                          controller: contactController.messageController,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 8, left: 10),
                              hintStyle: TextStyle(color: AppColor.grey, fontFamily: "Sora", fontSize: 14),
                              hintText: "Message",
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    CommonButton(
                      bgColor: AppColor.white_Color,
                      onTap: () {
                        contactController.onTapSendMessage();
                        // Get.toNamed(AppRoutes.bottom_nav_Screen);
                      },
                      text: "Submit",
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
