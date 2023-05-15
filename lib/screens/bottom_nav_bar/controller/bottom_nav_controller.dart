import 'package:event_booking/routes/app_routes.dart';
import 'package:event_booking/screens/favourite_screen/favourite_screen.dart';
import 'package:event_booking/screens/home/home_screen.dart';
import 'package:event_booking/screens/setting/settings_screen.dart';
import 'package:event_booking/screens/tickets/tickets_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BottomNavigationController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    pageIndex.value = 0;
  }

  var pageIndex = 0.obs;
  var pageIndexViewTicket = 1.obs;
  void viewTicketClick() async {
    pageIndex.value = 1;
    Get.toNamed(AppRoutes.bottom_nav_Screen);
  }

  var pageList = <Widget>[const HomeScreen(), const TicketsScreen(), const FavouriteScreen(), SettingsScreen()].obs;
}
