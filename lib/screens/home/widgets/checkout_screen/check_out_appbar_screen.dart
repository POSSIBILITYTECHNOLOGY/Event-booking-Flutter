import 'package:event_booking/app_style/app_style.dart';
import 'package:event_booking/res/colors.dart';
import 'package:event_booking/screens/home/controller/home_controller.dart';
import 'package:event_booking/screens/home/screens/add_card_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CheckOutScreenAppBar extends StatelessWidget {
  const CheckOutScreenAppBar({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
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
              "Check Out",
              style: AppTextStyle.textStyle24Roboto700white,
            ),
            InkWell(
              onTap: () {
                Get.to(() => AddNewCardScreen(controller: controller));
              },
              child: Container(
                height: 38.h,
                width: 38.w,
                decoration: BoxDecoration(color: AppColor.medium_grey, borderRadius: BorderRadius.circular(10.r)),
                child: const Icon(
                  Icons.add,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
