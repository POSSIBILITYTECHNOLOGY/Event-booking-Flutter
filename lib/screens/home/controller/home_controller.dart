import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:event_booking/data/apiClient/api_client.dart';
import 'package:event_booking/data/api_Url/api_urls.dart';
import 'package:event_booking/utils/constants.dart';
import 'package:event_booking/utils/loader.dart';
import 'package:event_booking/utils/sharedpref.dart';
import 'package:event_booking/utils/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../../../res/colors.dart';

class HomeController extends GetxController {
  // * Controllers
  TabController? tabController;

  Completer<GoogleMapController> _googleMapController = Completer<GoogleMapController>();
  get googleMapController => _googleMapController;

  set googleMapController(value) => _googleMapController = value;

  var searchController = TextEditingController().obs;

  // * Add New Card
  var firstNameOnCardController = TextEditingController().obs;
  var lastNameOnCardController = TextEditingController().obs;
  var cardNumberController = TextEditingController().obs;

  var cardExpiryController = TextEditingController().obs;
  var cardExpiryMonthController = TextEditingController().obs;
  var cardExpiryYearController = TextEditingController().obs;
  var cardCVVController = TextEditingController().obs;

  // * Night Club Form
  var venueNightClub = TextEditingController().obs;
  var dateNightClub = TextEditingController().obs;
  var emailNightClub = TextEditingController().obs;
  var cellNightClub = TextEditingController().obs;
  var numberOfPeopleNightClub = TextEditingController().obs;
  var minimumSpendNightClub = TextEditingController().obs;
  var nameOfTableNightClub = TextEditingController().obs;

  // * Dirnne Form
  var venueDinner = TextEditingController().obs;
  var nameDinner = TextEditingController().obs;
  var dateDinner = TextEditingController().obs;
  var timeDinner = TextEditingController().obs;
  var partySizeDinner = TextEditingController().obs;
  var numberDinner = TextEditingController().obs;
  var emailDinner = TextEditingController().obs;

  // * Yacht Form
  var nameYacht = TextEditingController().obs;
  var dateYacht = TextEditingController().obs;
  var numberOfPeopleYacht = TextEditingController().obs;

  // * Variables
  var apiClient = ApiClient();

  var currentIndex = 0.obs;
  var ticketCount = 1.obs;
  var imgIndex = 0.obs;

  var authToken = "".obs;
  var currentTab = "".obs;
  var currentTabId = "".obs;
  var currentCardbId = "".obs;
  var profilePic = "".obs;
  var checkOutSelectDate = "Select Date".obs;
  // * Address
  var currentAddressTitle = "What's Poppin".obs;
  var currentAddressFull = "Please select address from address page".obs;
  var getCurrentAddressFull = "".obs;
  var placeId = "".obs;
  var latitude = "".obs;
  var longitude = "".obs;

  var tableBookingTab = false.obs;
  var isLoading = false.obs;
  var isLocationSelectionScreenSelected = false.obs;

// * Lists
  var categoryList = [].obs;
  var recentAddress = [].obs;
  var suggestionsList = [].obs;
  var cardList = [].obs;
  var eventByCategoryList = [].obs;
  var eventByCategoryListTemp = [].obs;
  var eventByCategoryImageList = [].obs;
  var tabs = <String>["ALL", "NIGHT CLUBS", "DINNERS", "HOUSES", "YACHT"].obs;

  // * Static Images
  final List<String> imgListPhotos = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  // * Form Keys
  GlobalKey<FormState> _formKeyNightClub = GlobalKey<FormState>();
  GlobalKey<FormState> _formKeyDinners = GlobalKey<FormState>();
  GlobalKey<FormState> _formKeyYacht = GlobalKey<FormState>();
  GlobalKey<FormState> _formKeyLocationSelect = GlobalKey<FormState>();
  GlobalKey<FormState> _formKeyAddNewCard = GlobalKey<FormState>();

  // * Getter Setter
  get formKeyLocationSelect => _formKeyLocationSelect;

  get formKeyAddNewCard => _formKeyAddNewCard;

  set formKeyAddNewCard(value) => _formKeyAddNewCard = value;

