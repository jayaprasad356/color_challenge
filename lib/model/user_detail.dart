class UserDetail {
  bool? success;
  String? message;
  List<Data>? data;
  List<Settings>? settings;

  UserDetail({this.success, this.message, this.data, this.settings});

  UserDetail.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    if (json['settings'] != null) {
      settings = <Settings>[];
      json['settings'].forEach((v) {
        settings!.add(new Settings.fromJson(v));
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
    if (settings != null) {
      data['settings'] = settings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? mobile;
  String? name;
  String? upi;
  String? email;
  String? deaf;
  String? totalReferrals;
  String? earn;
  String? balance;
  String? deviceId;
  String? referredBy;
  String? referCode;
  String? withdrawalStatus;
  String? status;
  String? blocked;
  String? joinedDate;
  String? fcmId;
  String? lastUpdated;
  String? minWithdrawal;
  String? registerBonusSent;
  String? referBonusSent;
  String? generateCoin;
  String? totalAdsViewed;
  String? trailCompleted;
  String? accountNum;
  String? holderName;
  String? bank;
  String? branch;
  String? ifsc;
  String? watchAds;
  String? adsCost;
  String? registeredDate;
  String? basicWallet;
  String? premiumWallet;
  String? totalAds;
  String? todayAds;
  String? targetRefers;
  String? currentRefers;
  String? age;
  String? city;
  String? gender;
  String? supportLan;
  String? supportId;
  String? leadId;
  String? branchId;
  String? workedDays;
  String? plan;
  String? videoWallet;
  String? mediaWallet;
  String? postLeft;
  String? adsTime;
  String? oldPlan;
  String? oldPb;
  String? rewardAds;
  String? lastTodayAds;
  String? tSyncTime;
  String? tSync;
  String? description;
  String? ads10thDay;
  String? performance;
  String? projectType;

  Data(
      {this.id,
        this.mobile,
        this.name,
        this.upi,
        this.email,
        this.deaf,
        this.totalReferrals,
        this.earn,
        this.balance,
        this.deviceId,
        this.referredBy,
        this.referCode,
        this.withdrawalStatus,
        this.status,
        this.blocked,
        this.joinedDate,
        this.fcmId,
        this.lastUpdated,
        this.minWithdrawal,
        this.registerBonusSent,
        this.referBonusSent,
        this.generateCoin,
        this.totalAdsViewed,
        this.trailCompleted,
        this.accountNum,
        this.holderName,
        this.bank,
        this.branch,
        this.ifsc,
        this.watchAds,
        this.adsCost,
        this.registeredDate,
        this.basicWallet,
        this.premiumWallet,
        this.totalAds,
        this.todayAds,
        this.targetRefers,
        this.currentRefers,
        this.age,
        this.city,
        this.gender,
        this.supportLan,
        this.supportId,
        this.leadId,
        this.branchId,
        this.workedDays,
        this.plan,
        this.videoWallet,
        this.mediaWallet,
        this.postLeft,
        this.adsTime,
        this.oldPlan,
        this.oldPb,
        this.rewardAds,
        this.lastTodayAds,
        this.tSyncTime,
        this.tSync,
        this.description,
        this.ads10thDay,
        this.performance,
        this.projectType});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mobile = json['mobile'];
    name = json['name'];
    upi = json['upi'];
    email = json['email'];
    deaf = json['deaf'];
    totalReferrals = json['total_referrals'];
    earn = json['earn'];
    balance = json['balance'];
    deviceId = json['device_id'];
    referredBy = json['referred_by'];
    referCode = json['refer_code'];
    withdrawalStatus = json['withdrawal_status'];
    status = json['status'];
    blocked = json['blocked'];
    joinedDate = json['joined_date'];
    fcmId = json['fcm_id'];
    lastUpdated = json['last_updated'];
    minWithdrawal = json['min_withdrawal'];
    registerBonusSent = json['register_bonus_sent'];
    referBonusSent = json['refer_bonus_sent'];
    generateCoin = json['generate_coin'];
    totalAdsViewed = json['total_ads_viewed'];
    trailCompleted = json['trail_completed'];
    accountNum = json['account_num'];
    holderName = json['holder_name'];
    bank = json['bank'];
    branch = json['branch'];
    ifsc = json['ifsc'];
    watchAds = json['watch_ads'];
    adsCost = json['ads_cost'];
    registeredDate = json['registered_date'];
    basicWallet = json['basic_wallet'];
    premiumWallet = json['premium_wallet'];
    totalAds = json['total_ads'];
    todayAds = json['today_ads'];
    targetRefers = json['target_refers'];
    currentRefers = json['current_refers'];
    age = json['age'];
    city = json['city'];
    gender = json['gender'];
    supportLan = json['support_lan'];
    supportId = json['support_id'];
    leadId = json['lead_id'];
    branchId = json['branch_id'];
    workedDays = json['worked_days'];
    plan = json['plan'];
    videoWallet = json['video_wallet'];
    mediaWallet = json['media_wallet'];
    postLeft = json['post_left'];
    adsTime = json['ads_time'];
    oldPlan = json['old_plan'];
    oldPb = json['old_pb'];
    rewardAds = json['reward_ads'];
    lastTodayAds = json['last_today_ads'];
    tSyncTime = json['t_sync_time'];
    tSync = json['t_sync'];
    description = json['description'];
    ads10thDay = json['ads_10th_day'];
    performance = json['performance'];
    projectType = json['project_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['mobile'] = mobile;
    data['name'] = name;
    data['upi'] = upi;
    data['email'] = email;
    data['deaf'] = deaf;
    data['total_referrals'] = totalReferrals;
    data['earn'] = earn;
    data['balance'] = balance;
    data['device_id'] = deviceId;
    data['referred_by'] = referredBy;
    data['refer_code'] = referCode;
    data['withdrawal_status'] = withdrawalStatus;
    data['status'] = status;
    data['blocked'] = blocked;
    data['joined_date'] = joinedDate;
    data['fcm_id'] = fcmId;
    data['last_updated'] = lastUpdated;
    data['min_withdrawal'] = minWithdrawal;
    data['register_bonus_sent'] = registerBonusSent;
    data['refer_bonus_sent'] = referBonusSent;
    data['generate_coin'] = generateCoin;
    data['total_ads_viewed'] = totalAdsViewed;
    data['trail_completed'] = trailCompleted;
    data['account_num'] = accountNum;
    data['holder_name'] = holderName;
    data['bank'] = bank;
    data['branch'] = branch;
    data['ifsc'] = ifsc;
    data['watch_ads'] = watchAds;
    data['ads_cost'] = adsCost;
    data['registered_date'] = registeredDate;
    data['basic_wallet'] = basicWallet;
    data['premium_wallet'] = premiumWallet;
    data['total_ads'] = totalAds;
    data['today_ads'] = todayAds;
    data['target_refers'] = targetRefers;
    data['current_refers'] = currentRefers;
    data['age'] = age;
    data['city'] = city;
    data['gender'] = gender;
    data['support_lan'] = supportLan;
    data['support_id'] = supportId;
    data['lead_id'] = leadId;
    data['branch_id'] = branchId;
    data['worked_days'] = workedDays;
    data['plan'] = plan;
    data['video_wallet'] = videoWallet;
    data['media_wallet'] = mediaWallet;
    data['post_left'] = postLeft;
    data['ads_time'] = adsTime;
    data['old_plan'] = oldPlan;
    data['old_pb'] = oldPb;
    data['reward_ads'] = rewardAds;
    data['last_today_ads'] = lastTodayAds;
    data['t_sync_time'] = tSyncTime;
    data['t_sync'] = tSync;
    data['description'] = description;
    data['ads_10th_day'] = ads10thDay;
    data['performance'] = performance;
    data['project_type'] = projectType;
    return data;
  }
}

class Settings {
  String? id;
  String? withdrawalStatus;
  String? contactUs;
  String? minWithdrawal;
  String? image;
  String? offerImage;
  String? referBonus;
  String? a1JobVideo;
  String? a1JobDetails;
  String? a1PurchaseLink;
  String? a2JobVideo;
  String? a2JobDetails;
  String? a2PurchaseLink;
  String? watchAdStatus;
  String? whatsppGroupLink;
  String? rewardAdsDetails;

  Settings(
      {this.id,
        this.withdrawalStatus,
        this.contactUs,
        this.minWithdrawal,
        this.image,
        this.offerImage,
        this.referBonus,
        this.a1JobVideo,
        this.a1JobDetails,
        this.a1PurchaseLink,
        this.a2JobVideo,
        this.a2JobDetails,
        this.a2PurchaseLink,
        this.watchAdStatus,
        this.whatsppGroupLink,
        this.rewardAdsDetails});

  Settings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    withdrawalStatus = json['withdrawal_status'];
    contactUs = json['contact_us'];
    minWithdrawal = json['min_withdrawal'];
    image = json['image'];
    offerImage = json['offer_image'];
    referBonus = json['refer_bonus'];
    a1JobVideo = json['a1_job_video'];
    a1JobDetails = json['a1_job_details'];
    a1PurchaseLink = json['a1_purchase_link'];
    a2JobVideo = json['a2_job_video'];
    a2JobDetails = json['a2_job_details'];
    a2PurchaseLink = json['a2_purchase_link'];
    watchAdStatus = json['watch_ad_status'];
    whatsppGroupLink = json['whatspp_group_link'];
    rewardAdsDetails = json['reward_ads_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['withdrawal_status'] = withdrawalStatus;
    data['contact_us'] = contactUs;
    data['min_withdrawal'] = minWithdrawal;
    data['image'] = image;
    data['offer_image'] = offerImage;
    data['refer_bonus'] = referBonus;
    data['a1_job_video'] = a1JobVideo;
    data['a1_job_details'] = a1JobDetails;
    data['a1_purchase_link'] = a1PurchaseLink;
    data['a2_job_video'] = a2JobVideo;
    data['a2_job_details'] = a2JobDetails;
    data['a2_purchase_link'] = a2PurchaseLink;
    data['watch_ad_status'] = watchAdStatus;
    data['whatspp_group_link'] = whatsppGroupLink;
    data['reward_ads_details'] = rewardAdsDetails;
    return data;
  }
}
