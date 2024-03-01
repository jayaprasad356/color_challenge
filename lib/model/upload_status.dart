class UploadStatus {
  bool? success;
  String? message;

  UploadStatus({this.success, this.message});

  UploadStatus.fromJson(Map<String, dynamic> json) {
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
