// ignore_for_file: file_names

class PrivacyPolicyModel {
  bool? success;
  int? status;
  Data? data;
  String? message;

  PrivacyPolicyModel({this.success, this.status, this.data, this.message});

  PrivacyPolicyModel.fromJson(Map<String, dynamic> json) {
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
  String? privacyPolicy;

  Data({this.privacyPolicy});

  Data.fromJson(Map<String, dynamic> json) {
    privacyPolicy = json['privacy_policy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['privacy_policy'] = privacyPolicy;
    return data;
  }
}
