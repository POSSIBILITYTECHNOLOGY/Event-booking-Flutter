import 'dart:developer';

import 'package:event_booking/app_style/app_style.dart';
import 'package:event_booking/res/appImages.dart';
import 'package:event_booking/res/colors.dart';
import 'package:event_booking/screens/favourite_screen/controller/favourite_screen_controller.dart';
import 'package:event_booking/screens/home/controller/home_controller.dart';
import 'package:event_booking/screens/home/screens/home_details_screen.dart';
import 'package:event_booking/utils/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GetX<FavouriteController>(
      init: FavouriteController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            automaticallyImplyLeading: false,
            flexibleSpace: const FlexibleSpaceBar(
              background: Center(
                child: Text(
                  "Favourites",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: AppColor.white_Color, fontFamily: "Roboto", fontSize: 24, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          body: SafeArea(
            child: controller.isLoading.value
                ? const Center(
                    child: Loader(),
                  )
                : controller.favItemList.isEmpty
                    ? Center(
                        child: Text(
                          "No Data Found",
                          style: AppTextStyle.textStyle24Roboto700white,
                        ),
                      )
                    : ListView.builder(
                        itemCount: controller.favItemList.length,
                        itemBuilder: (context, index) {
                          var itemData = controller.favItemList[index];
                          return GetBuilder<HomeController>(
                            init: HomeController(),
                            builder: (con) {
                              return GestureDetector(
                                onTap: () async {
                                  log("message[Z]");
                                  await con.loadMarkers(itemData['event']["lat"], itemData['event']["lng"]);

                                  await Get.to(() => HomeScreenDetails(
                                      callFrom: "Fav",
                                      index: index,
                                      itemData: itemData,
                                      imagesList: itemData['images'],
                                      image: itemData['event']['image'],
                                      description: itemData['event']['description'],
                                      address: itemData['event']['location_address'],
                                      date: itemData['event']["date"],
                                      time: itemData['event']["time"],
                                      price: itemData['event']["price"],
                                      title: con.currentTab.value,
                                      longitude: itemData['event']["lng"],
                                      latitude: itemData['event']["lat"],
                                      eventName: itemData['event']['title'],
                                      id: itemData['event']['id'].toString(),
                                      categoryId: con.currentTabId.value,
                                      isFavourite: "notNull"));
                                },
                                child: tabBarWidget(
                                  itemData['event']['image'],
                                  itemData['event']['title'],
                                  DateFormat('E, MMM d, y').format(DateTime.parse(itemData['event']['date'])).toUpperCase(),
                                  DateFormat('hh:mm a').format(DateFormat('HH:mm:ss').parse(itemData['event']['time'])),
                                  AppImages.marker_Icon,
                                  itemData['event']['location_address'],
                                ),
                              );
                            },
                          );
                        }),
          ),
        );
      },
    );
  }

  Widget tabBarWidget(String? img, String? title, String date, String? time, String? iconImage, String? address, [String? subtitle]) {
    return Container(
      margin: const EdgeInsets.only(top: 18, left: 20, right: 20),
      padding: const EdgeInsets.only(left: 6, top: 12, bottom: 11),
      height: 117,
      // width: 334,
      decoration: BoxDecoration(color: AppColor.dark_grey, borderRadius: BorderRadius.circular(16)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 94,
            width: 102,
            decoration:
                BoxDecoration(image: DecorationImage(image: NetworkImage(img!), fit: BoxFit.fill), borderRadius: BorderRadius.circular(16)),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      top: 11,
                    ),
                    width: Get.width * 0.55,
                    child: Text(
                      title!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(color: AppColor.light_blue, fontSize: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              // Row(
              //   children: [
              //     Container(
              //       padding: const EdgeInsets.only(left: 4, right: 4),
              //       height: 22,
              //       width: 99,
              //       decoration: BoxDecoration(color: AppColor.light_black, borderRadius: BorderRadius.circular(20)),
              //       child: Center(
              //           child: Text(
              //         date,
              //         overflow: TextOverflow.ellipsis,
              //         style: const TextStyle(color: AppColor.white_Color, fontSize: 9),
              //       )),
              //     ),
              //     Container(
              //       margin: const EdgeInsets.only(left: 8),
              //       padding: const EdgeInsets.only(left: 8, right: 8),
              //       height: 22,
              //       width: 58,
              //       decoration: BoxDecoration(color: AppColor.light_black, borderRadius: BorderRadius.circular(20)),
              //       child: Center(
              //           child:
              //               Text(time!, overflow: TextOverflow.ellipsis, style: const TextStyle(color: AppColor.white_Color, fontSize: 9))),
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 8,
              // ),
              Row(
                children: [
                  Image.asset(
                    iconImage!,
                    height: 14,
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  SizedBox(
                      width: Get.width * 0.50,
                      child: Text(
                        address!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12, color: AppColor.light_grey),
                      ))
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
