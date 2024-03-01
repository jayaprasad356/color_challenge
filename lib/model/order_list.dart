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
        data!.add(new Data.fromJson(v));
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
  String? productId;
  String? name;
  String? image;
  String? description;
  String? status;
  String? categoryId;
  String? ads;
  String? originalPrice;
  String? categoryName;
  String? categoryImage;
  String? categoryStatus;
  String? deliveryDate;

  Data(
      {this.productId,
        this.name,
        this.image,
        this.description,
        this.status,
        this.categoryId,
        this.ads,
        this.originalPrice,
        this.categoryName,
        this.categoryImage,
        this.categoryStatus,
        this.deliveryDate});

  Data.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    status = json['status'];
    categoryId = json['category_id'];
    ads = json['ads'];
    originalPrice = json['original_price'];
    categoryName = json['category_name'];
    categoryImage = json['category_image'];
    categoryStatus = json['category_status'];
    deliveryDate = json['delivery_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['name'] = name;
    data['image'] = image;
    data['description'] = description;
    data['status'] = status;
    data['category_id'] = categoryId;
    data['ads'] = ads;
    data['original_price'] = originalPrice;
    data['category_name'] = categoryName;
    data['category_image'] = categoryImage;
    data['category_status'] = categoryStatus;
    data['delivery_date'] = deliveryDate;
    return data;
  }
}
