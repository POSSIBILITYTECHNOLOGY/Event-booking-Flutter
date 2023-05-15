import 'package:event_booking/screens/home/screens/home_screen_location_selection.dart';
import 'package:event_booking/utils/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'controller/home_controller.dart';
import 'widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          body: GetBuilder<HomeController>(
              init: HomeController(),
              builder: (controller) {
                return SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 20.w,
                      right: 20.w,
                      // bottom: 20.h,
                    ),
                    child: Obx(() => controller.isLoading.value
                        ? const Center(child: Loader())
                        : CustomScrollView(
                            controller: ScrollController(),
                            slivers: !controller.isLocationSelectionScreenSelected.value
                                ? [
                                    HomeScreenAppBar(controller: controller),
                                    HomeScreenHorizontalCards(controller: controller),
                                    // const HomeScreenVerticalList2(),
                                  ]
                                : [
                                    HomeScreenLocationSelection(
                                      controller: controller,
                                    )
                                  ],
                          )),
                  ),
                );
              })),
    );
  }
}
