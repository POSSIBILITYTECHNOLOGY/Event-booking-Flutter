import 'package:event_booking/home_gridview/controller/home_gridView_controller.dart';
import 'package:event_booking/utils/commonMethods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../res/appImages.dart';
import '../res/colors.dart';

class HomeGridView extends StatelessWidget {
  final _controller = Get.put(HomeGridController());
  HomeGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 18.w, right: 18.w, top: 20.h),
          child: Column(
            children: [
              CommonMethods.getInstance().customAppBar(AppImages.marker_Icon, "Possibility Solutions Pvt. Ltd",
                  "C-127,4th floor, phase 8, Sahibzada Ajit Singh Nagar, Punjab 140308"),
              SizedBox(height: 10.h),
              customtabBar(),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Nearby Events",
                    style: TextStyle(color: AppColor.white_Color, fontFamily: "Roboto", fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "View all",
                    style: TextStyle(fontSize: 16, fontFamily: "Roboto", color: AppColor.light_blue, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: 8,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 145.h / 208.h, crossAxisSpacing: 15.0, mainAxisSpacing: 15.0, crossAxisCount: 2),
                    itemBuilder: (context, i) {
                      return Container(
                        width: 200.w,
                        // height: 400.h,

                        decoration: BoxDecoration(color: AppColor.dark_grey, borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(children: [
                              Container(
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                                    image: DecorationImage(image: AssetImage(AppImages.event_Image_1), fit: BoxFit.fill)),
                                height: 130,
                                width: Get.width,
                              ),
                              Positioned(
                                  top: 14.h,
                                  left: 147.w,
                                  right: 8.w,
                                  child: Image.asset(
                                    AppImages.bottom_nav_favourite_unselected_Icon,
                                    height: 15.h,
                                  )),
                            ]),
                            Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        padding: const EdgeInsets.only(left: 3, right: 3),
                                        height: 20.h,
                                        width: 90.w,
                                        decoration: BoxDecoration(color: AppColor.light_black, borderRadius: BorderRadius.circular(20)),
                                        child: const Center(
                                            child: Text(
                                          "FRI,JUL 22,2022 ",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(color: AppColor.white_Color, fontSize: 8),
                                        )),
                                      ),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                          top: 10,
                                        ),
                                        padding: const EdgeInsets.only(left: 3, right: 3),
                                        height: 20.h,
                                        width: 50.w,
                                        decoration: BoxDecoration(color: AppColor.light_black, borderRadius: BorderRadius.circular(20)),
                                        child: const Center(
                                            child: Text("10:00 PM",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(color: AppColor.white_Color, fontSize: 8))),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  const Text(
                                    "Dinner Party",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontFamily: "Roboto", fontWeight: FontWeight.w500, color: AppColor.light_blue, fontSize: 16),
                                  ),
                                  SizedBox(
                                      width: 151.w,
                                      child: const Text(
                                          "A dinner party is a great way to acquaint jfgvkfgvhfskjvhsv jhksjvguiklvhkdvkdlshvjgdsiuvlhbjd vhiuosdlkhvjgduiosuvlkhsdjiuvoul;skdhjgvuiosdlkjhvjbidsolkvjhdsuioklvjhdbsiuovul;dhsjbuivodlsuj.khvbduisoluvkhdsiuovlkudshuivoylkudshuviolksdjhzvuidsklhvbuisdoklhvsduikjlhvdshckdoichdkchdsjhcdslckjdsghc ",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontFamily: "Roboto", fontSize: 10, color: AppColor.light_grey, overflow: TextOverflow.clip)))
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget customtabBar() {
    return SizedBox(
      height: 50.h,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _controller.tabBarIndexList.length,
          itemBuilder: (context, index) {
            return InkWell(
              splashColor: Colors.black,
              onTap: () {
                _controller.index.value = index;
              },
              child: Obx(
                () => Container(
                  decoration: BoxDecoration(
                      color: _controller.index.value == index ? AppColor.light_blue : Colors.black,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: AppColor.light_blue)),
                  margin: const EdgeInsets.only(right: 10, top: 15),
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Center(
                      child: Text(
                    _controller.tabBarIndexList[index].text.toString(),
                    style: const TextStyle(fontFamily: "Roboto", color: AppColor.white_Color, fontSize: 12),
                  )),
                ),
              ),
            );
          }),
    );
  }
}
