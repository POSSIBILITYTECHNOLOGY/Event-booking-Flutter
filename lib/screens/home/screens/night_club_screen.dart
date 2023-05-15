import 'package:event_booking/res/appImages.dart';
import 'package:event_booking/res/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NightClubScreen extends StatelessWidget {
  const NightClubScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: Column(
        children: [
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
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: Get.height * 0.24,
            width: Get.width,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 21),
                    width: 169,
                    decoration: BoxDecoration(color: AppColor.dark_grey, borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(children: [
                          Container(
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                                image: DecorationImage(
                                  image: AssetImage(AppImages.event_Image_1),
                                )),
                            height: 130,
                            width: Get.width,
                          ),
                          Positioned(
                              top: 14,
                              left: 147,
                              right: 8,
                              child: Image.asset(
                                AppImages.bottom_nav_favourite_unselected_Icon,
                                height: 15,
                              )),
                        ]),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 11),
                                    padding: const EdgeInsets.only(left: 5, right: 5),
                                    height: 22,
                                    width: 92,
                                    decoration: BoxDecoration(color: AppColor.light_black, borderRadius: BorderRadius.circular(20)),
                                    child: const Center(
                                        child: Text(
                                      "FRI,JUL 22,2022 ",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: AppColor.white_Color, fontSize: 9),
                                    )),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 11, left: 8),
                                    padding: const EdgeInsets.only(left: 5, right: 5),
                                    height: 22,
                                    width: 52,
                                    decoration: BoxDecoration(color: AppColor.light_black, borderRadius: BorderRadius.circular(20)),
                                    child: const Center(
                                        child: Text("10:00 PM",
                                            overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColor.white_Color, fontSize: 9))),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                "Dinner Party",
                                overflow: TextOverflow.ellipsis,
                                style:
                                    TextStyle(fontFamily: "Roboto", fontWeight: FontWeight.w500, color: AppColor.light_blue, fontSize: 16),
                              ),
                              const SizedBox(
                                  width: 151,
                                  child: Text("A dinner party is a great way to acquaint ",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      style: TextStyle(fontSize: 7, color: AppColor.light_grey, overflow: TextOverflow.ellipsis)))
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Events For you",
                style: TextStyle(color: AppColor.white_Color, fontFamily: "Roboto", fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Text(
                "View all",
                style: TextStyle(fontSize: 16, fontFamily: "Roboto", color: AppColor.light_blue, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(
            height: 11,
          ),
          SizedBox(
            height: Get.height * 0.34,
            width: Get.width,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 21, bottom: 10),
                    height: 85,
                    width: 169,
                    decoration: BoxDecoration(color: AppColor.dark_grey, borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      children: [
                        Container(
                          height: 85,
                          width: 102,
                          decoration: const BoxDecoration(
                              image: DecorationImage(image: AssetImage(AppImages.event_Image_1)),
                              borderRadius: BorderRadius.horizontal(left: Radius.circular(16))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 9, left: 11),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Yacht Paerties",
                                style: TextStyle(color: AppColor.light_blue),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              SizedBox(
                                  width: Get.width * 0.5,
                                  child: const Text("A dinner party is a great way to acquaint ",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(fontSize: 7, color: AppColor.light_grey, overflow: TextOverflow.ellipsis))),
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 11),
                                    padding: const EdgeInsets.only(left: 5, right: 5),
                                    height: 22,
                                    width: 92,
                                    decoration: BoxDecoration(color: AppColor.light_black, borderRadius: BorderRadius.circular(20)),
                                    child: const Center(
                                        child: Text(
                                      "FRI,JUL 22,2022 ",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: AppColor.white_Color, fontSize: 9),
                                    )),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 11, left: 8),
                                    padding: const EdgeInsets.only(left: 5, right: 5),
                                    height: 22,
                                    width: 52,
                                    decoration: BoxDecoration(color: AppColor.light_black, borderRadius: BorderRadius.circular(20)),
                                    child: const Center(
                                        child: Text("10:00 PM",
                                            overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColor.white_Color, fontSize: 9))),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