  set formKeyLocationSelect(value) => _formKeyLocationSelect = value;
  get formKeyDinners => _formKeyDinners;

  set formKeyDinners(value) => _formKeyDinners = value;
  get formKeyYacht => _formKeyYacht;

  set formKeyYacht(value) => _formKeyYacht = value;
  get formKeyNightClub => _formKeyNightClub;

  set formKeyNightClub(value) => _formKeyNightClub = value;

// * Methods

  onTapAddNewCard() async {
    log("onTapAddNewCard");

    if (_formKeyAddNewCard.currentState!.validate()) {
      var body = {
        "name_on_card": "${firstNameOnCardController.value.text} ${lastNameOnCardController.value.text}",
        "card_number": cardNumberController.value.text.replaceAll(" ", ""),
        "card_expiry_month": cardExpiryMonthController.value.text,
        "card_expiry_year": cardExpiryYearController.value.text,
        "card_cvv": cardCVVController.value.text,
      };
      log("onTapAddNewCard body $body");

      await addNewCard(body).then((value) {
        if (value == true) {
          listAllCards("ADD A CARD");
          cardList.refresh();
          log("$value");
        } else {
          log("$value");
        }
      });
      // cardList.clear();
      // Get.back(canPop: false);
      // Future.delayed(const Duration(seconds: 2), () async {
      // await listAllCards("ADD A CARD");
      // cardList.refresh();

      // Get.back();
      // });
    }
  }

// * For Card List

  var selectedCard = 0.obs;

  void selectCard(int index) {
    selectedCard.value = index;
  }

  void increaseTicketCount() {
    ticketCount >= 1 ? ticketCount++ : 1;
    log("{increaseTicketCount $ticketCount}");
  }

  void decreaseTicketCount() {
    ticketCount > 1 ? ticketCount-- : 1;
    log("{decreaseTicketCount $ticketCount}");
  }

  void addTab(String title) {
    tabs.add(title);
  }

  void changeTab(int index) {
    currentIndex.value = index;
  }

  getSharedPrefValues() {
    SharedPref.getAuthToken().then((value) {
      if (value != null) {
        // log("getSharedPrefValues $value");
        authToken.value = value;
      }
    });
    SharedPref.getUpdatedImage().then((value) {
      if (value != null) {
        profilePic.value = value;
      }
    });
    SharedPref.getAddress().then((value) {
      if (value != null) {
        recentAddress.value = value;
      }
    });
    SharedPref.getCurrentAddress().then((value) {
      if (value != null) {
        currentAddressFull.value = value;
      }
    });
    SharedPref.getTitle().then((value) {
      if (value != null) {
        currentAddressTitle.value = value;
      }
    });
    SharedPref.getLat().then((value) {
      if (value != null) {
        latitude.value = value;
      }
    });
    SharedPref.getLng().then((value) {
      if (value != null) {
        longitude.value = value;
      }
    });
  }

// * MAP

  final RxSet<Marker> markers = <Marker>{}.obs;

  Future<void> loadMarkers(latitude, longitude) async {
    log("loadMarkers $latitude");
    BitmapDescriptor icon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(60, 60)),
      'assets/icons/map_icon.png',
    );
    log(icon.toString());
    Marker marker = Marker(
      markerId: const MarkerId('marker1'),
      position: LatLng(double.parse(latitude!), double.parse(longitude!)),
      icon: icon,
      // infoWindow: const InfoWindow(title: 'Marker Title1', snippet: 'Marker Snippet'),
    );
    Marker marker1 = Marker(
      markerId: const MarkerId('marker2'),
      position: LatLng(double.parse(latitude!), double.parse(longitude!)),
      icon: icon,
      // infoWindow: const InfoWindow(title: 'Marker ', snippet: 'Marker Snippet'),
    );

    markers.add(marker);
    markers.add(marker1);
  }

  // Set<Marker> get markers => markers;

  // * Places Search
  //  ! Search Places
  Future<List<String>> getSuggestions(String query) async {
    suggestionsList.clear();
    await getSharedPrefValues();
    const String baseURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    // const String type = '(cities)';
    // const String type = '(regions)';
    final String request = '$baseURL?input=$query&key=$googleMapApiKey';
    // final String request = '$baseURL?input=$query&types=$type&key=$googleMapApiKey';
    log(request);
    final response = await http.get(Uri.parse(request));
    final predictions = json.decode(response.body)['predictions'];
    // log(response.body);
    List<String> suggestions = [];
    for (var i = 0; i < predictions.length; i++) {
      String name = "${predictions[i]['description']} ${predictions[i]['place_id']}";
      log("${predictions[i]['structured_formatting']['main_text']} ${predictions[i]['place_id']}");
      placeId.value = predictions[i]['place_id'];
      suggestions.add(name);
      suggestionsList.add(name);
      suggestionsList.refresh();
    }

    return suggestions;
  }

