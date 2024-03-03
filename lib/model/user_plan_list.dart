class UserPlanDetail {
  bool? success;
  String? message;
  List<Data>? data;

  UserPlanDetail({this.success, this.message, this.data});

  UserPlanDetail.fromJson(Map<String, dynamic> json) {
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
  String? planId;
  String? income;
  String? joinedDate;
  String? claim;
  String? image;
  String? products;
  String? inviteBonus;
  String? price;
  String? levelIncome;
  String? totalIncome;
  String? dailyIncome;
  String? validity;

  Data(
      {this.id,
        this.userId,
        this.planId,
        this.income,
        this.joinedDate,
        this.claim,
        this.image,
        this.products,
        this.inviteBonus,
        this.price,
        this.levelIncome,
        this.totalIncome,
        this.dailyIncome,
        this.validity});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    planId = json['plan_id'];
    income = json['income'];
    joinedDate = json['joined_date'];
    claim = json['claim'];
    image = json['image'];
    products = json['products'];
    inviteBonus = json['invite_bonus'];
    price = json['price'];
    levelIncome = json['level_income'];
    totalIncome = json['total_income'];
    dailyIncome = json['daily_income'];
    validity = json['validity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['plan_id'] = planId;
    data['income'] = income;
    data['joined_date'] = joinedDate;
    data['claim'] = claim;
    data['image'] = image;
    data['products'] = products;
    data['invite_bonus'] = inviteBonus;
    data['price'] = price;
    data['level_income'] = levelIncome;
    data['total_income'] = totalIncome;
    data['daily_income'] = dailyIncome;
    data['validity'] = validity;
    return data;
  }
}
