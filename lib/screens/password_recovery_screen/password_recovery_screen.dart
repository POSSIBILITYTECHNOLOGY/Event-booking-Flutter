import 'package:animate_do/animate_do.dart';
import 'package:event_booking/screens/password_recovery_screen/controller/password_recovery_controller.dart';
import 'package:event_booking/utils/commonMethods.dart';
import 'package:event_booking/utils/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../res/appImages.dart';
import '../../res/colors.dart';
import '../../utils/validation_functions.dart';
import '../../utils/widgets/common_Button.dart';
import '../../utils/widgets/common_Text_Widgets.dart';

class PasswordRecoveryScreen extends StatelessWidget {
  final PasswordRecoveryController _passwordRecoveryController = PasswordRecoveryController();
  PasswordRecoveryScreen({Key? key}) : super(key: key);

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
              decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(AppImages.login_bg_image), fit: BoxFit.fill)),
            ),
            Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(end: Alignment.bottomCenter, begin: Alignment.topCenter, colors: [
              Colors.black.withOpacity(1),
              Colors.black.withOpacity(1),
              Colors.black.withOpacity(1),
              Colors.black.withOpacity(1),
              Colors.grey.shade800.withOpacity(0.8),
              Colors.grey.withOpacity(0.5),
              Colors.grey.withOpacity(0.5),
              Colors.grey.withOpacity(0.5),
            ]))),
            SingleChildScrollView(
              child: Form(
                key: _passwordRecoveryController.recoveryformKey,
                child: Container(
                  padding: EdgeInsets.only(left: 20.h, right: 20.h, top: 10.h),
                  child: Column(
                    children: [
                      const CommonBackButtom(),
                      SizedBox(
                        height: 60.h,
                      ),
                      FadeInRight(
                        animate: true,
                        child: Row(
                          children: [
                            const Flexible(
                              child: Text(
                                "Password",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: AppColor.white_Color, fontSize: 32, fontFamily: "Rubik"),
                              ),
                            ),
                            SizedBox(
                              width: 5.h,
                            ),
                            const Flexible(
                              child: Text(
                                "Recovery",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: AppColor.light_blue, fontSize: 32, fontFamily: "Rubik"),
                              ),
                            ),
                          ],
                        ),
                      ),
                      FadeInUp(
                        animate: true,
                        child: Column(
                          children: [
                            SizedBox(
                                width: Get.width,
                                child: const Text(
                                  "Please enter a valid email to reset your password",
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(fontFamily: "Rubik", fontSize: 14, color: AppColor.grey),
                                )),
                            SizedBox(
                              height: 25.h,
                            ),
                            CommonTextFormFiiled(
                              controller: _passwordRecoveryController.emailContoller,
                              textInputAction: TextInputAction.done,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              focusNode: FocusNode(),
                              validator: (value) {
                                if (!isValidEmail(value)) {
                                  return "Please enter valid email";
                                }
                                return null;
                              },
                              prefixIcon: Container(
                                  margin: const EdgeInsets.only(top: 15, bottom: 15, left: 5),
                                  child: Image.asset(
                                    AppImages.login_person_Icon,
                                    height: 14.h,
                                  )),
                              hint: "Email",
                            ),
                            SizedBox(
                              height: 40.h,
                            ),
                            CommonButton(
                              bgColor: AppColor.white_Color,
                              onTap: () {
                                _passwordRecoveryController.onTapRecovery();
                                // _passwordRecoveryController.forgetPassword();
                              },
                              text: "Confirm Selection",
                              textStyle: const TextStyle(fontFamily: "Rubik", fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      )
                    ],
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
