import 'package:event_booking/app_style/app_style.dart';
import 'package:event_booking/res/appImages.dart';
import 'package:event_booking/res/colors.dart';
import 'package:event_booking/screens/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreenAppBar extends StatelessWidget {
  final HomeController controller;
  const HomeScreenAppBar({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => SliverAppBar(
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          pinned: true,
          // toolbarHeight: 86,
          toolbarHeight: 118.h,
          // expandedHeight: 86,
          expandedHeight: 118.h,
          flexibleSpace: FlexibleSpaceBar(
            background: Column(
              children: [
                InkWell(
                  onTap: () async {
                    controller.isLocationSelectionScreenSelected.value = true;

                    // await controller.checkLocationPermission("");
                    // print(controller.isLocationSelectionScreenSelected.value);
                  },
                  child: SizedBox(
                    height: 60,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          AppImages.marker_Icon,
                          height: 33.h,
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: Get.width - 100.w,
                                  child: Text(
                                    controller.currentAddressTitle.value,
                                    // "Possibility Solutions Pvt. Ltd",
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyle.textStyle16Roboto700white,
                                  ),
                                ),
                                InkWell(
                                  child: SizedBox(
                                    height: 12.h,
                                    width: 12.w,
                                    child: Image.asset(
                                      AppImages.drop_down_Icon,
                                      height: 5.h,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                                width: Get.width - 90.w,
                                child: Text(
                                  // "C-127,4th floor, phase 8, Sahibzada Ajit Singh Nagar, Punjab 140308",
                                  controller.currentAddressFull.value,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyle.textStyle10Roboto400white,
                                )),
                          ],
                        ),
                        // Text(
                        //   "What's Poppin",
                        //   maxLines: 1,
                        //   overflow: TextOverflow.ellipsis,
                        //   style: AppTextStyle.textStyle16Roboto700white.copyWith(fontSize: 24),
                        // )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 51,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.categoryList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          splashColor: Colors.black,
                          onTap: () async {
                            controller.changeTab(index);
                            controller.currentTab.value = controller.categoryList[index]['title'];
                            controller.currentTabId.value = controller.categoryList[index]['id'].toString();
                            await controller.fetchEventsforSelectedId(controller.categoryList[index]['id']);
                            // log("HomeScreenAppBar Category Index Name ${controller.tabs[index]}");
                            // log("HomeScreenAppBar Category Name ${controller.currentTab.value}");
                            // log("HomeScreenAppBar Category Id ${controller.currentTabId.value}");
                          },
                          child: Obx(
                            () => Container(
                              decoration: BoxDecoration(
                                  color: controller.currentIndex.value == index ? AppColor.light_blue : Colors.black,
                                  borderRadius: BorderRadius.circular(18),
                                  border: Border.all(color: AppColor.light_blue)),
                              margin: EdgeInsets.only(right: 10.w, top: 15.h),
                              padding: EdgeInsets.only(left: 10.w, right: 10.h),
                              child: Center(
                                  child: Text(
                                controller.categoryList[index]['title'],
                                style: TextStyle(fontFamily: "Roboto", color: AppColor.white_Color, fontSize: 12.sp),
                              )),
                            ),
                          ),
                        );
                      }),
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ));
  }
}
