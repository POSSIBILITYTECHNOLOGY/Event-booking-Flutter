import 'dart:developer';

import 'package:event_booking/app_style/app_style.dart';
import 'package:event_booking/res/colors.dart';
import 'package:event_booking/screens/home/controller/home_controller.dart';
import 'package:event_booking/utils/widgets/common_Text_Widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddNewCardScreen extends StatelessWidget {
  final HomeController controller;
  const AddNewCardScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              margin: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 38.h,
                      width: 38.w,
                      decoration: BoxDecoration(color: AppColor.medium_grey, borderRadius: BorderRadius.circular(10.r)),
                      child: const Icon(
                        Icons.arrow_back_ios_new_outlined,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    "Add New Card",
                    style: AppTextStyle.textStyle24Roboto700white,
                  ),
                  SizedBox(
                    height: 38.h,
                    width: 38.w,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: controller.formKeyAddNewCard,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonTextFormFilled2(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your first name.';
                      }
                      return null;
                    },
                    controller: controller.firstNameOnCardController.value,
                    top: 20,
                    hint: "First Name",
                  ),
                  CommonTextFormFilled2(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your last name.';
                      }
                      return null;
                    },
                    controller: controller.lastNameOnCardController.value,
                    top: 0,
                    hint: "Last Name",
                  ),
                  CommonTextFormFilled2(
                    keyboardType: TextInputType.number,
                    maxLength: 19,
                    inputFormatter: [CreditCardFormatter()],
                    validator: (value) {
                      // print(value!.length);
                      if (value!.isEmpty) {
                        return 'Please enter card number';
                      }
                      // Remove any whitespace or dashes from the input string

                      if (value.length < 19) {
                        return 'Invalid card number';
                      }
                      // Validate the credit card number using the Luhn algorithm

                      return null;
                    },
                    controller: controller.cardNumberController.value,
                    top: 0,
                    hint: "Card Number",
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CommonTextFormFilled2(
                          keyboardType: TextInputType.number,
                          controller: controller.cardExpiryController.value,
                          top: 0,
                          hint: "Expiry Date",
                          inputFormatter: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(4),
                            ExpiryDateFormatter(),
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Expiry date is required';
                            }
                            // Check if the value matches the format "MM/YY"
                            final RegExp regExp = RegExp(r'^\d{2}\/\d{2}$');
                            if (!regExp.hasMatch(value)) {
                              return 'Invalid expiry date format. Please enter in MM/YY format';
                            }
                            // Check if the month is between 1 and 12
                            int month = int.parse(value.split('/')[0]);
                            if (month < 1 || month > 12) {
                              return 'Invalid month. Please enter a value between 01 and 12';
                            }
                            // Check if the year is greater than or equal to current year
                            String yearStr = value.split('/')[1];
                            int year = int.parse(yearStr);

                            int currentYear = DateTime.now().year % 100; // Get the last two digits of the current year
                            if (year < currentYear) {
                              return 'Card has expired';
                            }

                            controller.cardExpiryYearController.value.text = "20$yearStr";
                            controller.cardExpiryMonthController.value.text = month.toString();
                            return null; // Return null if validation succeeds
                          },
                        ),
                      ),
                      SizedBox(
                        width: 5.h,
                      ),
                      Expanded(
                        child: CommonTextFormFilled2(
                          maxLength: 3,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a CVV code';
                            }
                            if (value.length != 3 || int.tryParse(value) == null) {
                              return 'Invalid CVV code';
                            }
                            return null;
                          },
                          controller: controller.cardCVVController.value,
                          top: 0,
                          hint: "CVV",
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      log("${controller.cardNumberController.value.text.replaceAll(" ", "").length}");
                      controller.onTapAddNewCard();
                    },
                    child: Container(
                      height: 44.h,
                      // width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        color: Colors.white,
                      ),
                      // margin: const EdgeInsets.only(bottom: 10),
                      child: Center(
                          child: Text(
                        "Add New Card",
                        style: AppTextStyle.textStyle14Roboto500black,
                      )),
                    ),
                  ),
                  SizedBox(height: 15.h),
                ],
              ),
            ),
          ),
        ));
  }
}

class ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var newString = newValue.text.replaceAll('/', '');

    if (newString.length >= 3) {
      newString = '${newString.substring(0, 2)}/${newString.substring(2)}';
    }

    return newValue.copyWith(text: newString, selection: TextSelection.collapsed(offset: newString.length));
  }
}

class CreditCardFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove any whitespace or dashes from the input string
    String value = newValue.text.replaceAll(RegExp(r'[\s-]+'), '');
    if (value.length > 16) {
      // Truncate long input
      value = value.substring(0, 16);
    }
    // Insert spaces after every 4 digits
    value = value.replaceAllMapped(
      RegExp(r'\d{4}'),
      (match) => '${match[0]} ',
    );
    // Trim any trailing space
    value = value.trimRight();
    return TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(
        offset: value.length,
      ),
    );
  }
}
