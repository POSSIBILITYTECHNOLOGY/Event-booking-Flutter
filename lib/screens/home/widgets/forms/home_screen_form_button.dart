import 'package:event_booking/app_style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreenFormButton extends StatelessWidget {
  final void Function()? onTap;
  const HomeScreenFormButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
          "Submit",
          style: AppTextStyle.textStyle14Roboto500black,
        )),
      ),
    );
  }
}
