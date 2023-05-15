import 'dart:io';

import 'package:event_booking/res/appImages.dart';
import 'package:event_booking/res/colors.dart';
import 'package:event_booking/screens/profile/controller/profile_controller.dart';
import 'package:event_booking/utils/commonMethods.dart';
import 'package:event_booking/utils/widgets/common_Button.dart';
import 'package:event_booking/utils/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/phone_number_us_formatter.dart';
import '../../utils/validation_functions.dart';
import '../../utils/widgets/common_Text_Widgets.dart';

class ProfileScreen extends StatelessWidget {
  final _controller = Get.put(ProfileController());
  final arguments = Get.arguments;
  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          CommonMethods.getInstance().hideKeyboard();
        },
        child: Container(
          padding: EdgeInsets.only(left: 20.h, right: 20.h, top: 20.h),
          height: Get.height,
          width: Get.width,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _controller.updateProfileKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SettingsCommonAppBar(
                      text: "Profile",
                    ),
                    SizedBox(
                      height: 41.h,
                    ),

                    Stack(children: [
                      Hero(
                        transitionOnUserGestures: true,
                        tag: arguments[0],
                        child: Obx(
                          () => _controller.pickImage.isEmpty
                              ? Container(
                                  height: 123,
                                  width: 123,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image:
                                          // _controller.pickImage.value == null ?
                                          DecorationImage(image: NetworkImage(_controller.updatedImage.toString()), fit: BoxFit.fill
                                              // AssetImage(_controller.imageFileList == null ? arguments[0] : _controller.imageFileList.toString()),
                                              ))
                                  // child: _controller.pickImage.toString().isNotEmpty ? Image.file(File(_controller.pickImage.toString())) : arguments[0],
                                  )
                              : Container(
                                  height: 123,
                                  width: 123,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(image: FileImage(File(_controller.pickImage.value)), fit: BoxFit.fill),
                                  )
                                  // child: _controller.pickImage.toString().isNotEmpty ? Image.file(File(_controller.pickImage.toString())) : arguments[0],
                                  ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 5,
                        child: InkWell(
                          onTap: () {
                            _controller.pickImageGallery();
                          },
                          child: Container(
                            height: 30.h,
                            width: 30.h,
                            decoration: const BoxDecoration(
                                image: DecorationImage(image: AssetImage(AppImages.edit_profile_Icon), fit: BoxFit.fill)),
                          ),
                        ),
                      )
                    ]),
                    SizedBox(
                      height: 53.h,
                    ),
                    CommonTextFormFilled2(
                      focusNode: FocusNode(),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _controller.firstNameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter first name";
                        }
                        return null;
                      },
                      hint: "First Name",
                    ),

                    CommonTextFormFilled2(
                      focusNode: FocusNode(),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _controller.lastNameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter last name";
                        }
                        return null;
                      },
                      hint: "Last Name",
                    ),
                    // SizedBox(
                    //   height: 18.h,
                    // ),
                    // CommonTextFormFilled2(
                    //   controller: _controller.emailController,
                    //   hint: "john@gmail.com",
                    // ),

                    CommonTextFormFilled2(
                      keyboardType: TextInputType.number,
                      inputFormatter: [PhoneNumberFormatter()],
                      maxLength: 12,
                      focusNode: FocusNode(),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _controller.phoneNumberController,
                      hint: "Phone Number (Optinal)",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return null;
                        } else if (!isValidphoneInUSFormat(value)) {
                          return "please enter valid phone number";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 18.h,
                    ),
                    CommonButton(
                      onTap: () {
                        _controller.onTapUpdateProfile();
                      },
                      bgColor: AppColor.white_Color,
                      text: "Save",
                      textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: "Roboto"),
                    )
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
