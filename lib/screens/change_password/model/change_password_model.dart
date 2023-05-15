class ChangePasswordModel {
  bool? success;
  String? message;
  int? status;

  ChangePasswordModel({this.success, this.message, this.status});

  ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}
