import 'package:animate_do/animate_do.dart';
import 'package:event_booking/res/appImages.dart';
import 'package:event_booking/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 70,
            child: Container(
              height: Get.height,
              width: Get.width,
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage(AppImages.splash_bg_image), fit: BoxFit.contain),
              ),
              // child: Image.asset(AppImages.splash_gradient_image,fit: BoxFit.cover,),
            ),
          ),
          Container(
            height: Get.height,
            width: Get.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(end: Alignment.center, begin: Alignment.topCenter, colors: [
              Colors.black.withOpacity(1),
              Colors.black.withOpacity(1),
              Colors.black.withOpacity(0.8),
              Colors.black.withOpacity(0.3),
              AppColor.light_blue.withOpacity(0.06)
            ])),
          ),
          Positioned(
            top: 64,
            left: 100,
            right: 100,
            child: FadeInDown(
              duration: const Duration(seconds: 1),
              child: Column(
                children: [
                  Image.asset(
                    AppImages.splash_Icon_New,
                    height: 101,
                    filterQuality: FilterQuality.high,
                  ),
                  const Text(
                    "What's Poppin",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: "Inter-Bold",
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
