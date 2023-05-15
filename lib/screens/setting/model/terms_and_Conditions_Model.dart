// ignore_for_file: file_names

class TermsAndConditionsModel {
  bool? success;
  int? status;
  Data? data;
  String? message;

  TermsAndConditionsModel({this.success, this.status, this.data, this.message});

  TermsAndConditionsModel.fromJson(Map<String, dynamic> json) {
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
  String? termsConditions;

  Data({this.termsConditions});

  Data.fromJson(Map<String, dynamic> json) {
    termsConditions = json['terms_conditions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['terms_conditions'] = termsConditions;
    return data;
  }
}
