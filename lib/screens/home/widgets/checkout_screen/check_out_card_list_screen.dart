import 'dart:developer';

import 'package:event_booking/app_style/app_style.dart';
import 'package:event_booking/res/colors.dart';
import 'package:event_booking/screens/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CheckOutScreenCardList extends StatelessWidget {
  const CheckOutScreenCardList({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    controller.cardList.refresh();
    return SizedBox(
      height: 170,
      child: Obx(
        () => controller.cardList.isEmpty
            ? Center(
                child: Text(
                'No Card Found!\nPlease Add a Card!',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColor.light_grey, fontSize: 12.sp),
              ))
            : ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: controller.cardList.length,
                itemBuilder: (context, index) {
                  var listData = controller.cardList[index];
                  return InkWell(
                      onTap: () {
                        // controller.selectCard(index);
                        // log(controller.selectedIndexx.toString());
                        controller.selectCard(index);
                        controller.currentCardbId.value = listData["id"].toString();
                        log("CardList ==> ${controller.selectedCard}");
                        log("CardList Length==> ${controller.cardList.length}");
                        // print(controller.selectedCards);
                      },
                      child: Obx(
                        () => Container(
                          margin: const EdgeInsets.only(bottom: 9),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          height: 78,
                          decoration: BoxDecoration(color: AppColor.light_grey.withOpacity(0.3), borderRadius: BorderRadius.circular(18)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 53,
                                    width: 53,
                                    decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(50),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          controller.profilePic.value,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        listData['name_on_card']!,
                                        // listData['name_on_card']!,
                                        style: AppTextStyle.textStyle13Roboto400purple,
                                      ),
                                      Text(
                                        "XXXX XXXX XXXX ${listData['card_last_four']!}",
                                        style: AppTextStyle.textStyle14Roboto400lightGrey,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                height: 15,
                                width: 15,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white, width: 2),
                                    color: controller.selectedCard.value == index ? AppColor.light_blue : Colors.transparent,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                            ],
                          ),
                        ),
                      ));
                },
              ),
      ),
    );
  }
}
