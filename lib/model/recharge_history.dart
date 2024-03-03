class RechargeHistory {
  bool? success;
  String? message;
  List<Data>? data;

  RechargeHistory({this.success, this.message, this.data});

  RechargeHistory.fromJson(Map<String, dynamic> json) {
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
  String? rechargeAmount;
  String? status;
  String? datetime;

  Data(
      {this.id,
        this.userId,
        this.image,
        this.rechargeAmount,
        this.status,
        this.datetime});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    image = json['image'];
    rechargeAmount = json['recharge_amount'];
    status = json['status'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['image'] = image;
    data['recharge_amount'] = rechargeAmount;
    data['status'] = status;
    data['datetime'] = datetime;
    return data;
  }
}
