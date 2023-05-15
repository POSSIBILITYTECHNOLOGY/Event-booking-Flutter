import 'package:event_booking/app_style/app_style.dart';
import 'package:event_booking/screens/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckOutScreenYourReciept extends StatelessWidget {
  const CheckOutScreenYourReciept({
    super.key,
    required this.eventName,
    required this.controller,
    required this.price,
  });

  final String eventName;
  final HomeController controller;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "your reciept".toUpperCase(),
          style: AppTextStyle.textStyle20Roboto400white,
        ),
        SizedBox(
          height: 10.h,
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text(
        //       "DATE",
        //       // "E- TICKET : MVF 2023",
        //       style: AppTextStyle.textStyle13Roboto400purple,
        //     ),
        //     Text(
        //       DateFormat('dd MMMM yyyy').format(DateTime.now()),
        //       style: AppTextStyle.textStyle18Roboto400white,
        //     ),
        //   ],
        // ),
        // SizedBox(
        //   height: 15.h,
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                eventName,
                style: AppTextStyle.textStyle20Roboto400white,
              ),
            ),
            Text(
              "1 X ${controller.ticketCount.value.toString()}",
              style: AppTextStyle.textStyle18Roboto400white,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "\$$price",
              style: AppTextStyle.textStyle18Roboto400white,
            ),
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total Paid : ",
              style: AppTextStyle.textStyle25Roboto400purple,
            ),
            Text(
              "\$${controller.ticketCount.value * (double.parse(price))}",
              style: AppTextStyle.textStyle20Roboto700white,
            ),
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }
}
