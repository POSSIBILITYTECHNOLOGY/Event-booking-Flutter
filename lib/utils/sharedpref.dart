import 'package:event_booking/utils/string_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static Future<String?> getUpdatedImage() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.getString(StringHelper.USERIMAGE);
  }

  static Future<bool> setUpdatedImage(String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.setString(StringHelper.USERIMAGE, value);
  }

  static Future<String?> getAuthToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.getString(StringHelper.PREF_AUTH_TOKEN);
  }

  static Future<bool> setAuthToken(String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.setString(StringHelper.PREF_AUTH_TOKEN, value);
  }

  static Future<bool> setCardIdForPayment(String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.setString(StringHelper.CARDIDFORPAYMENT, value);
  }

  static Future<bool> setFirstName(String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.setString(StringHelper.FIRSTNAME, value);
  }

  static Future<bool> setSocialLogin(String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.setString(StringHelper.socialLogin, value);
  }

  static Future<String?> getSocialLogin() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.getString(StringHelper.socialLogin);
  }

  static Future<String?> getFirstName() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.getString(StringHelper.FIRSTNAME);
  }

  static Future<bool> setLastName(String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.setString(StringHelper.LASTNAME, value);
  }

  static Future<String?> getLastName() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.getString(StringHelper.LASTNAME);
  }

  static Future<bool> setEmail(String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.setString(StringHelper.EMAIL, value);
  }

  static Future<String?> getEmail() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.getString(StringHelper.EMAIL);
  }

  static Future<String?> getPhoneNumber() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.getString(StringHelper.PHONENUMBER);
  }

  static Future<bool> setPhoneNumber(String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.setString(StringHelper.PHONENUMBER, value);
  }

  static Future<String?> getCurrentAddress() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.getString(StringHelper.currentAddress);
  }

  static Future<bool> setCurrentAddress(String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.setString(StringHelper.currentAddress, value);
  }

  static Future<String?> getLat() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.getString(StringHelper.lat);
  }

  static Future<bool> setLat(String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.setString(StringHelper.lat, value);
  }

  static Future<String?> getLng() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.getString(StringHelper.lng);
  }

  static Future<bool> setLng(String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.setString(StringHelper.lng, value);
  }

  static Future<String?> getTitle() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.getString(StringHelper.currentAddressTitle);
  }

  static Future<bool> setTitle(String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.setString(StringHelper.currentAddressTitle, value);
  }

  // * Address List

  static Future<void> setAddress(String value) async {
    final prefs = await SharedPreferences.getInstance();

    List<String>? addresses = prefs.getStringList(StringHelper.addressList);
    addresses ??= [];

    // Check if the new address already exists in the list
    if (!addresses.contains(value)) {
      // Add the new address to the beginning of the list
      addresses.insert(0, value);

      // Only keep the most recent 5 addresses
      if (addresses.length > 5) {
        addresses.removeLast();
      }

      // Save the updated list of addresses to shared preferences
      await prefs.setStringList(StringHelper.addressList, addresses);
    }
  }

  static Future<List<String>?> getAddress() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.getStringList(StringHelper.addressList);
  }

  static Future<Future<bool>> clear() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.clear();
  }
}