// ! Permission
  Future<bool> checkLocationPermission(callFrom) async {
    log("checkLocationPermission");
    // Test if location services are enabled.
    var serviceEnabled = await Geolocator.isLocationServiceEnabled();
    log("checkLocationPermission $serviceEnabled");
    LocationPermission permission = await Geolocator.checkPermission();
    callFrom == "location" && permission == LocationPermission.denied ? await Geolocator.requestPermission() : null;

    if (permission == LocationPermission.denied) {
      // await Geolocator.requestPermission();

      // showSnackBar("What's Poppin", 'Location Permission Denied', AppColor.light_grey);
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      await fetchCategoryList();
      return Future.error('Location permissions are denied');
    } else if (permission == LocationPermission.deniedForever) {
      await fetchCategoryList();

      // Permissions are denied forever, handle appropriately.
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    } else {
      await getCurrentLocation(callFrom);
      return true;
    }
  }

  // ! getCurrentLocation
  Future getCurrentLocation(callFrom) async {
    // Get.dialog(const Loader(), barrierDismissible: false);

    final Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    latitude.value = position.latitude.toString();
    longitude.value = position.longitude.toString();
    List<Placemark> placemark = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemark[0];
    // log(place.toString());
    var fullAddress = "${place.locality} ${place.subLocality}, ${place.administrativeArea}, ${place.country}";
    log("${place.street}, ${place.locality} ${place.subLocality}, ${place.administrativeArea}, ${place.country}");
    // currentAddressFull.value = fullAddress;
    // getCurrentAddressFull.value = fullAddress;
    // currentAddressTitle.value = place.locality.toString();
    await SharedPref.setCurrentAddress(fullAddress);
    await SharedPref.setTitle(place.locality.toString());
    await SharedPref.setLat(position.latitude.toString());
    await SharedPref.setLng(position.longitude.toString());
    var jsonString = json.encode({
      'lat': position.latitude.toString(),
      'lng': position.longitude.toString(),
      'fulladdress': fullAddress,
      'title': place.locality.toString(),
    });
    log("onSuggestionSelected jsonString $jsonString");

    await SharedPref.setAddress(jsonString);
    await getSharedPrefValues();
    recentAddress.refresh();
    // Get.back();
    callFrom == "location" ? isLocationSelectionScreenSelected(false) : null;
  }

//  * Fetch Categories
  Future<dynamic> fetchCategoryList() async {
    await getSharedPrefValues();
    isLoading(true);
    log("fetchCategoryList");
    // Get.dialog(Loader(), barrierDismissible: false);
    var response = await apiClient.callPostmanGetApi(
      ApiUrl.homeCategory,
    );
    // log("fetchCategoryList Response $response");
    // var data = UpdateProfileModel.fromJson(response);
    // Get.back();
    if (response['status'] == 200) {
      await fetchEventsforSelectedId(response['data'][0]['id']);

      categoryList.value = response['data'];
      log("fetchCategoryList Response ${categoryList[0]['id']}");
      currentTab.value = categoryList[0]['title'];
      currentTabId.value = categoryList[0]['id'].toString();

      isLoading(false);

      // Get.back();x
      // showSnackBar("What's Poppin", response['message'].toString(), AppColor.light_blue);
    } else {
      isLoading(false);

      showSnackBar("What's Poppin", response['message'].toString(), AppColor.light_grey);
    }
    isLoading(false);
  }

