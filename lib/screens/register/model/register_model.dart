class RegisterModel {
  bool? success;
  int? status;
  Data? data;
  String? message;

  RegisterModel({this.success, this.status, this.data, this.message});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  int? id;
  String? username;
  String? firstName;
  String? lastName;
  String? email;
  dynamic emailVerifiedAt;
  dynamic socialId;
  String? mobile;
  String? image;
  String? deviceType;
  String? deviceToken;
  bool? online;
  String? userType;
  dynamic stripeCustomerId;
  dynamic stripeConnectedAccountId;
  dynamic printName;
  dynamic cardPayments;
  dynamic transfers;
  dynamic backgroundCheckDate;
  dynamic backgroundCheckDetails;
  bool? backgroundCheckStatus;
  String? stripeAddressVerified;
  String? addressVerified;
  String? accountVerified;
  String? stripeAccountVerified;
  String? status;
  String? notifications;
  dynamic acceptedTermsConditions;
  dynamic country;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;
  String? accessToken;
  String? averageRating;

  Data(
      {this.id,
      this.username,
      this.firstName,
      this.lastName,
      this.email,
      this.emailVerifiedAt,
      this.socialId,
      this.mobile,
      this.image,
      this.deviceType,
      this.deviceToken,
      this.online,
      this.userType,
      this.stripeCustomerId,
      this.stripeConnectedAccountId,
      this.printName,
      this.cardPayments,
      this.transfers,
      this.backgroundCheckDate,
      this.backgroundCheckDetails,
      this.backgroundCheckStatus,
      this.stripeAddressVerified,
      this.addressVerified,
      this.accountVerified,
      this.stripeAccountVerified,
      this.status,
      this.notifications,
      this.acceptedTermsConditions,
      this.country,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.accessToken,
      this.averageRating});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    socialId = json['social_id'];
    mobile = json['mobile'];
    image = json['image'];
    deviceType = json['device_type'];
    deviceToken = json['device_token'];
    online = json['online'];
    userType = json['user_type'];
    stripeCustomerId = json['stripe_customer_id'];
    stripeConnectedAccountId = json['stripe_connected_account_id'];
    printName = json['print_name'];
    cardPayments = json['card_payments'];
    transfers = json['transfers'];
    backgroundCheckDate = json['background_check_date'];
    backgroundCheckDetails = json['background_check_details'];
    backgroundCheckStatus = json['background_check_status'];
    stripeAddressVerified = json['stripe_address_verified'];
    addressVerified = json['address_verified'];
    accountVerified = json['account_verified'];
    stripeAccountVerified = json['stripe_account_verified'];
    status = json['status'];
    notifications = json['notifications'];
    acceptedTermsConditions = json['accepted_terms_conditions'];
    country = json['country'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    accessToken = json['access_token'];
    averageRating = json['average_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['social_id'] = socialId;
    data['mobile'] = mobile;
    data['image'] = image;
    data['device_type'] = deviceType;
    data['device_token'] = deviceToken;
    data['online'] = online;
    data['user_type'] = userType;
    data['stripe_customer_id'] = stripeCustomerId;
    data['stripe_connected_account_id'] = stripeConnectedAccountId;
    data['print_name'] = printName;
    data['card_payments'] = cardPayments;
    data['transfers'] = transfers;
    data['background_check_date'] = backgroundCheckDate;
    data['background_check_details'] = backgroundCheckDetails;
    data['background_check_status'] = backgroundCheckStatus;
    data['stripe_address_verified'] = stripeAddressVerified;
    data['address_verified'] = addressVerified;
    data['account_verified'] = accountVerified;
    data['stripe_account_verified'] = stripeAccountVerified;
    data['status'] = status;
    data['notifications'] = notifications;
    data['accepted_terms_conditions'] = acceptedTermsConditions;
    data['country'] = country;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['access_token'] = accessToken;
    data['average_rating'] = averageRating;
    return data;
  }
}
