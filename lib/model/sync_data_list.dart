class SyncDataList {
  bool? success;
  String? message;
  List<Data>? data;

  SyncDataList({this.success, this.message, this.data});

  SyncDataList.fromJson(Map<String, dynamic> json) {
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
        this.rewardAds});

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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    return data;
  }
}
