class SliderDataItem {
  bool? success;
  String? message;
  List<Data>? data;

  SliderDataItem({this.success, this.message, this.data});

  SliderDataItem.fromJson(Map<String, dynamic> json) {
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

  Data({this.id, this.name, this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}

List<SliderData> sliderData = <SliderData>[
  SliderData(
    img: 'assets/images/Add.jpg',
    title: "Best Phone",
  ),
  SliderData(
    img: 'assets/images/add2.png',
    title: "Best Head Phone",
  ),
  SliderData(
    img: 'assets/images/cosmetics-or-skin-care-product-ads-with-bottle-banner-ad-for-beauty-products-and-leaf-background-glittering-light-effect-design-vector.jpg',
    title: "Best cosmetics",
  ),
];

class SliderData {
  String img;
  String title;

  SliderData({
    required this.img,
    required this.title,
  });
}
