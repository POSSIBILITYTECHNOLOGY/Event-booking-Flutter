import 'dart:developer';

import 'package:event_booking/app_style/app_style.dart';
import 'package:event_booking/res/appImages.dart';
import 'package:event_booking/res/colors.dart';
import 'package:event_booking/screens/bottom_nav_bar/controller/bottom_nav_controller.dart';
import 'package:event_booking/screens/home/controller/home_controller.dart';
import 'package:event_booking/screens/home/widgets/checkout_screen/checkout_screen.dart';
import 'package:event_booking/utils/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CheckOutScreen extends StatelessWidget {
  final HomeController controller;
  final String price, eventName, id, categoryId;
  const CheckOutScreen(
      {super.key, required this.controller, required this.id, required this.eventName, required this.price, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    // controller.cardList.refresh();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          flexibleSpace: CheckOutScreenAppBar(controller: controller),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // * Header
                const CheckOutScreenHeader(),
                CheckOutScreenCardList(controller: controller),
                SizedBox(
                  height: 30.h,
                ),
                // * Calendar Date Select
                CheckOutScreenSelectDate(controller: controller),
                SizedBox(height: 29.h),
                // * Reciept
                CheckOutScreenYourReciept(eventName: eventName, controller: controller, price: price),
                // * Button
                InkWell(
                  onTap: () async {
                    if (controller.checkOutSelectDate.value == "Select Date") {
                      showSnackBar("What's Poppin", "Please Select Date First", AppColor.light_grey);
                    } else if (controller.currentCardbId.value == "") {
                      showSnackBar("What's Poppin", "Please add payment method", AppColor.light_grey);
                    } else {
                      log("checkout screen Button ${controller.currentCardbId.value}");
                      await controller.checkOutPayButton({
                        "event_id": id.toString(),
                        "card_id": controller.currentCardbId.value,
                        "total_ticket": controller.ticketCount.value.toString(),
                      }).then((value) {
                        if (value) {
                          _payButtonOnTap();
                        } else {
                          return false;
                        }
                      });
                    }
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
                      "Pay",
                      style: AppTextStyle.textStyle14Roboto500black,
                    )),
                  ),
                ),
                SizedBox(height: 15.h),
              ],
            ),
          ),
        ));
  }

  void _payButtonOnTap() {
    Get.dialog(Container(
      padding: EdgeInsets.only(left: 18.w, right: 18.w),
      margin: EdgeInsets.only(top: 130.h, bottom: 170.h, left: 30.w, right: 30.w),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(17), color: AppColor.medium_grey),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10.h, left: 50.w, right: 50.w),
              height: 170.h,
              width: Get.width,
              decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(AppImages.popup_Image), fit: BoxFit.contain)),
            ),
            const Text(
              "Payment Sucessful\n Thank you for your booking",
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  overflow: TextOverflow.clip,
                  decoration: TextDecoration.none,
                  fontSize: 25,
                  color: AppColor.white_Color,
                  fontFamily: "Roboto"),
            ),
            SizedBox(
              height: 10.h,
            ),
            MaterialButton(
              onPressed: () async {
                Get.find<BottomNavigationController>().viewTicketClick();
                // Get.toNamed(AppRoutes.bottom_nav_Screen_View_Ticket);
              },
              child: Container(
                height: 37,
                width: Get.width,
                decoration: BoxDecoration(
                    color: AppColor.white_Color, borderRadius: BorderRadius.circular(5), border: Border.all(color: AppColor.white_Color)),
                child: const Center(
                    child: Text("View Ticket",
                        style: TextStyle(
                            overflow: TextOverflow.clip,
                            decoration: TextDecoration.none,
                            fontSize: 14,
                            color: Colors.black,
                            fontFamily: "Roboto"))),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
