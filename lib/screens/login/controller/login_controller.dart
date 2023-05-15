import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:event_booking/data/apiClient/api_client.dart';
import 'package:event_booking/data/api_Url/api_urls.dart';
import 'package:event_booking/res/colors.dart';
import 'package:event_booking/routes/app_routes.dart';
import 'package:event_booking/screens/change_password/controller/change_password_controller.dart';
import 'package:event_booking/screens/login/model/login_model.dart';
import 'package:event_booking/utils/sharedpref.dart';
import 'package:event_booking/utils/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../utils/loader.dart';
import '../../setting/controller/settings_controller.dart';

class LoginController extends GetxController {
  ApiClient apiClient = ApiClient();
  TextEditingController emailController = TextEditingController();
  var emailValue = "".obs;
  var isVisible = true.obs;
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _loginformKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<FormState>();

  // * FLutter Secure storage
  // Future<void> _storeUserInformationInKeychain(String email, String firstName, String lastName) async {
  //   if (email.isNotEmpty) {
  //     await _storage.write(key: 'apple_email', value: email);
  //   }
  //   if (firstName.isNotEmpty) {
  //     await _storage.write(key: 'apple_first_name', value: firstName);
  //   }
  //   if (lastName.isNotEmpty) {
  //     await _storage.write(key: 'apple_last_name', value: lastName);
  //   }
  // }

  // Future<void> _loadUserInformationFromKeychain() async {
  //   email = await storage.read(key: 'apple_email') ?? '';
  //   firstName = await storage.read(key: 'apple_first_name') ?? '';
  //   lastName = await storage.read(key: 'apple_last_name') ?? '';

  //   print("datafromkeychain");
  //   print(_email);
  //   print(_firstName);
  //   print(_lastName);
  // }

  @override
  void onClose() {
    emailController.clear();
    passwordController.clear();

    super.onClose();
  }

  @override
  void onInit() {
    // getSharedPrefValues();
    checkLocationPermission();
    getCurrentLocation();
    log("Login Controller onInit");
    super.onInit();
  }

  GlobalKey<FormState> get loginformKey => _loginformKey;

  get scaffoldKey => _scaffoldKey;

  set scaffoldKey(value) => _scaffoldKey = value;

  set loginformKey(value) => _loginformKey = value;

  onTapLogin() {
    if (_loginformKey.currentState!.validate()) {
      loginApi(emailController.text.trim().toString(), passwordController.text.trim().toString());
      log("onTapLogin");
    } else {
      log("error");
    }
  }

// * Asing for location Perission
  Future<bool> checkLocationPermission() async {
    log("checkLocationPermission");
    // Test if location services are enabled.
    var serviceEnabled = await Geolocator.isLocationServiceEnabled();
    log("checkLocationPermission => $serviceEnabled");
    LocationPermission permission = await Geolocator.checkPermission();
    permission == LocationPermission.denied ? await Geolocator.requestPermission() : null;

    if (permission == LocationPermission.denied) {
      // await Geolocator.requestPermission();

      // showSnackBar("What's Poppin", 'Location Permission Denied', AppColor.light_grey);
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      // await fetchCategoryList();
      Future.error('Location permissions are denied');
      // return true;
      // return false;
    } else if (permission == LocationPermission.deniedForever) {
      // await fetchCategoryList();
      Future.error('Location permissions are permanently denied, we cannot request permissions.');
      // Permissions are denied forever, handle appropriately.
      // return true;
    } else {
      await getCurrentLocation();
      return true;
    }
    return true;
  }

  Future getCurrentLocation() async {
    // Get.dialog(const Loader(), barrierDismissible: false);

    final Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

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

    // await SharedPref.setAddress(jsonString);
    await getSharedPrefValues();

    // Get.back();
  }

  Future<dynamic> loginApi(String? email, String? password) async {
    await checkLocationPermission();

    Get.dialog(const Loader(), barrierDismissible: false);
    var response = await apiClient.callPostApi(ApiUrl.loginApi, {"username": email, "password": password});
    var loginDetail = LoginModel.fromJson(response);
    log("$loginDetail");
    if (loginDetail.status == 200) {
      await SharedPref.setAuthToken(loginDetail.data!.accessToken!.toString());
      await SharedPref.setEmail(email ?? " ");
      await SharedPref.setFirstName(loginDetail.data!.firstName ?? "");
      await SharedPref.setLastName(loginDetail.data!.lastName ?? "");
      await SharedPref.setPhoneNumber(loginDetail.data!.mobile ?? "");
      await SharedPref.setUpdatedImage(loginDetail.data!.image ?? "");
      await SharedPref.setSocialLogin("false");
      Get.find<SettingsController>().userToken.value = loginDetail.data!.accessToken ?? "";
      Get.find<ChangePasswordController>().getTocken.value = loginDetail.data!.accessToken ?? "";
      Get.back();
      emailController.clear();
      passwordController.clear();
      log("$loginDetail");
      Get.back();

      // showSnackBar("LogIn Successfully", loginDetail.message.toString(),
      //     AppColor.light_blue);
      // showvalidationMsg(Get.context! , loginDetail.message ?? " ");
      Get.toNamed(AppRoutes.bottom_nav_Screen);
    } else {
      Get.back();

      showSnackBar("What's Poppin", loginDetail.message.toString(), AppColor.light_grey);

      // showvalidationMsg(Get.context! , loginDetail.message ?? " ");
    }
    // Get.back();
  }

