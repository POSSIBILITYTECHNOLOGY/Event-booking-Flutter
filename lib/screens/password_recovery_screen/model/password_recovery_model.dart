class PasswordRecoveryModel {
  bool? success;
  int? status;
  String? message;

  PasswordRecoveryModel({this.success, this.status, this.message});

  PasswordRecoveryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}
