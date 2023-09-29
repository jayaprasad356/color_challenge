class SettingData {
  bool? success;
  String? message;
  List<Data>? data;

  SettingData({this.success, this.message, this.data});

  SettingData.fromJson(Map<String, dynamic> json) {
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
  String? withdrawalStatus;
  String? contactUs;
  String? minWithdrawal;
  String? image;
  String? offerImage;
  String? referBonus;
  String? whatsappChannelLink;
  String? jobVideo;
  String? postVideoUrl;
  String? postVideoDetails;
  String? jobDetails;

  Data(
      {this.id,
        this.withdrawalStatus,
        this.contactUs,
        this.minWithdrawal,
        this.image,
        this.offerImage,
        this.referBonus,
        this.whatsappChannelLink,
        this.jobVideo,
        this.postVideoUrl,
        this.postVideoDetails,
        this.jobDetails});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    withdrawalStatus = json['withdrawal_status'];
    contactUs = json['contact_us'];
    minWithdrawal = json['min_withdrawal'];
    image = json['image'];
    offerImage = json['offer_image'];
    referBonus = json['refer_bonus'];
    whatsappChannelLink = json['whatsapp_channel_link'];
    jobVideo = json['job_video'];
    postVideoUrl = json['post_video_url'];
    postVideoDetails = json['post_video_details'];
    jobDetails = json['job_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['withdrawal_status'] = withdrawalStatus;
    data['contact_us'] = contactUs;
    data['min_withdrawal'] = minWithdrawal;
    data['image'] = image;
    data['offer_image'] = offerImage;
    data['refer_bonus'] = referBonus;
    data['whatsapp_channel_link'] = whatsappChannelLink;
    data['job_video'] = jobVideo;
    data['post_video_url'] = postVideoUrl;
    data['post_video_details'] = postVideoDetails;
    data['job_details'] = jobDetails;
    return data;
  }
}
