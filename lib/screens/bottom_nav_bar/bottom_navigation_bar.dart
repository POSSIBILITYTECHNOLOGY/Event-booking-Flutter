import 'package:event_booking/res/appImages.dart';
import 'package:event_booking/res/colors.dart';
import 'package:event_booking/screens/bottom_nav_bar/controller/bottom_nav_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigationScreen extends StatelessWidget {
  // final _controller = Get.put(BottomNavigationController());
  final String? callFrom;

  const BottomNavigationScreen({Key? key, this.callFrom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // log("hello ${_controller.pageIndex.value.toString()}");
    return GetBuilder<BottomNavigationController>(
        init: BottomNavigationController(),
        builder: (controller) {
          // log("hello ${controller.pageIndex.value.toString()}");

          return Scaffold(
            bottomNavigationBar: customBottomnavBar(controller),
            body: Obx(() => controller.pageList[controller.pageIndex.value]),
          );
        });
  }

  Widget customBottomnavBar(controller) {
    return Obx(
      () => BottomNavigationBar(
          // currentIndex: 1,
          currentIndex: controller.pageIndex.value,
          backgroundColor: Colors.black,
          selectedItemColor: AppColor.white_Color,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: AppColor.white_Color,
          selectedLabelStyle: const TextStyle(color: Colors.pink),
          onTap: (index) {
            controller.pageIndex.value = index;
          },
          items: const [
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage(AppImages.bottom_nav_home_unselected_Icon),
                  color: AppColor.white_Color,
                ),
                activeIcon: ImageIcon(AssetImage(AppImages.bottom_nav_home_selected_Icon)),
                label: "Home"),
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage(AppImages.bottom_nav_ticket_unselected_Icon),
                  color: AppColor.white_Color,
                ),
                activeIcon: ImageIcon(AssetImage(AppImages.bottom_nav_ticket_selected_Icon)),
                label: "Tickets"),
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage(AppImages.bottom_nav_favourite_unselected_Icon),
                  color: AppColor.white_Color,
                ),
                activeIcon: ImageIcon(AssetImage(AppImages.bottom_nav_favourite_selected_Icon)),
                label: "Favourites"),
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage(AppImages.bottom_nav_setting_unselected_Icon),
                  color: AppColor.white_Color,
                ),
                activeIcon: ImageIcon(AssetImage(AppImages.bottom_nav_setting_selected_Icon)),
                label: "Settings")
          ]),
    );
    // )
  }
}
