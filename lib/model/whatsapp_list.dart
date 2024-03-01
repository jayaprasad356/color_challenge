class WhatsappList {
  bool? success;
  String? message;
  List<Data>? data;

  WhatsappList({this.success, this.message, this.data});

  WhatsappList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? userId;
  String? image;
  String? noOfViews;
  String? status;
  String? datetime;

  Data(
      {this.id,
        this.userId,
        this.image,
        this.noOfViews,
        this.status,
        this.datetime});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    image = json['image'];
    noOfViews = json['no_of_views'];
    status = json['status'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['image'] = image;
    data['no_of_views'] = noOfViews;
    data['status'] = status;
    data['datetime'] = datetime;
    return data;
  }
}
