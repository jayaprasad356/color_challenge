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
  String? caption;
  String? name;
  String? image;
  String? likes;
  String? shareLink;
  String? userLike;

  Data(
      {this.id,
        this.caption,
        this.name,
        this.image,
        this.likes,
        this.shareLink,
        this.userLike});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    caption = json['caption'];
    name = json['name'];
    image = json['image'];
    likes = json['likes'];
    shareLink = json['share_link'];
    userLike = json['user_like'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['caption'] = caption;
    data['name'] = name;
    data['image'] = image;
    data['likes'] = likes;
    data['share_link'] = shareLink;
    data['user_like'] = userLike;
    return data;
  }
}
