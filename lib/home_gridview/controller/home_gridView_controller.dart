import 'package:event_booking/res/appImages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../screens/home/model/categories_model.dart';

class HomeGridController extends GetxController {
  TabController? tabController;

  var index = 0.obs;

  var tabBarIndexList = <CategoriesModel>[
    CategoriesModel("ALL"),
    CategoriesModel("NIGHT CLUBS"),
    CategoriesModel("DINNERS"),
    CategoriesModel("HOUSES"),
    CategoriesModel("NIGHT CLUBS"),
  ].obs;

  var gridViewList = <String>[
    AppImages.user_image,
    AppImages.user_image,
    AppImages.user_image,
    AppImages.user_image,
    AppImages.user_image,
    AppImages.user_image,
    AppImages.user_image,
  ].obs;
}
