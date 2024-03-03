class ActivatePlanMod {
  bool? success;
  String? message;

  ActivatePlanMod({this.success, this.message});

  ActivatePlanMod.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}
