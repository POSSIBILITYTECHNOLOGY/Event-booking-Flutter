import 'package:event_booking/app_style/app_style.dart';
import 'package:event_booking/res/colors.dart';
import 'package:event_booking/screens/tickets/controller/tickets_controller.dart';
import 'package:event_booking/utils/commonMethods.dart';
import 'package:event_booking/utils/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../res/appImages.dart';

class TicketsScreen extends StatelessWidget {
  const TicketsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<TicketsController>(
        init: TicketsController(),
        builder: (controller) {
          return controller.isLoading.value
              ? const Center(child: Loader())
              : Scaffold(
                  body: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: [
                          const Text(
                            "Tickets",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: AppColor.white_Color, fontFamily: "Roboto", fontSize: 24, fontWeight: FontWeight.w500),
                          ),
                          // const CommonAppBar(),
                          DefaultTabController(
                              length: 2,
                              child: Expanded(
                                child: SizedBox(
                                  height: Get.height,
                                  width: Get.width,
                                  child: Column(
                                    children: [
                                      const TabBar(
                                          padding: EdgeInsets.only(bottom: 20),
                                          indicatorSize: TabBarIndicatorSize.tab,
                                          indicatorColor: AppColor.light_blue,
                                          tabs: [
                                            Tab(
                                              child: Text(
                                                "Inprogress",
                                                style: TextStyle(color: AppColor.white_Color, fontFamily: "Roboto"),
                                              ),
                                            ),
                                            Tab(
                                              child: Text(
                                                "Completed",
                                                style: TextStyle(color: AppColor.white_Color, fontFamily: "Roboto"),
                                              ),
                                            )
                                          ]),
                                      Expanded(
                                        child: TabBarView(children: [
                                          controller.ticketListInProgress.isEmpty
                                              ? Center(
                                                  child: Text(
                                                    "No Data Found",
                                                    style: AppTextStyle.textStyle24Roboto700white,
                                                  ),
                                                )
                                              : ListView.builder(
                                                  itemCount: controller.ticketListInProgress.length,
                                                  itemBuilder: (context, index) {
                                                    var itemData = controller.ticketListInProgress[index];
                                                    return GestureDetector(
                                                      onTap: () async {
                                                        CommonMethods.getInstance().showDialogBox(
                                                            "Are you sure, you want to mark this event as completed?", () async {
                                                          await controller.markAsCompleted(itemData['id'].toString());
                                                        }, () {
                                                          Get.back();
                                                        });
                                                      },
                                                      child: tabBarWidget(
                                                          itemData['events']['image'],
                                                          itemData['events']['title'],
                                                          DateFormat('E, MMM d, y')
                                                              .format(DateTime.parse(itemData['events']['date']))
                                                              .toUpperCase(),
                                                          DateFormat('hh:mm a')
                                                              .format(DateFormat('HH:mm:ss').parse(itemData['events']['time'])),
                                                          AppImages.marker_Icon,
                                                          itemData['events']['location_address'],
                                                          "In Progress"),
                                                    );
                                                  }),
                                          controller.ticketListCompleted.isEmpty
                                              ? Center(
                                                  child: Text(
                                                    "No Data Found",
                                                    style: AppTextStyle.textStyle24Roboto700white,
                                                  ),
                                                )
                                              : ListView.builder(
                                                  itemCount: controller.ticketListCompleted.length,
                                                  itemBuilder: (context, index) {
                                                    var itemData = controller.ticketListCompleted[index];
                                                    return tabBarWidget(
                                                        itemData['events']['image'],
                                                        itemData['events']['title'],
                                                        DateFormat('E, MMM d, y')
                                                            .format(DateTime.parse(itemData['events']['date']))
                                                            .toUpperCase(),
                                                        DateFormat('hh:mm a')
                                                            .format(DateFormat('HH:mm:ss').parse(itemData['events']['time'])),
                                                        AppImages.marker_Icon,
                                                        itemData['events']['location_address'],
                                                        "Completed");
                                                  }),
                                        ]),
                                      )
                                    ],
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                );
        });
  }

  Widget tabBarWidget(String? img, String? title, String date, String? time, String? iconImage, String? address, [String? subtitle]) {
    return Container(
      margin: const EdgeInsets.only(
        top: 18,
      ),
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        top: 11,
                      ),
                      // width: Get.width * 0.30,
                    ),
                    subtitle != null
                        ? Container(
                            margin: const EdgeInsets.only(left: 5, right: 10),
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            height: 20,
                            width: 100,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: AppColor.green)),
                            child: Center(
                              child: Text(
                                subtitle,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(color: AppColor.green, fontSize: 9),
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: Get.width * 0.55,
                  child: Text(
                    title!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(color: AppColor.light_blue, fontSize: 16),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      height: 22,
                      // width: 92,
                      decoration: BoxDecoration(color: AppColor.light_black, borderRadius: BorderRadius.circular(20)),
                      child: Center(
                          child: Text(
                        date,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: AppColor.white_Color, fontSize: 9),
                      )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
