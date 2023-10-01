class PostList {
  bool? success;
  String? message;
  List<Data>? data;

  PostList({this.success, this.message, this.data});

  PostList.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
  String? caption;
  String? image;
  String? likes;

  Data({this.id, this.name, this.caption, this.image, this.likes});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    caption = json['caption'];
    image = json['image'];
    likes = json['likes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['description'] = caption;
    data['image'] = image;
    data['likes'] = likes;
    return data;
  }
}
