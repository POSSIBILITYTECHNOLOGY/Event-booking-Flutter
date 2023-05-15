import 'package:event_booking/app_style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckOutScreenHeader extends StatelessWidget {
  const CheckOutScreenHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Payment", style: AppTextStyle.textStyle16Roboto500purple),
        SizedBox(height: 10.h),
        Text("Tab edit to reorder or remove a payment method", style: AppTextStyle.textStyle14Roboto400lightGrey),
        SizedBox(height: 20.h),
      ],
    );
  }
}
