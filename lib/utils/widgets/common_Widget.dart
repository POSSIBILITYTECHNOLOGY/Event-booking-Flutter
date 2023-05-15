// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../res/appImages.dart';
import '../../res/colors.dart';

class CommonBackButtom extends StatelessWidget {
  const CommonBackButtom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topLeft,
        child: InkWell(
          onTap: () {
            Get.back();
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
        ));
  }
}

class CommonAppBar extends StatelessWidget {
  const CommonAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          AppImages.marker_Icon,
          height: 33,
        ),
        const SizedBox(
          width: 12,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                    width: Get.width * 0.32,
                    child: const Text(
                      "Granville Lane",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: AppColor.white_Color, fontFamily: "Roboto", fontSize: 18),
                    )),
                Image.asset(
                  AppImages.drop_down_Icon,
                  height: 5,
                ),
              ],
            ),
            SizedBox(
                width: Get.width * 0.4,
                child: const Text(
                  "3rd Floor,Phase 8",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: AppColor.white_Color, fontFamily: "Roboto", fontSize: 12),
                ))
          ],
        ),
        // Spacer(),
        // Container(
        //   height: 40,
        //   width: 40,
        //   decoration: const BoxDecoration(
        //       shape: BoxShape.circle,
        //       image: DecorationImage(
        //           image: AssetImage(AppImages.user_image), fit: BoxFit.cover)),
        // )
      ],
    );
  }
}

class SettingsCommonAppBar extends StatelessWidget {
  final String? text;

  const SettingsCommonAppBar({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CommonBackButtom(),
        SizedBox(
          width: Get.width * 0.68,
          child: Center(
            child: Text(
              text!,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: AppColor.white_Color, fontFamily: "Roboto", fontWeight: FontWeight.w600, fontSize: 25),
            ),
          ),
        ),
        SizedBox(
          width: Get.width * 0.07,
        ),
      ],
    );
  }
}
// Future showvalidationMsg(BuildContext context,String msg, {Function? func, bool? dissmissible}){
//   return
//     showDialog(
//         context: context,
//         barrierDismissible:dissmissible?? true,
//         builder: (ctx) =>  Dialog(
//           shape: RoundedRectangleBorder(
//               borderRadius:BorderRadius.circular(30.0)),
//           child: Wrap(
//             // height: height,
//             // width: Get.width,
//             runAlignment: WrapAlignment.center,
//             alignment: WrapAlignment.center,
//             children: [
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//
//                   Padding(
//                     padding: const EdgeInsets.only(top: 20.0,bottom: 20,left: 20,right: 20),
//                     child: Text(msg,
//                       style:const TextStyle(fontSize:18),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//
//                   Padding(
//                       padding: const EdgeInsets.only(bottom: 10.0),
//                       child:
//
//                       ElevatedButton(
//                           onPressed: (){
//                             func ==null?
//                             Get.back():func();
//                           }, child: const Text("Ok",style: TextStyle(fontWeight: FontWeight.bold),)
//                       )
//
//                   )
//                 ],
//               ),
//             ],
//           ),
//         )
//     );
// }

SnackbarController showSnackBar(String? title, String? message, Color? color, {EdgeInsets? padding}) {
  return Get.snackbar(title!, message ?? " ", backgroundColor: color, colorText: Colors.white, padding: padding);
}
