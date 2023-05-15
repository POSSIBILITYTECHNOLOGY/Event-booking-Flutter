import 'dart:convert';
import 'dart:developer';

import 'package:event_booking/app_style/app_style.dart';
import 'package:event_booking/res/colors.dart';
import 'package:event_booking/screens/home/controller/home_controller.dart';
import 'package:event_booking/utils/sharedpref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeScreenLocationSelection extends StatelessWidget {
  final HomeController controller;
  const HomeScreenLocationSelection({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    controller.getSharedPrefValues();
    return SliverToBoxAdapter(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Form(
          // key: controller.formKeyLocationSelect,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () async {
                      controller.isLocationSelectionScreenSelected.value = false;
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(color: Colors.grey[800], borderRadius: BorderRadius.circular(13)),
                      child: const Icon(
                        Icons.arrow_back_ios_new_sharp,
                        size: 15,
                        color: AppColor.white_Color,
                      ),
                    ),
                  ),
                  Text(
                    "Select a location",
                    style: AppTextStyle.textStyle24Roboto700white,
                  ),
                  SizedBox(
                    height: 38.h,
                    width: 38.w,
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              // TypeAheadField(
              //   direction: AxisDirection.down,
              //   autoFlipDirection: true,
              //   textFieldConfiguration: TextFieldConfiguration(
              //     controller: controller.searchController.value,
              //     style: const TextStyle(color: AppColor.light_grey),
              //     decoration: InputDecoration(
              //       // fillColor: Colors.white,
              //       // filled: true,

              //       prefixIcon: const Icon(
              //         Icons.search,
              //         color: AppColor.light_blue,
              //       ),
              //       hintText: "Search for area, street name.",
              //       focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColor.light_grey)),
              //       errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColor.light_grey)),
              //       errorStyle: const TextStyle(fontSize: 14),
              //       counterText: " ",
              //       contentPadding: const EdgeInsets.only(bottom: 8, left: 20),

              //       errorMaxLines: 3,
              //       counterStyle: const TextStyle(color: Colors.white),

              //       // Container(
              //       //        padding: const EdgeInsets.only(top: 12,bottom: 12,left: 5),
              //       //        child: Image.asset(AppImages.login_lock_Icon,height: 2)),
              //       hintStyle: const TextStyle(color: AppColor.grey, fontFamily: "Sora", fontSize: 14),

              //       border: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColor.white_Color, width: 0.2)),
              //     ),
              //   ),
              //   scrollController: ScrollController(),
              //   suggestionsBoxController: SuggestionsBoxController(),
              //   itemBuilder: (_, suggestion) {
              //     int newSug = suggestion.lastIndexOf(' ');
              //     var fin = suggestion.substring(0, newSug);
              //     log(fin.length.toString());
              //     return ListTile(
              //       tileColor: Colors.black,
              //       title: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             fin,
              //             style: const TextStyle(
              //               color: AppColor.light_grey,
              //             ),
              //           ),
              //           Container(
              //             width: Get.width,
              //             height: 1,
              //             color: AppColor.light_grey,
              //           )
              //         ],
              //       ),
              //     );
              //   },
              //   // itemBuilder: (_, suggestion) {
              //   //   int newSug = suggestion.lastIndexOf(' ');
              //   //   var fin = suggestion.substring(0, newSug);
              //   //   return SizedBox(
              //   //     height: 50, // Set the height of the ListTile to 50 or any desired value.
              //   //     width: Get.width - 100.w,
              //   //     child: SingleChildScrollView(
              //   //       scrollDirection: Axis.vertical,
              //   //       child: Row(
              //   //         children: [
              //   //           Expanded(
              //   //             child: Text(
              //   //               fin,
              //   //               style: const TextStyle(
              //   //                 color: AppColor.light_grey,
              //   //               ),
              //   //             ),
              //   //           ),
              //   //         ],
              //   //       ),
              //   //     ),
              //   //   );
              //   // },
              //   hideOnError: true,
              //   hideOnEmpty: true,
              //   hideOnLoading: true,
              //   // scrollController: const AlwaysScrollableScrollPhysics(),
              //   // errorBuilder: (context, errorBuilder) {
              //   //   return const SingleChildScrollView(
              //   //     child: ListTile(
              //   //         tileColor: Colors.black,
              //   //         title: Text(
              //   //           "No Result Found!",
              //   //           style: TextStyle(
              //   //             color: AppColor.light_grey,
              //   //           ),
              //   //         )),
              //   //   );
              //   // },
              //   suggestionsCallback: (query) => controller.getSuggestions(query),
              //   onSuggestionSelected: (suggestion) async {
              //     int newSug = suggestion.lastIndexOf(' ');
              //     controller.searchController.value.text = suggestion.substring(0, newSug);
              //     List<String> words = suggestion.split(' ');
              //     String result = words.last;
              //     // log("onSuggestionSelected result ${suggestion.substring(0, newSug)}");

              //     final String detailsRequest =
              //         'https://maps.googleapis.com/maps/api/place/details/json?place_id=$result&key=AIzaSyBBgOn1FtmzyjUnX0Xl6xMFqXYFmSEgdZg';
              //     final detailsResponse = await http.get(Uri.parse(detailsRequest));
              //     final details = json.decode(detailsResponse.body)['result'];
              //     var lat = details['geometry']['location']['lat'];
              //     var lng = details['geometry']['location']['lng'];
              //     var location = details['address_components'][1]['long_name'];

              //     log("onSuggestionSelected ${controller.currentTabId.value}");

              //     await controller.fetchEventsforSelectedId(controller.currentTabId.value, lat: lat, lng: lng);
              //     controller.currentAddressFull.value = suggestion.substring(0, newSug);
              //     controller.currentAddressTitle.value = location;
              //     var jsonString = json.encode({
              //       'lat': lat.toString(),
              //       'lng': lng.toString(),
              //       'fulladdress': controller.currentAddressFull.value,
              //       'title': location
              //     });
              //     log("onSuggestionSelected jsonString $jsonString");

              //     SharedPref.setAddress(jsonString);
              //     SharedPref.setCurrentAddress(controller.currentAddressFull.value);
              //     SharedPref.setTitle(controller.currentAddressTitle.value);
              //     SharedPref.setLat(lat.toString());
              //     SharedPref.setLng(lng.toString());
              //     await controller.getSharedPrefValues();
              //     controller.recentAddress.refresh();
              //     controller.latitude.value = lat.toString();
              //     controller.longitude.value = lng.toString();
              //     // await controller.getSuggestionsTwo(lat, lng);
              //     log("onSuggestionSelected $lat");
              //     log("onSuggestionSelected $lng");
              //     log("onSuggestionSelected $location");
              //     // Get.back();
              //     controller.isLocationSelectionScreenSelected.value = false;
              //     controller.searchController.value.text = "";
              //     // log("onSuggestionSelected $address");
              //   },
              // ),
              Column(
                children: [
                  Obx(() => TextField(
                        controller: controller.searchController.value,
                        style: const TextStyle(color: AppColor.light_grey),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.search,
                            color: AppColor.light_blue,
                          ),
                          hintText: "Search for area, street name.",
                          focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColor.light_grey)),
                          errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColor.light_grey)),
                          errorStyle: const TextStyle(fontSize: 14),
                          counterText: " ",
                          contentPadding: const EdgeInsets.only(bottom: 8, left: 20),
                          errorMaxLines: 3,
                          counterStyle: const TextStyle(color: Colors.white),
                          hintStyle: const TextStyle(color: AppColor.grey, fontFamily: "Sora", fontSize: 14),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: AppColor.white_Color, width: 0.2)),
                        ),
                        onChanged: (query) => controller.getSuggestions(query),
                      )),
                  Obx(() => Visibility(
                        visible: controller.suggestionsList.isEmpty ? false : true,
                        child: SizedBox(
                          height: Get.height - 50.h,
                          child: ListView.separated(
                            separatorBuilder: (context, index) {
                              return Container(
                                height: 1,
                                color: AppColor.light_grey,
                              );
                            },
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: controller.suggestionsList.length,
                            padding: const EdgeInsets.only(bottom: 250),
                            itemBuilder: (_, index) {
                              var suggestion = controller.suggestionsList[index];
                              int newSug = suggestion.lastIndexOf(' ');
                              var fin = suggestion.substring(0, newSug);
                              return ListTile(
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      fin,
                                      style: const TextStyle(
                                        color: AppColor.light_grey,
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: () async {
                                  controller.eventByCategoryList.refresh();

                                  int newSug = suggestion.lastIndexOf(' ');
                                  controller.searchController.value.text = suggestion.substring(0, newSug);
                                  List<String> words = suggestion.split(' ');
                                  String result = words.last;
                                  log(controller.searchController.value.text);

                                  String detailsRequest =
                                      'https://maps.googleapis.com/maps/api/place/details/json?place_id=$result&key=AIzaSyBBgOn1FtmzyjUnX0Xl6xMFqXYFmSEgdZg';
                                  final detailsResponse = await http.get(Uri.parse(detailsRequest));
                                  final details = json.decode(detailsResponse.body)['result'];
                                  var lat = details['geometry']['location']['lat'];
                                  var lng = details['geometry']['location']['lng'];
                                  var location = details['address_components'][1]['long_name'] ?? "";
                                  controller.currentAddressFull.value = suggestion.substring(0, newSug);
                                  controller.currentAddressTitle.value = location;
                                  var jsonString = json.encode({
                                    'lat': lat.toString(),
                                    'lng': lng.toString(),
                                    'fulladdress': controller.currentAddressFull.value,
                                    'title': location
                                  });
                                  log(jsonString);

                                  await SharedPref.setAddress(jsonString);
                                  await SharedPref.setCurrentAddress(controller.currentAddressFull.value);
                                  await SharedPref.setTitle(controller.currentAddressTitle.value);
                                  await SharedPref.setLat(lat.toString());
                                  await SharedPref.setLng(lng.toString());
                                  await controller.getSharedPrefValues();
                                  await controller.fetchEventsforSelectedId(controller.currentTabId.value,
                                      lat: lat.toString(), lng: lng.toString());
                                  controller.eventByCategoryList.refresh();

                                  // var jsonString = json.encode({
                                  //   'lat': lat.toString(),
                                  //   'lng': lng.toString(),
                                  //   'fulladdress': controller.currentAddressFull.value,
                                  //   'title': location
                                  // });

                                  controller.recentAddress.refresh();
                                  controller.latitude.value = lat.toString();
                                  controller.longitude.value = lng.toString();

                                  controller.isLocationSelectionScreenSelected.value = false;
                                  controller.searchController.value.text = "";
                                  controller.suggestionsList.value = [];
                                },
                              );
                            },
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),

              InkWell(
                onTap: () async {
                  await controller.checkLocationPermission("location");
                  // await Geolocator.requestPermission();

                  // controller.isLocationSelectionScreenSelected.value = false;
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.location_pin,
                      color: AppColor.light_grey,
                    ),
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Text(
                    //       "Use current location",
                    //       style: AppTextStyle.textStyle16OpenSans600purple,
                    //     ),
                    //     SizedBox(
                    //       width: Get.width * 0.6,
                    //       child: Text(
                    //         // "Possibility Solutions, c-127,4th floor, phase 8 mohali",
                    //         controller.getCurrentAddressFull.value,
                    //         style: AppTextStyle.textStyle13OpenSans600lightGrey,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Use current location",
                      style: AppTextStyle.textStyle16OpenSans600purple,
                    ),
                    const Spacer(),

                    const Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: AppColor.light_grey,
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: controller.recentAddress.isEmpty ? false : true,
                child: Column(
                  children: [
                    // Container(
                    //   margin: EdgeInsets.symmetric(vertical: 15.h),
                    //   height: 1,
                    //   width: Get.width,
                    //   color: AppColor.light_grey,
                    // ),
                    // Center(
                    //   child: Text(
                    //     "Select a location",
                    //     style: AppTextStyle.textStyle18OpenSans600white,
                    //   ),
                    // ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Obx(() => ListView.separated(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.recentAddress.length,
                        separatorBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 15.h),
                            height: 0,
                            width: Get.width,
                            color: AppColor.light_grey,
                          );
                        },
                        itemBuilder: (context, index) {
                          var itemData = json.decode(controller.recentAddress[index]);

                          return GestureDetector(
                            onTap: () async {
                              controller.currentAddressFull.value = itemData['fulladdress'];
                              controller.currentAddressTitle.value = itemData['title'];
                              controller.latitude.value = itemData['lat'];
                              controller.longitude.value = itemData['lng'];
                              SharedPref.setCurrentAddress(itemData['fulladdress']);
                              SharedPref.setTitle(itemData['title']);
                              SharedPref.setLat(itemData['lat']);
                              SharedPref.setLng(itemData['lng']);
                              await controller.fetchEventsforSelectedId(
                                controller.currentTabId.value,
                                lat: itemData['lat'],
                                lng: itemData['lng'],
                              );

                              controller.isLocationSelectionScreenSelected.value = false;
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  // width: Get.width * 0.15,
                                  child: Icon(
                                    Icons.home,
                                    color: AppColor.light_grey,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: Get.width * 0.7,
                                            child: Text(
                                              // "House no. 60 block H, Top floor, TowerH, Housefed Complex 1, Sector 79. ",
                                              itemData['title'],
                                              style: AppTextStyle.textStyle13OpenSans600lightGrey,
                                            ),
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.7,
                                            child: Text(
                                              // "House no. 60 block H, Top floor, TowerH, Housefed Complex 1, Sector 79. ",
                                              itemData['fulladdress'],
                                              style: AppTextStyle.textStyle13OpenSans600lightGrey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        })),
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
