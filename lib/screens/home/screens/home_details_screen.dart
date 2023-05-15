// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:event_booking/app_style/app_style.dart';
import 'package:event_booking/res/appImages.dart';
import 'package:event_booking/res/colors.dart';
import 'package:event_booking/screens/home/controller/home_controller.dart';
import 'package:event_booking/screens/home/screens/checkout_screen.dart';
import 'package:event_booking/screens/home/screens/hotel_details_photos_screen.dart';
import 'package:event_booking/screens/home/widgets/widgets.dart';
import 'package:event_booking/utils/widgets/common_Widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreenDetails extends StatelessWidget {
  final List? imagesList;

  final String? image;
  final String? id;
  final String? eventName;
  final String? description;
  final String? date;
  final String? time;
  final String? price;
  final String? address;
  final String? map;
  final String? title;
  final String? longitude;
  final String? latitude;
  final String? isFavourite;
  final String? categoryId;
  final String? callFrom;
  final int? index;
  var itemData;

  final HomeController controller = HomeController();

  HomeScreenDetails({
    super.key,
    this.callFrom,
    this.imagesList,
    this.itemData,
    this.index,
    this.description,
    this.date,
    this.time,
    this.price,
    this.address,
    this.image,
    this.title,
    this.map,
    this.id,
    this.longitude,
    this.eventName,
    this.latitude,
    this.isFavourite,
    this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    // DateTime datew = ;
    // int day = datew.day;

    // print(day); // Output: 20

    // String month = DateFormat('MMMM').format(datew);
    // print(month); // Output: May/ Output: May
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // !  Image Part
              HomeDetailsScreenImageCarousel(
                itemData: itemData,
                categoryId: categoryId,
                imagesList: imagesList,
                image: image,
                controller: controller,
                isFavourite: isFavourite,
                index: index,
                id: id,
              ),
              SizedBox(height: 15.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: Get.width,
                      // padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: Get.width * 0.6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  title!,
                                  style: AppTextStyle.textStyle30Roboto500white,
                                ),
                                Text(
                                  "STARTING ${DateFormat('hh:mm a').format(DateFormat('HH:mm:ss').parse(time!))}",
                                  style: AppTextStyle.textStyle12Roboto400lightGrey,
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    log(categoryId!);
                                  },
                                  child: Text(
                                    "\$$price/person",
                                    style: AppTextStyle.textStyle22Roboto500white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 0.5, color: Colors.white),
                                      // color: const Color(0xFF4F4F4F).withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(10.r),
                                      gradient: LinearGradient(
                                        end: Alignment.bottomCenter,
                                        begin: Alignment.topCenter,
                                        colors: [
                                          const Color(0xFFF3F3F3).withOpacity(0.3),
                                          const Color(0xFF4F4F4F).withOpacity(0.3),
                                        ],
                                      ),
                                    ),
                                    width: 70,
                                    height: 65,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Center(
                                            child: Text(
                                          DateFormat('MMMM').format(DateTime.parse(date!)).toString().toUpperCase(),
                                          style: AppTextStyle.textStyle16Roboto500purple,
                                        )),
                                        Center(
                                            child: Text(
                                          DateTime.parse(date!).day.toString(),
                                          style: AppTextStyle.textStyle24Roboto500purple,
                                        )),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: controller.decreaseTicketCount,
                                        child: Container(
                                          padding: const EdgeInsets.all(7),
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(100),
                                            border: Border.all(color: AppColor.light_blue),
                                          ),
                                          child: const Center(
                                              child: Icon(
                                            Icons.remove,
                                            color: AppColor.light_blue,
                                            size: 14,
                                          )),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Obx(() => Text(
                                            controller.ticketCount.value.toString(),
                                            style: AppTextStyle.textStyle16OpenSans600white,
                                          )),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      GestureDetector(
                                        onTap: controller.increaseTicketCount,
                                        child: Container(
                                          padding: const EdgeInsets.all(7),
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                            color: AppColor.light_blue,
                                            borderRadius: BorderRadius.circular(100),
                                            border: Border.all(color: AppColor.light_blue),
                                          ),
                                          child: const Center(
                                              child: Icon(
                                            Icons.add,
                                            size: 14,
                                            color: Colors.white,
                                          )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      description!,
                      style: AppTextStyle.textStyle14Roboto400lightGrey,
                    ),
                    SizedBox(height: 15.h),
                    Text(
                      "Location",
                      style: AppTextStyle.textStyle18Roboto600white,
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      address!,
                      style: AppTextStyle.textStyle10Roboto400lightGrey,
                    ),
                    SizedBox(height: 10.h),
                    HomeDetailsScreenMap(controller: controller, latitude: latitude, longitude: longitude),
                    SizedBox(height: 15.h),
                    InkWell(
                      onTap: () async {
                        controller.checkOutSelectDate.value = "Select Date";

                        await controller.listAllCards("").then((value) {
                          log("$value");
                          if (value) {
                            Get.to(() => CheckOutScreen(
                                id: id!, controller: controller, price: price!, eventName: eventName!, categoryId: categoryId!));
                          } else {
                            return;
                          }
                        });
                      },
                      child: Container(
                        height: 44.h,
                        // width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: Colors.white,
                        ),
                        // margin: const EdgeInsets.only(bottom: 10),
                        child: Center(
                            child: Text(
                          "Buy A Ticket",
                          style: AppTextStyle.textStyle14Roboto500black,
                        )),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Visibility(
                      visible: categoryId == "4" || categoryId == "2" || categoryId == "3" ? true : false,
                      child: InkWell(
                        onTap: () {
                          if (categoryId == "4") {
                            Get.to(() => HomeScreenNightClubsForm(controller: controller));
                          } else if (categoryId == "2") {
                            Get.to(() => HomeScreenYachtForm(controller: controller));
                          } else if (categoryId == "3") {
                            Get.to(() => HomeScreenDinnersForm(controller: controller));
                          }
                        },
                        child: Container(
                          height: 44.h,
                          // width: Get.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            color: AppColor.light_blue,
                          ),
                          // margin: const EdgeInsets.only(bottom: 10),
                          child: Center(
                              child: Text(
                            "Table Booking",
                            style: AppTextStyle.textStyle14Roboto500white,
                          )),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeDetailsScreenMap extends StatelessWidget {
  const HomeDetailsScreenMap({
    super.key,
    required this.controller,
    required this.latitude,
    required this.longitude,
  });

  final HomeController controller;
  final String? latitude;
  final String? longitude;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: GetBuilder<HomeController>(
            init: HomeController(),
            initState: (_) {},
            builder: (_) {
              return GoogleMap(
                onMapCreated: (GoogleMapController controller1) async {
                  // _.googleMapController.complete(controller1);
                  // for (var element in controller.markers) {
                  //   controller1.showMarkerInfoWindow(element.markerId);
                  // }
                  await _.loadMarkers(latitude, longitude);

                  // controller.mapController = _controller;

                  // await controller.onMapCreated;
                },
                onTap: GetPlatform.isIOS
                    ? (a) async {
                        // final url = "https://www.google.com/maps/dir/?api=1&destination=,";
                        var url = "https://www.google.com/maps/search/?api=1&query=${a.latitude},${a.longitude}";
                        if (await canLaunchUrl(Uri.parse(url))) {
                          await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                        } else {
                          throw 'Could not launch ';
                        }
                      }
                    : null,
                // circles: <Circle>{
                mapToolbarEnabled: true,

                zoomGesturesEnabled: false,
                myLocationEnabled: false,
                markers: _.markers,
                // minMaxZoomPreference: MinMaxZoomPreference.unbounded,

                zoomControlsEnabled: false,
                tiltGesturesEnabled: false,
                myLocationButtonEnabled: false,
                scrollGesturesEnabled: false,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    double.parse(latitude!),
                    double.parse(longitude!),
                  ),
                  zoom: 14,
                ),
                mapType: MapType.normal,
                buildingsEnabled: true,
              );
            },
          )),
    );
  }
}

