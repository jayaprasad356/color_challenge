class JobsUpload {
  bool? success;
  String? message;

  JobsUpload({this.success, this.message});

  JobsUpload.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}
