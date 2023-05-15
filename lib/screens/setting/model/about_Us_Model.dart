// ignore_for_file: file_names

class AboutUsModel {
  bool? success;
  int? status;
  Data? data;
  String? message;

  AboutUsModel({this.success, this.status, this.data, this.message});

  AboutUsModel.fromJson(Map<String, dynamic> json) {
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
  String? aboutUs;

  Data({this.aboutUs});

  Data.fromJson(Map<String, dynamic> json) {
    aboutUs = json['about_us'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['about_us'] = aboutUs;
    return data;
  }
}
