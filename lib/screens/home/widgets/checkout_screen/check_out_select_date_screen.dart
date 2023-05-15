import 'dart:developer';

import 'package:event_booking/app_style/app_style.dart';
import 'package:event_booking/res/appImages.dart';
import 'package:event_booking/res/colors.dart';
import 'package:event_booking/screens/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CheckOutScreenSelectDate extends StatelessWidget {
  const CheckOutScreenSelectDate({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(), //get today's date
                firstDate: DateTime.now(), // - not to allow to choose before today.
                // firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                lastDate: DateTime(2101));
            if (pickedDate != null) {
              // print(pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
              String formattedDate = DateFormat('MM/dd/yyyy')
                  .format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
              // print(formattedDate); //formatted date output using intl package =>  2022-07-04
              //You can format date as per your need

              controller.checkOutSelectDate.value = formattedDate; //set foratted date to TextField value.
            } else {
              log("Date is not selected");
            }
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 9),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            height: 42,
            decoration: BoxDecoration(color: AppColor.light_grey.withOpacity(0.3), borderRadius: BorderRadius.circular(18)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  controller.checkOutSelectDate.value,
                  style: AppTextStyle.textStyle14Roboto500white,
                ),
                SizedBox(
                  height: 21,
                  width: 21,
                  child: Image.asset(AppImages.calendarIcon),
                ),
              ],
            ),
          ),
        ));
  }
}
