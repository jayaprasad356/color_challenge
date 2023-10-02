class PurchaseData {
  bool? success;
  String? message;
  List<Data>? data;

  PurchaseData({this.success, this.message, this.data});

  PurchaseData.fromJson(Map<String, dynamic> json) {
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
    data['success'] = this.success;
    data['message'] = this.message;
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

  Data(
      {this.id,
        this.mobile,
        this.name,
        this.upi,
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
        this.postLeft});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mobile = json['mobile'];
    name = json['name'];
    upi = json['upi'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mobile'] = this.mobile;
    data['name'] = this.name;
    data['upi'] = this.upi;
    data['total_referrals'] = this.totalReferrals;
    data['earn'] = this.earn;
    data['balance'] = this.balance;
    data['device_id'] = this.deviceId;
    data['referred_by'] = this.referredBy;
    data['refer_code'] = this.referCode;
    data['withdrawal_status'] = this.withdrawalStatus;
    data['status'] = this.status;
    data['joined_date'] = this.joinedDate;
    data['fcm_id'] = this.fcmId;
    data['last_updated'] = this.lastUpdated;
    data['min_withdrawal'] = this.minWithdrawal;
    data['register_bonus_sent'] = this.registerBonusSent;
    data['refer_bonus_sent'] = this.referBonusSent;
    data['generate_coin'] = this.generateCoin;
    data['total_ads_viewed'] = this.totalAdsViewed;
    data['trail_completed'] = this.trailCompleted;
    data['account_num'] = this.accountNum;
    data['holder_name'] = this.holderName;
    data['bank'] = this.bank;
    data['branch'] = this.branch;
    data['ifsc'] = this.ifsc;
    data['watch_ads'] = this.watchAds;
    data['ads_cost'] = this.adsCost;
    data['registered_date'] = this.registeredDate;
    data['basic_wallet'] = this.basicWallet;
    data['premium_wallet'] = this.premiumWallet;
    data['total_ads'] = this.totalAds;
    data['today_ads'] = this.todayAds;
    data['target_refers'] = this.targetRefers;
    data['current_refers'] = this.currentRefers;
    data['age'] = this.age;
    data['city'] = this.city;
    data['gender'] = this.gender;
    data['support_lan'] = this.supportLan;
    data['support_id'] = this.supportId;
    data['lead_id'] = this.leadId;
    data['branch_id'] = this.branchId;
    data['worked_days'] = this.workedDays;
    data['plan'] = this.plan;
    data['video_wallet'] = this.videoWallet;
    data['media_wallet'] = this.mediaWallet;
    data['post_left'] = this.postLeft;
    return data;
  }
}
