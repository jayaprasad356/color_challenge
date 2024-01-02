class OrdersList {
  bool? success;
  String? message;
  List<Data>? data;

  OrdersList({this.success, this.message, this.data});

  OrdersList.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? image;
  String? description;
  String? categoryId;
  String? ads;
  String? originalPrice;
  String? status;
  String? deliveryDate;

  Data(
      {this.id,
        this.name,
        this.image,
        this.description,
        this.categoryId,
        this.ads,
        this.originalPrice,
        this.status,
        this.deliveryDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    categoryId = json['category_id'];
    ads = json['ads'];
    originalPrice = json['original_price'];
    status = json['status'];
    deliveryDate = json['delivery_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['description'] = description;
    data['category_id'] = categoryId;
    data['ads'] = ads;
    data['original_price'] = originalPrice;
    data['status'] = status;
    data['delivery_date'] = deliveryDate;
    return data;
  }
}
