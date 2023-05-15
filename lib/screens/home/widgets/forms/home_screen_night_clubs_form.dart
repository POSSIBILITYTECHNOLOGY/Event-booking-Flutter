// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:event_booking/app_style/app_style.dart';
import 'package:event_booking/screens/home/controller/home_controller.dart';
import 'package:event_booking/utils/commonMethods.dart';
import 'package:event_booking/utils/validation_functions.dart';
import 'package:event_booking/utils/widgets/common_Text_Widgets.dart';
import 'package:event_booking/utils/widgets/common_Widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'home_screen_form_button.dart';

class HomeScreenNightClubsForm extends StatelessWidget {
  final HomeController controller;
  const HomeScreenNightClubsForm({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          CommonMethods.getInstance().hideKeyboard();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Form(
              key: controller.formKeyNightClub,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CommonBackButtom(),
                      Center(
                        child: Text(
                          "Reservation For Night Clubs",
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
                    controller: controller.venueNightClub.value,
                    hint: "Venue",
                    top: 20,
                    validator: (value) {
                      return value!.isEmpty ? "Please enter venue" : null;
                    },
                  ),
                  Obx(() => GestureDetector(
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

                            controller.dateNightClub.value.text = formattedDate; //set foratted date to TextField value.
                          } else {
                            log("Date is not selected");
                          }
                        },
                        child: CommonTextFormFilled2(
                          enabled: false,
                          errorColor: Colors.white,
                          controller: controller.dateNightClub.value,
                          hint: "Date",
                          top: 0,
                          validator: (value) {
                            return value!.isEmpty ? "Please enter date" : null;
                          },
                        ),
                      )),
                  CommonTextFormFilled2(
                    errorColor: Colors.white,
                    controller: controller.emailNightClub.value,
                    hint: "Email",
                    top: 0,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (!isValidEmail(value)) {
                        return "Please enter valid email";
                      }
                      return null;
                    },
                  ),
                  CommonTextFormFilled2(
                    errorColor: Colors.white,
                    controller: controller.cellNightClub.value,
                    keyboardType: TextInputType.phone,
                    hint: "Phone number (optional)",
                    top: 0,
                    // validator: (value) {
                    //   return value!.isEmpty ? "Please enter cell" : null;
                    // },
                  ),
                  CommonTextFormFilled2(
                    errorColor: Colors.white,
                    controller: controller.numberOfPeopleNightClub.value,
                    keyboardType: TextInputType.number,
                    hint: "Number of people w/ratio- guys girls ",
                    top: 0,
                    validator: (value) {
                      return value!.isEmpty ? "Please enter number of people" : null;
                    },
                  ),
                  CommonTextFormFilled2(
                    errorColor: Colors.white,
                    controller: controller.minimumSpendNightClub.value,
                    keyboardType: TextInputType.number,
                    hint: "Minimum spend",
                    top: 0,
                    validator: (value) {
                      return value!.isEmpty ? "Please enter minumum spend" : null;
                    },
                  ),
                  CommonTextFormFilled2(
                    errorColor: Colors.white,
                    controller: controller.nameOfTableNightClub.value,
                    keyboardType: TextInputType.text,
                    hint: "Name of table",
                    top: 0,
                    validator: (value) {
                      return value!.isEmpty ? "Please enter number of table" : null;
                    },
                  ),
                  HomeScreenFormButton(
                    onTap: formOnTap,
                  ),
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
      "category_id": "4",
      "venue": controller.venueNightClub.value.text,
      "full_name": "",
      "date": controller.dateNightClub.value.text,
      "time": "",
      "name": "",
      "cell": controller.cellNightClub.value.text,
      "number": "",
      "email": controller.emailNightClub.value.text,
      "no_of_people": controller.numberOfPeopleNightClub.value.text,
      "minimum_spend": controller.minimumSpendNightClub.value.text,
      "table_name": controller.nameOfTableNightClub.value.text,
      "party_size": "",
      "group_size": ""
    };
    if (controller.formKeyNightClub.currentState!.validate()) {
      controller.reservationBooking(body);
    } else {
      log("Error");
    }
  }
}