//  * Fetch Events for Categories
  Future<dynamic> fetchEventsforSelectedId(id, {lat, lng}) async {
    log("fetchEventsforSelectedId");

    // isLoading(true);
    await getSharedPrefValues();
    // lat = latitude.value;
    // lng = longitude.value;
    var query = {"latitude": latitude.value ?? "$lat", "longitude": longitude.value ?? "$lng"};
    log("fetchEventsforSelectedId Query $query");
    log("fetchEventsforSelectedId Lat ${latitude.value}");
    log("fetchEventsforSelectedId Lng ${longitude.value}");

    Get.dialog(const Loader(), barrierDismissible: false);
    var response = await apiClient.callPostmanGetApi("${ApiUrl.hoByEventsbyCategory}/$id", query: query, token: authToken.value);
    // log("fetchCategoryList Response $response");
    // var data = UpdateProfileModel.fromJson(response);
    // Get.back();
    if (response['status'] == 200) {
      eventByCategoryList.clear();
      eventByCategoryListTemp.clear();

      eventByCategoryList.value = response['data'];
      eventByCategoryListTemp.value = List.from(response['data']);
      log("fetchEventsforSelectedId Length ${eventByCategoryList.length}");

      eventByCategoryList.refresh();

      // eventByCategoryImageList.value = response['data']['images'];
      Get.back();
      // log("fetchEventsforSelectedId Response ${eventByCategoryList[0]['favorite']}");

      // log("fetchEventsforSelectedId Response ${eventByCategoryList[0]}");
      // isLoading(false);

      // showSnackBar("What's Poppin", response['message'].toString(), AppColor.light_blue);
    } else {
      // isLoading(false);
      Get.back();
      log("fetchEventsforSelectedId ${response['message']}");

      // showSnackBar("What's Poppin", response['message'].toString(), AppColor.light_grey);
    }
    // isLoading(false);
  }

  // * Add New Card
  Future<dynamic> addNewCard(body) async {
    log("addNewCard");

    log(authToken.value.toString());
    Get.dialog(const Loader(), barrierDismissible: false);
    var response = await apiClient.callPostApi(ApiUrl.addCard, body, authToken: authToken.value);

    if (response['status'] == 200) {
      // await listAllCards();
      Get.back();

      Get.back();
      // showSnackBar("What's Poppin", response['message'].toString(), AppColor.light_blue);
      firstNameOnCardController.value.clear();
      lastNameOnCardController.value.clear();
      cardExpiryController.value.clear();
      cardCVVController.value.clear();
      cardNumberController.value.clear();
      return true;
    } else {
      Get.back();
      log("addNewCard $response");

      showSnackBar("What's Poppin", response['message'].toString(), AppColor.light_grey);
      return false;
    }
  }

// * List ALl Cards
  Future<dynamic> listAllCards(callFrom) async {
    cardList.clear();
    await getSharedPrefValues();

    // isLoading(true);
    log("listAllCards");

    log(authToken.value.toString());
    Get.dialog(const Loader(), barrierDismissible: false);
    var response = await apiClient.callPostmanGetApi(ApiUrl.listCard, token: authToken.value);
    log("listAllCards Response ${response['data'].length}");
    // var data = UpdateProfileModel.fromJson(response);
    // Get.back();

    if (response['status'] == 200) {
      cardList.clear();
      cardList.value = response['data'];
      currentCardbId.value = cardList.isNotEmpty ? cardList[0]['id'].toString() : "";

      Get.back();
      // callFrom != "" ? Get.back() : null; // log("listAllCards Response ${eventByCategoryList[0]['favorite']}");

      log("listAllCards Length ${cardList.length}");
      return true;
    } else {
      // isLoading(false);
      Get.back();
      // callFrom != "" ? Get.back() : null; // log("listAllCards Response ${eventByCategoryList[0]['favorite']}");

      log("listAllCards ${response['message']}");

      showSnackBar("What's Poppin", response['message'].toString(), AppColor.light_grey);
      return false;
    }
    // isLoading(false);
  }

