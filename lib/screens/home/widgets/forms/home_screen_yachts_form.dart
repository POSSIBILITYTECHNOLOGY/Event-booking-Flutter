import 'dart:developer';

import 'package:event_booking/app_style/app_style.dart';
import 'package:event_booking/screens/home/controller/home_controller.dart';
import 'package:event_booking/screens/home/widgets/widgets.dart';
import 'package:event_booking/utils/commonMethods.dart';
import 'package:event_booking/utils/widgets/common_Text_Widgets.dart';
import 'package:event_booking/utils/widgets/common_Widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'home_screen_form_button.dart';

class HomeScreenYachtForm extends StatelessWidget {
  final HomeController controller;
  const HomeScreenYachtForm({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          CommonMethods.getInstance().hideKeyboard();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Form(
              key: controller.formKeyYacht,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CommonBackButtom(),
                      Center(
                        child: Text(
                          "Reservation For Yachts",
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
                    controller: controller.nameYacht.value,
                    hint: "Name",
                    top: 20,
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

                            controller.dateYacht.value.text = formattedDate; //set foratted date to TextField value.
                          } else {
                            log("Date is not selected");
                          }
                        },
                        child: CommonTextFormFilled2(
                          enabled: false,
                          errorColor: Colors.white,
                          controller: controller.dateYacht.value,
                          hint: "Date",
                          top: 0,
                          validator: (value) {
                            return value!.isEmpty ? "Please enter date" : null;
                          },
                        ),
                      )),
                  CommonTextFormFilled2(
                    errorColor: Colors.white,
                    controller: controller.numberOfPeopleYacht.value,
                    hint: "Number of people",
                    counterText: "Group size Max of 13 people",
                    keyboardType: TextInputType.number,
                    top: 0,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter number of people";
                      } else if (int.parse(value) > 13) {
                        return "Group size should be a maximum of 13 people";
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
      "category_id": "2",
      "venue": controller.nameYacht.value.text,
      "full_name": "",
      "date": controller.dateYacht.value.text,
      "time": "",
      "name": "",
      "cell": "",
      "number": "",
      "email": "",
      "no_of_people": "",
      "minimum_spend": "",
      "table_name": "",
      "party_size": "",
      "group_size": controller.numberOfPeopleYacht.value.text
    };
    if (controller.formKeyYacht.currentState!.validate()) {
      controller.reservationBooking(body);
    } else {
      log("Error");
    }
  }
}
