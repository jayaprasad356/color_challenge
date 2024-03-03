class PlanDetail {
  bool? success;
  String? message;
  List<Data>? data;

  PlanDetail({this.success, this.message, this.data});

  PlanDetail.fromJson(Map<String, dynamic> json) {
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
  String? products;
  String? price;
  String? totalIncome;
  String? image;
  String? dailyIncome;
  String? validity;
  String? inviteBonus;
  String? levelIncome;

  Data(
      {this.id,
        this.products,
        this.price,
        this.totalIncome,
        this.image,
        this.dailyIncome,
        this.validity,
        this.inviteBonus,
        this.levelIncome});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    products = json['products'];
    price = json['price'];
    totalIncome = json['total_income'];
    image = json['image'];
    dailyIncome = json['daily_income'];
    validity = json['validity'];
    inviteBonus = json['invite_bonus'];
    levelIncome = json['level_income'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['products'] = products;
    data['price'] = price;
    data['total_income'] = totalIncome;
    data['image'] = image;
    data['daily_income'] = dailyIncome;
    data['validity'] = validity;
    data['invite_bonus'] = inviteBonus;
    data['level_income'] = levelIncome;
    return data;
  }
}