// * Checkout Pay Button
  Future<dynamic> checkOutPayButton(body) async {
    getSharedPrefValues();

    // isLoading(true);
    log("checkOutPayButton");

    log("checkOutPayButton $body");
    log("checkOutPayButton ${currentTabId.value}");
    Get.dialog(const Loader(), barrierDismissible: false);
    var response = await apiClient.callPostApi(ApiUrl.payAtCheckOutScreen, body, authToken: authToken.value);
    log("checkOutPayButton Response $response");
    // var data = UpdateProfileModel.fromJson(response);
    // Get.back();

    if (response['status'] == 200) {
      Get.back();
      // log("checkOutPayButton Response ${eventByCategoryList[0]['favorite']}");

      // log("checkOutPayButton Response ${eventByCategoryList[0]}");
      return true;
    } else {
      // isLoading(false);
      Get.back();
      log("checkOutPayButton ${response['message']}");

      showSnackBar("What's Poppin", response['message'].toString(), AppColor.light_grey);
      return false;
    }
    // isLoading(false);
  }

// * Favourite
  Future<dynamic> favouriteEvent(eventId, {categoryId, callFrom}) async {
    await getSharedPrefValues();

    // isLoading(true);
    log("favouriteEvent");
    // Get.dialog(Loader(), barrierDismissible: false);
    var response = await apiClient.callPostApi(ApiUrl.favEvent, {"event_id": eventId}, authToken: authToken.value);
    log("favouriteEvent Response $response");
    // var data = UpdateProfileModel.fromJson(response);
    // Get.back();

    if (response['status'] == 200) {
      await fetchEventsforSelectedId(callFrom == "Detail" ? categoryId : currentTabId);
      return true;
    } else {
      // Get.back();
      log("favouriteEvent ${response['message']}");
      showSnackBar("What's Poppin", response['message'].toString(), AppColor.light_grey);
      return false;
    }
    // isLoading(false);
  }

  Future<dynamic> deleteFavouriteEvent(eventId, {categoryId, callFrom}) async {
    getSharedPrefValues();

    // isLoading(true);
    log("deleteFavouriteEvent");
    // Get.dialog(Loader(), barrierDismissible: false);
    var response = await apiClient.callDeleteApi(ApiUrl.removeFavEvent, query: {"event_id": eventId.toString()}, token: authToken.value);
    log("deleteFavouriteEvent Response $response");
    // var data = UpdateProfileModel.fromJson(response);
    // Get.back();

    if (response['status'] == 200) {
      // await fetchEventsforSelectedId(currentTabId);
      await fetchEventsforSelectedId(callFrom == "Detail" ? categoryId : currentTabId);

      return true;
    } else {
      // Get.back();
      log("deleteFavouriteEvent ${response['message']}");
      showSnackBar("What's Poppin", response['message'].toString(), AppColor.light_grey);
      return false;
    }
    // isLoading(false);
  }

  // * Reservation Booking
  Future<dynamic> reservationBooking(body) async {
    await getSharedPrefValues();

    // isLoading(true);
    log("reservationBooking");

    log("reservationBooking $body");
    log("reservationBooking ${currentTabId.value}");
    Get.dialog(const Loader(), barrierDismissible: false);
    var response = await apiClient.callPostApi(ApiUrl.reservationBooking, body, authToken: authToken.value);
    log("reservationBooking Response $response");
    // var data = UpdateProfileModel.fromJson(response);
    // Get.back();

    if (response['status'] == 200) {
      Get.back();
      Get.back();
      // log("reservationBooking Response ${eventByCategoryList[0]['favorite']}");

      // log("reservationBooking Response ${eventByCategoryList[0]}");
      showSnackBar("What's Poppin", response['message'].toString(), AppColor.light_grey);

      return true;
    } else {
      // isLoading(false);
      Get.back();
      log("reservationBooking ${response['message']}");

      showSnackBar("What's Poppin", response['message'].toString(), AppColor.light_grey);
      return false;
    }
    // isLoading(false);
  }

  initCall() {
    fetchCategoryList();
    // getCurrentLocation("location");

    // await getSharedPrefValues();
  }

  @override
  void onInit() {
    super.onInit();
    initCall();
  }
}
