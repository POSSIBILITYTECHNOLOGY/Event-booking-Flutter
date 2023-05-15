import 'dart:developer';

import 'package:event_booking/app_style/app_style.dart';
import 'package:event_booking/res/appImages.dart';
import 'package:event_booking/res/colors.dart';
import 'package:event_booking/screens/home/screens/home_details_screen.dart';
import 'package:event_booking/screens/setting/controller/nft_settings_controller.dart';
import 'package:event_booking/utils/widgets/common_Widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NftSettingScreen extends StatelessWidget {
  const NftSettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<NftSettingsController>(
            init: NftSettingsController(),
            builder: (controller) {
              return SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 20.w,
                    right: 20.w,
                    // bottom: 20.h,
                  ),
                  child: CustomScrollView(controller: ScrollController(), slivers: [
                    NftSettingScreenAppBar(controller: controller),
                    NftSettingScreenHorizontalCards(controller: controller),
                    // const HomeScreenVerticalList2(),
                  ]),
                ),
              );
            }));
  }
}

class NftSettingScreenAppBar extends StatelessWidget {
  final NftSettingsController controller;
  const NftSettingScreenAppBar({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.black,
      automaticallyImplyLeading: false,
      pinned: true,
      toolbarHeight: 45,
      // toolbarHeight: 118.h,
      expandedHeight: 45,
      // expandedHeight: 118.h,
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          children: [
            SizedBox(
              height: 40,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CommonBackButtom(),
                  Text(
                    "NFT",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.textStyle16Roboto700white.copyWith(fontSize: 24),
                  ),
                  const SizedBox(
                    width: 25,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}

class NftSettingScreenHorizontalCards extends StatelessWidget {
  final NftSettingsController controller;
  const NftSettingScreenHorizontalCards({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => SliverToBoxAdapter(
          child: controller.eventList.isEmpty && !controller.isLoading.value
              ? Container(
                  height: Get.height * 0.65,
                  alignment: Alignment.center,
                  child: Center(
                    child: Text(
                      "No Event Found",
                      style: AppTextStyle.textStyle24Roboto700white,
                    ),
                  ),
                )
              : SizedBox(
                  // height: 324.h,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: (162.w / 229.h),
                          ),
                          scrollDirection: Axis.vertical,
                          itemCount: controller.eventList.length,
                          itemBuilder: (context, index) {
                            var itemData = controller.eventList[index];
                            return GestureDetector(
                              onTap: () async {
                                // await controller.loadMarkers(itemData["lat"], itemData["lng"]);
                                // await controller.fetchEventsforSelectedId(controller.currentTabId.value);

                                await Get.to(() => HomeScreenDetails(
                                    index: index,
                                    itemData: itemData,
                                    imagesList: itemData['images'],
                                    image: itemData['image'],
                                    description: itemData['description'],
                                    address: itemData['location_address'],
                                    date: itemData["date"],
                                    time: itemData["time"],
                                    price: itemData["price"],
                                    title: "NFT's",
                                    longitude: itemData["lng"],
                                    latitude: itemData["lat"],
                                    eventName: itemData['title'],
                                    id: itemData['id'].toString(),
                                    categoryId: controller.currentTabId.value,
                                    isFavourite: itemData['favorite'] == null ? "null" : "notNull"));
                              },
                              child: Container(
                                // margin: EdgeInsets.only(right: 21.w),
                                // width: Get.width * 0.5,
                                // height: 200,
                                decoration: BoxDecoration(color: AppColor.dark_grey, borderRadius: BorderRadius.circular(16.r)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 130.h,
                                      child: Stack(children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                            image: DecorationImage(
                                              image: NetworkImage(itemData['image']),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          height: 130.h,
                                          width: Get.width,
                                        ),
                                        Positioned(
                                            top: 14.h,
                                            right: 8.w,
                                            child: GestureDetector(
                                              onTap: () async {
                                                log("${itemData["id"]}");
                                                itemData['favorite'] == null
                                                    ? controller.favouriteEvent(itemData["id"].toString())
                                                    : controller.deleteFavouriteEvent(itemData["id"].toString());
                                              },
                                              child: SizedBox(
                                                height: 20,
                                                width: 20,
                                                child: Image.asset(
                                                  itemData['favorite'] == null
                                                      ? AppImages.bottom_nav_favourite_unselected_Icon
                                                      : AppImages.bottom_nav_favourite_selected_Icon,
                                                  height: 15,
                                                  width: 15,
                                                ),
                                              ),
                                            )),
                                      ]),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 22,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.only(left: 5, right: 5),

                                                  // width: 92.w,
                                                  decoration:
                                                      BoxDecoration(color: AppColor.light_black, borderRadius: BorderRadius.circular(20)),
                                                  child: Center(
                                                      child: Text(
                                                    (DateFormat('EEE, MMM d, yyyy')
                                                            .format(DateFormat('yyyy-MM-dd').parse(itemData['date'])))
                                                        .toUpperCase(),
                                                    overflow: TextOverflow.ellipsis,
                                                    style: AppTextStyle.textStyle9Roboto500white,
                                                  )),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.only(left: 5, right: 5),

                                                  // width: 52.w,
                                                  decoration:
                                                      BoxDecoration(color: AppColor.light_black, borderRadius: BorderRadius.circular(20)),
                                                  child: Center(
                                                      child: Text(
                                                    DateFormat('h:mm a').format(DateFormat('HH:mm:ss').parse(itemData["time"])),
                                                    overflow: TextOverflow.ellipsis,
                                                    style: AppTextStyle.textStyle9Roboto500white,
                                                  )),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // const SizedBox(
                                          //   height: 5,
                                          // ),
                                          Text(
                                            itemData["title"],
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppTextStyle.textStyle14Roboto500purple,
                                          ),
                                          // Text(
                                          //   itemData["description"],
                                          //   overflow: TextOverflow.ellipsis,
                                          //   maxLines: 2,
                                          //   style: AppTextStyle.textStyle10Roboto400lightGrey,
                                          // )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
        ));
  }
}
