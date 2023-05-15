// import 'package:event_booking/app_style/app_style.dart';
// import 'package:event_booking/res/appImages.dart';
// import 'package:event_booking/res/colors.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:get/get.dart';

// class HomeScreenVerticalList extends StatelessWidget {
//   const HomeScreenVerticalList({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SliverList(
//         // physics: const NeverScrollableScrollPhysics(),

//         // scrollDirection: Axis.vertical,
//         delegate: SliverChildBuilderDelegate(childCount: 50, (context, index) {
//       return Container(
//         margin: EdgeInsets.only(top: 15.h),
//         height: 103.h,
//         // width: 169.w,
//         decoration: BoxDecoration(color: AppColor.dark_grey, borderRadius: BorderRadius.circular(16)),
//         child: Row(
//           children: [
//             Container(
//               height: 103.h,
//               width: 102.w,
//               decoration: BoxDecoration(
//                   image: const DecorationImage(image: AssetImage(AppImages.event_Image_1), fit: BoxFit.fill),
//                   borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r), bottomLeft: Radius.circular(16.r))),
//             ),
//             Padding(
//               padding: EdgeInsets.only(top: 5.h, left: 11.w),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Yacht Paerties",
//                     style: AppTextStyle.textStyle16Roboto500purple,
//                   ),
//                   SizedBox(
//                     height: 3.h,
//                   ),
//                   SizedBox(
//                       width: Get.width * 0.5,
//                       child: Text("A dinner party is a great way to acquaint ",
//                           overflow: TextOverflow.ellipsis, maxLines: 2, style: AppTextStyle.textStyle12Roboto400lightGrey)),
//                   SizedBox(
//                     height: 8.h,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Container(
//                         padding: EdgeInsets.only(left: 5.w, right: 5.w),
//                         height: 22.h,
//                         // width: 92.w,
//                         decoration: BoxDecoration(color: AppColor.light_black, borderRadius: BorderRadius.circular(20)),
//                         child: Center(
//                             child: Text(
//                           "FRI,JUL 22,2022",
//                           overflow: TextOverflow.ellipsis,
//                           style: AppTextStyle.textStyle9Roboto500white,
//                         )),
//                       ),
//                       SizedBox(
//                         width: 8.w,
//                       ),
//                       Container(
//                         padding: EdgeInsets.only(left: 5.w, right: 5.w),
//                         height: 22.h,
//                         // width: 52.w,
//                         decoration: BoxDecoration(color: AppColor.light_black, borderRadius: BorderRadius.circular(20)),
//                         child: Center(
//                             child: Text(
//                           "10:00 PM",
//                           overflow: TextOverflow.ellipsis,
//                           style: AppTextStyle.textStyle9Roboto500white,
//                         )),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       );
//     }));
//   }
// }

// class HomeScreenVerticalList2 extends StatelessWidget {
//   const HomeScreenVerticalList2({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SliverToBoxAdapter(
//       child: SingleChildScrollView(
//         physics: const NeverScrollableScrollPhysics(),
//         child: GridView.custom(
//             physics: const NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             gridDelegate: SliverQuiltedGridDelegate(
//               crossAxisCount: 4,
//               mainAxisSpacing: 8,
//               crossAxisSpacing: 8,
              
//               // repeatPattern: QuiltedGridRepeatPattern.inverted,
//               pattern: [
//                 const QuiltedGridTile(2, 2),
//                 const QuiltedGridTile(2, 2),
//               ],
//             ),
//             scrollDirection: Axis.vertical,
            
//             childrenDelegate: SliverChildBuilderDelegate(childCount: 9, (context, index) {
//               return Container(
//                 // margin: EdgeInsets.only(right: 21.w),
//                 width: Get.width,
//                 height: 230,
//                 decoration: BoxDecoration(color: AppColor.dark_grey, borderRadius: BorderRadius.circular(16.r)),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       height: 100.h,
//                       child: Stack(children: [
//                         Container(
//                           decoration: const BoxDecoration(
//                             borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//                             image: DecorationImage(
//                               image: AssetImage(
//                                 AppImages.event_Image_1,
//                               ),
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                           height: 100.h,
//                           width: Get.width,
//                         ),
//                         Positioned(
//                             top: 14.h,
//                             right: 8.w,
//                             child: Image.asset(
//                               AppImages.bottom_nav_favourite_unselected_Icon,
//                               height: 15.h,
//                               width: 15.h,
//                             )),
//                       ]),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 8.w),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Container(
//                                 padding: EdgeInsets.only(left: 5.w, right: 5.w),
//                                 height: 22.h,
//                                 // width: 92.w,
//                                 decoration: BoxDecoration(color: AppColor.light_black, borderRadius: BorderRadius.circular(20)),
//                                 child: Center(
//                                     child: Text(
//                                   "FRI,JUL 22,2022",
//                                   overflow: TextOverflow.ellipsis,
//                                   style: AppTextStyle.textStyle9Roboto500white,
//                                 )),
//                               ),
//                               Container(
//                                 padding: EdgeInsets.only(left: 5.w, right: 5.w),
//                                 height: 22.h,
//                                 // width: 52.w,
//                                 decoration: BoxDecoration(color: AppColor.light_black, borderRadius: BorderRadius.circular(20)),
//                                 child: Center(
//                                     child: Text(
//                                   "10:00 PM",
//                                   overflow: TextOverflow.ellipsis,
//                                   style: AppTextStyle.textStyle9Roboto500white,
//                                 )),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 5.h,
//                           ),
//                           Text(
//                             "Dinner Party",
//                             overflow: TextOverflow.ellipsis,
//                             style: AppTextStyle.textStyle16Roboto500purple,
//                           ),
//                           Text("A dinner party is a great way to acquaint.",
//                               overflow: TextOverflow.ellipsis, maxLines: 2, style: AppTextStyle.textStyle10Roboto400lightGrey)
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             })),
//       ),
//     );
//   }
// }