class HomeDetailsScreenImageCarousel extends StatelessWidget {
  HomeDetailsScreenImageCarousel({
    super.key,
    required this.imagesList,
    required this.image,
    required this.isFavourite,
    required this.controller,
    required this.id,
    required this.index,
    required this.itemData,
    required this.categoryId,
  });

  final List? imagesList;
  final String? image, id, categoryId;
  String? isFavourite;
  final HomeController controller;
  final int? index;
  var itemData;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            Get.to(() => HomeDetailPhotos(imagesList: imagesList, image: image));
          },
          child: SizedBox(
            height: 380,
            width: Get.width,
            child: imagesList!.isEmpty
                ? Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(image!), fit: BoxFit.cover, opacity: 0.5),
                    ),
                  )
                : CarouselSlider.builder(
                    itemCount: imagesList!.take(5).length,
                    itemBuilder: (BuildContext? context, int? index, int pageIndex) {
                      // controller.imgIndex = pageIndex;
                      final item = imagesList![index!]["image"];
                      // return Opacity(
                      //   opacity: 0.5,
                      //   child: CachedNetworkImage(
                      //     imageUrl: item,
                      //     fit: BoxFit.cover,
                      //     placeholder: (context, url) => Center(child: Loader()),
                      //     errorWidget: (context, url, error) => const Icon(Icons.error),
                      //   ),
                      // );
                      return Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(image: NetworkImage(item), fit: BoxFit.cover, opacity: 1),
                        ),
                      );
                      // Image.network(
                      //   item,
                      //   fit: BoxFit.cover,
                      //   opacity: const AlwaysStoppedAnimation(.5),
                      // );
                    },
                    options: CarouselOptions(
                      viewportFraction: 1,
                      autoPlay: true,

                      // clipBehavior: Clip.none,

                      aspectRatio: 1,
                      // enlargeCenterPage: false,
                      // padEnds:
                      //     false, // take full width, remove padding from all size
                      onPageChanged: (index, reason) {
                        controller.imgIndex.value = index;
                      },
                    ),
                  ),
          ),
        ),
        Visibility(
          visible: imagesList!.isEmpty ? false : true,
          child: Positioned(
              bottom: 10,
              left: 20,
              right: 20,
              child: Obx(
                () => Row(
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    // children: controller.imgList.map((i) {
                    children: controller.imgListPhotos.take(5).map((i) {
                      // int index = controller.imgList.indexOf(i);
                      int index = controller.imgListPhotos.indexOf(i);
                      return SizedBox(
                        height: 10,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          height: controller.imgIndex.value == index ? 10 : 8.0,
                          width: controller.imgIndex.value == index ? 12 : 8.0,
                          decoration: BoxDecoration(
                            boxShadow: [
                              controller.imgIndex.value == index
                                  ? BoxShadow(
                                      color: AppColor.light_blue.withOpacity(0.72),
                                      blurRadius: 4.0,
                                      spreadRadius: 1.0,
                                      offset: const Offset(
                                        0.0,
                                        0.0,
                                      ),
                                    )
                                  : const BoxShadow(
                                      color: Colors.transparent,
                                    )
                            ],
                            shape: BoxShape.circle,
                            color: controller.imgIndex.value == index ? AppColor.light_blue : const Color(0XFFEAEAEA),
                          ),
                        ),
                      );
                    }).toList()),
              )),
        ),
        //* Heart Icon
        Visibility(
          visible: false,
          child: Positioned(
            top: 14.h,
            right: 8.w,
            child: GestureDetector(
              onTap: () async {
                // if (isFavourite == "null") {
                // await controller.favouriteEvent(id, categoryId: categoryId, callFrom: "Detail");
                //   isFavourite = "";
                // } else {
                //   await controller.deleteFavouriteEvent(id, categoryId: categoryId, callFrom: "Detail");
                //   isFavourite = "null";
                // }
                log("Heart Icon $isFavourite");
                log("Heart Icon $index");
                log("Heart Icon $categoryId");
                log("Heart Icon ItemData ${itemData['favorite']}");
                itemData['favorite'] = 'null';
                log("Heart Icon ItemData ${itemData['favorite']}");

                // var test = controller.eventByCategoryListTemp.where((e) {
                //   log("${e['id'].toString() == "23"} \n\n");
                //   return e['id'].toString() == itemData['id'].toString();
                // });
                // log("Test ${test.toString()}");
                // log("Heart Icon eventByCategoryListTemp ${controller.eventByCategoryListTemp[index!]['id']}");
                // log("Heart Icon eventByCategoryListTemp ${controller.eventByCategoryListTemp[index!]['id']}");
                // log("Heart Icon ${controller.eventByCategoryList[index!]['favorite']}");
              },
              child: Container(
                padding: const EdgeInsets.all(7),
                height: 38,
                width: 38,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.black,
                ),
                child: Image.asset(
                  isFavourite == "null" ? AppImages.bottom_nav_favourite_unselected_Icon : AppImages.bottom_nav_favourite_selected_Icon,
                  height: 15.h,
                  width: 15.h,
                ),
              ),
            ),
          ),
        ),
        Positioned(top: 14.h, left: 8.w, child: const CommonBackButtom()),
        // Positioned(
        //   bottom: 40,
        //   child:
        // ),
      ],
    );
  }
}
