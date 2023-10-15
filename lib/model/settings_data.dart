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
  String? watchAdStatus;
  String? offerImage;
  String? referBonus;
  String? whatsppGroupLink;
  String? a1JobVideo;
  String? postVideoUrl;
  String? postVideoDetails;
  String? a1JobDetails;
  String? a2JobDetails;
  String? a2JobVideo;
  String? a1PurchaseLink;
  String? a2PurchaseLink;
  String? rewardAdsDetails;

  Data(
      {this.id,
        this.withdrawalStatus,
        this.contactUs,
        this.minWithdrawal,
        this.image,
        this.watchAdStatus,
        this.offerImage,
        this.referBonus,
        this.whatsppGroupLink,
        this.a1JobVideo,
        this.postVideoUrl,
        this.postVideoDetails,
        this.a1JobDetails,
        this.a2JobDetails,
        this.a2JobVideo,
        this.a1PurchaseLink,
        this.a2PurchaseLink,
        this.rewardAdsDetails});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    withdrawalStatus = json['withdrawal_status'];
    contactUs = json['contact_us'];
    minWithdrawal = json['min_withdrawal'];
    image = json['image'];
    watchAdStatus = json['watch_ad_status'];
    offerImage = json['offer_image'];
    referBonus = json['refer_bonus'];
    whatsppGroupLink = json['whatspp_group_link'];
    a1JobVideo = json['a1_job_video'];
    postVideoUrl = json['post_video_url'];
    postVideoDetails = json['post_video_details'];
    a1JobDetails = json['a1_job_details'];
    a2JobDetails = json['a2_job_details'];
    a2JobVideo = json['a2_job_video'];
    a1PurchaseLink = json['a1_purchase_link'];
    a2PurchaseLink = json['a2_purchase_link'];
    rewardAdsDetails = json['reward_ads_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['withdrawal_status'] = withdrawalStatus;
    data['contact_us'] = contactUs;
    data['min_withdrawal'] = minWithdrawal;
    data['image'] = image;
    data['watch_ad_status'] = watchAdStatus;
    data['offer_image'] = offerImage;
    data['refer_bonus'] = referBonus;
    data['whatspp_group_link'] = whatsppGroupLink;
    data['a1_job_video'] = a1JobVideo;
    data['post_video_url'] = postVideoUrl;
    data['post_video_details'] = postVideoDetails;
    data['a1_job_details'] = a1JobDetails;
    data['a2_job_details'] = a2JobDetails;
    data['a2_job_video'] = a2JobVideo;
    data['a1_purchase_link'] = a1PurchaseLink;
    data['a2_purchase_link'] = a2PurchaseLink;
    data['reward_ads_details'] = rewardAdsDetails;
    return data;
  }
}
