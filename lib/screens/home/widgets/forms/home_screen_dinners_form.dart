import 'dart:developer';

import 'package:event_booking/app_style/app_style.dart';
import 'package:event_booking/screens/home/controller/home_controller.dart';
import 'package:event_booking/screens/home/widgets/widgets.dart';
import 'package:event_booking/utils/commonMethods.dart';
import 'package:event_booking/utils/validation_functions.dart';
import 'package:event_booking/utils/widgets/common_Text_Widgets.dart';
import 'package:event_booking/utils/widgets/common_Widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeScreenDinnersForm extends StatelessWidget {
  final HomeController controller;
  const HomeScreenDinnersForm({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () {
          CommonMethods.getInstance().hideKeyboard();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Form(
              key: controller.formKeyDinners,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CommonBackButtom(),
                      Center(
                        child: Text(
                          "Reservation For Dinner",
                          style: AppTextStyle.textStyle18Roboto400white,
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                        width: 50,
                      )
                    ],
                  ),
                  CommonTextFormFilled2(
                    errorColor: Colors.white,
                    controller: controller.venueDinner.value,
                    hint: "Venue",
                    top: 20,
                    validator: (value) {
                      return value!.isEmpty ? "Please enter venue" : null;
                    },
                  ),
                  CommonTextFormFilled2(
                    errorColor: Colors.white,
                    controller: controller.nameDinner.value,
                    hint: "Name",
                    keyboardType: TextInputType.name,
                    top: 0,
                    validator: (value) {
                      return value!.isEmpty ? "Please enter name" : null;
                    },
                  ),
                  Obx(() => InkWell(
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(), //get today's date
                              firstDate: DateTime.now(), // - not to allow to choose before today.
                              // firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));
                          if (pickedDate != null) {
                            // print(pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                            String formattedDate = DateFormat('yyyy-MM-dd')
                                .format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                            // print(formattedDate); //formatted date output using intl package =>  2022-07-04
                            //You can format date as per your need

                            controller.dateDinner.value.text = formattedDate; //set foratted date to TextField value.
                          } else {
                            log("Date is not selected");
                          }
                        },
                        child: CommonTextFormFilled2(
                          enabled: false,
                          errorColor: Colors.white,
                          controller: controller.dateDinner.value,
                          hint: "Date",
                          top: 0,
                          validator: (value) {
                            return value!.isEmpty ? "Please enter date" : null;
                          },
                        ),
                      )),
                  Obx(() => GestureDetector(
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                          if (pickedTime != null) {
                            String formattedTime =
                                '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                            controller.timeDinner.value.text = formattedTime;
                          }
                        },
                        child: CommonTextFormFilled2(
                          enabled: false,
                          errorColor: Colors.white,
                          controller: controller.timeDinner.value,
                          keyboardType: TextInputType.datetime,
                          hint: "Time",
                          top: 0,
                          validator: (value) {
                            return value!.isEmpty ? "Please enter time" : null;
                          },
                        ),
                      )),
                  CommonTextFormFilled2(
                    errorColor: Colors.white,
                    controller: controller.partySizeDinner.value,
                    hint: "Party Size",
                    keyboardType: TextInputType.number,
                    top: 0,
                    validator: (value) {
                      return value!.isEmpty ? "Please enter party size" : null;
                    },
                  ),
                  CommonTextFormFilled2(
                    errorColor: Colors.white,
                    controller: controller.numberDinner.value,
                    hint: "Number",
                    keyboardType: TextInputType.number,
                    top: 0,
                    validator: (value) {
                      return value!.isEmpty ? "Please enter number" : null;
                    },
                  ),
                  CommonTextFormFilled2(
                    errorColor: Colors.white,
                    controller: controller.emailDinner.value,
                    keyboardType: TextInputType.emailAddress,
                    hint: "Email",
                    top: 0,
                    validator: (value) {
                      if (!isValidEmail(value)) {
                        return "Please enter valid email";
                      }
                      return null;
                    },
                  ),
                  HomeScreenFormButton(onTap: formOnTap),
                  SizedBox(
                    height: 10.h,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void formOnTap() {
    var body = {
      "category_id": "3",
      "venue": controller.venueDinner.value.text,
      "full_name": "",
      "date": controller.dateDinner.value.text,
      "time": controller.timeDinner.value.text,
      "name": controller.nameDinner.value.text,
      "cell": "",
      "number": controller.numberDinner.value.text,
      "email": controller.emailDinner.value.text,
      "no_of_people": "",
      "minimum_spend": "",
      "table_name": "",
      "party_size": controller.partySizeDinner.value.text,
      "group_size": ""
    };
    if (controller.formKeyDinners.currentState!.validate()) {
      controller.reservationBooking(body);
    } else {
      log("Error");
    }
  }
}
