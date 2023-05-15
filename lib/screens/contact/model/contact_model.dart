class ContactModel {
  String? message;
  bool? success;
  int? status;

  ContactModel({this.message, this.success, this.status});

  ContactModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['success'] = success;
    data['status'] = status;
    return data;
  }
}
