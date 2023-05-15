import 'dart:developer';

import 'package:event_booking/data/apiClient/api_client.dart';
import 'package:event_booking/data/api_Url/api_urls.dart';
import 'package:event_booking/res/colors.dart';
import 'package:event_booking/utils/loader.dart';
import 'package:event_booking/utils/sharedpref.dart';
import 'package:event_booking/utils/widgets/common_Widget.dart';
import 'package:get/get.dart';

class TicketsController extends GetxController {
  @override
  void onInit() {
    getSharedPrefValues();
    listAllTickets();
    super.onInit();
  }

// * Variables
  var apiClient = ApiClient();
  var authToken = "".obs;

  var isLoading = false.obs;
  var ticketList = [].obs;
  var ticketListInProgress = [].obs;
  var ticketListCompleted = [].obs;

  // * Shared Pred
  getSharedPrefValues() {
    SharedPref.getAuthToken().then((value) {
      if (value != null) {
        log("getSharedPrefValues $value");
        authToken.value = value;
      }
    });
  }

// * Tickets Fetch
  Future<dynamic> listAllTickets() async {
    isLoading(true);

    ticketList.clear();
    ticketListInProgress.clear();
    ticketListCompleted.clear();
    await getSharedPrefValues();

    log("listAllTickets");

    // Get.dialog(Loader(), barrierDismissible: false);
    var response = await apiClient.callPostmanGetApi(ApiUrl.listTickets, token: authToken.value);
    log("listAllTickets $response");
    // log("listAllTickets Response $response");
    // var data = UpdateProfileModel.fromJson(response);

    // Get.back();

    if (response['status'] == 200) {
      ticketList.value = response['data'];

      for (int i = 0; i < ticketList.length; i++) {
        if (ticketList[i]['status'] == "1") {
          ticketListInProgress.add(ticketList[i]);
        } else if (ticketList[i]['status'] == "2") {
          ticketListCompleted.add(ticketList[i]);
        }
      }

      // log(ticketListCompleted[0].toString());
      // log(ticketListInProgress[0].toString());

      // ticketListCompleted.value = List.from(ticketList);
      // Get.back();
      // log("listAllTickets Response ${eventByCategoryList[0]['favorite']}");

      // log("listAllTickets Response ${eventByCategoryList[0]}");
      isLoading(false);

      return true;
    } else {
      isLoading(false);
      // Get.back();
      log("listAllTickets ${response['message']}");

      showSnackBar("What's Poppin", response['message'].toString(), AppColor.light_grey);
      return false;
    }
  }

  // * Mark As Completed
  Future<dynamic> markAsCompleted(id) async {
    ticketList.clear();
    ticketListInProgress.clear();
    ticketListCompleted.clear();
    await getSharedPrefValues();

    log("listAllTickets");

    Get.dialog(const Loader(), barrierDismissible: false);
    var response = await apiClient.callPostApi(ApiUrl.ticketUpdate, {"ticket_id": id.toString()}, authToken: authToken.value);
    log("markAsCompleted ${response['message']}");

    if (response['status'] == 200) {
      await listAllTickets();
      Get.back();
      Get.back();
      return true;
    } else {
      Get.back();
      log("markAsCompleted ${response['message']}");

      showSnackBar("What's Poppin", response['message'].toString(), AppColor.light_grey);
      return false;
    }
  }
}