  getSharedPrefValues() {
    SharedPref.getEmail().then((value) {
      if (value != null) {
        emailValue.value = value;
        // emailController.text = emailValue.value;
      }
    });
  }

// ! Social Login
// * Google Login
  Future<GoogleSignInAccount?> googleSignInProcess() async {
    await checkLocationPermission();

    Get.dialog(const Loader(), barrierDismissible: false);

    final GoogleSignIn googleSignIn;
    // Get.back();

    if (Platform.isAndroid) {
      googleSignIn = GoogleSignIn();
    } else {
      googleSignIn = GoogleSignIn(clientId: "727941045826-dcvuf9usj1na8qnrp7idqn8nu0jaul49.apps.googleusercontent.com");
    }
    update();

    // GoogleSignIn _googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleUser = await googleSignIn.signIn().then((value) async {
      // log("Google ID ${value!.id}");

      if (value != null) {
        // log("googleSignInProcess $value");
        SharedPref.setEmail(value.email);
        var names = value.displayName!.split(' ');

        update();
        Get.back();
        var body = {
          "email": value.email,
          "first_name": names[0].toString(),
          "last_name": names[1].toString(),
          "social_id": value.id,
          "image": value.photoUrl ?? "",
        };
        log(body.toString());
        await ApiClient().callPostApi(ApiUrl.socialLoginApi, body).then((apiValue) async {
          // log("googleSignInProcess callPostApi $apiValue");
          // log("googleSignInProcess callPostApi ${apiValue['data']['access_token']}");
          await SharedPref.setAuthToken(apiValue['data']['access_token']);
          await SharedPref.setSocialLogin("true");
          await SharedPref.setUpdatedImage(apiValue['data']['image'] ?? "");
          await SharedPref.setFirstName(apiValue['data']['first_name'] ?? "");
          await SharedPref.setLastName(apiValue['data']['last_name'] ?? "");
          await Get.toNamed(AppRoutes.bottom_nav_Screen);
          log("googleSignInProcess callPostApi Google Login Successfully");
        });

        return;
      } else {
        Get.back();
        return null;
      }
    });

    log("object1");

    update();

    return googleUser;
  }

// * Apple Login
  Future<void> signInWithApple() async {
    Get.dialog(const Loader(), barrierDismissible: false);

    await checkLocationPermission();

    log('signInWithApple');

    update();
    Get.back();

    try {
      await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      ).then((value) async {
        // if (value.userIdentifier!.isNotEmpty) {
        final token = value.identityToken;
        final encodedPayload = token!.split('.')[1];
        final payloadData = const Utf8Codec().fuse(base64).decode(base64.normalize(encodedPayload));
        log(payloadData.toString());
        if (value != "") {
          log("signInWithApple ");
          // log("signInWithApple User Identifier ${value.userIdentifier}");
          log("signInWithApple NAME ${value.familyName}");
          // log("signInWithApple EMAIL ${value.email}");

          ApiClient().callPostApi(ApiUrl.socialLoginApi, {
            // "email": value.email ?? "",
            "social_id": value.userIdentifier,
            "first_name": value.givenName?.toString() ?? "",
            "last_name": value.familyName?.toString() ?? "",
          }).then((value) async {
            if (value != null) {
              log("signInWithApple Apple Login Successfully");
              // print("signInWithApple ${value['token']}");

              // SharedPref.setAuthToken(value['token']);

              await SharedPref.setSocialLogin("true");
              await SharedPref.setEmail(value['data']['email']);

              // Get.defaultDialog(title: "Token", middleText: "Token Code ${value['data']['access_token']}");
              await SharedPref.setAuthToken(value['data']['access_token']);
              await SharedPref.setUpdatedImage(value['data']['image'] ?? "");
              await SharedPref.setFirstName(value['data']['first_name'] ?? "");
              await SharedPref.setLastName(value['data']['last_name'] ?? "");
              Get.back();

              Get.toNamed(AppRoutes.bottom_nav_Screen);

              update();
            }
          });

          update();
          // Navigator.pop(context);
          log("signInWithApple value_apple_null1");
        } else {
          Get.back();

          update();
          log("signInWithApple value_apple_null");
          log(value.toString());
        }

        update();
      });

      // Use the credential to sign in to your backend server
      // ...
    } catch (error) {
      // Get.snackbar(
      //   'Error',
      //   'Failed to sign in with Apple: $error',
      //   backgroundColor: Colors.red,
      //   colorText: Colors.white,
      //   snackPosition: SnackPosition.BOTTOM,
      // );
    }
  }
}
