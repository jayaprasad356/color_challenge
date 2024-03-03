class TeamList {
  bool? success;
  String? message;
  int? count;
  List<Data>? data;

  TeamList({this.success, this.message, this.count, this.data});

  TeamList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    count = json['count'];
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
    data['count'] = count;
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
  String? withdrawals;
  String? storeBalance;
  String? deviceId;
  String? referredBy;
  String? cReferredBy;
  String? dReferredBy;
  String? referCode;
  String? withdrawalStatus;
  String? status;
  String? blocked;
  String? joinedDate;
  Null? fcmId;
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
  Null? description;
  String? ads10thDay;
  String? performance;
  Null? projectType;
  String? platformType;
  String? missedDays;
  Null? orderId;
  Null? paymentVerified;
  String? lastMissedDays;
  String? realAds;
  String? oldStoreBalance;
  String? unknown;
  String? withoutWork;
  String? maxWithdrawal;
  String? enrolled;
  String? oldBalance;
  String? todayAdsStatus;
  String? payLater;
  String? whatsappStatus;
  String? address;
  String? pincode;
  String? scratchCard;
  String? basic;
  String? lifetime;
  String? premium;
  String? basicDays;
  String? lifetimeDays;
  String? premiumDays;
  String? basicIncome;
  String? lifetimeIncome;
  String? premiumIncome;
  Null? basicJoinedDate;
  Null? lifetimeJoinedDate;
  Null? premiumJoinedDate;
  String? aadhaarNum;
  String? freeIncome;
  String? todayEarn;
  String? teamSize;
  String? validTeam;
  String? totalAssets;
  String? levelIncome;
  String? referLevelIncome;
  String? recharge;

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
        this.withdrawals,
        this.storeBalance,
        this.deviceId,
        this.referredBy,
        this.cReferredBy,
        this.dReferredBy,
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
        this.projectType,
        this.platformType,
        this.missedDays,
        this.orderId,
        this.paymentVerified,
        this.lastMissedDays,
        this.realAds,
        this.oldStoreBalance,
        this.unknown,
        this.withoutWork,
        this.maxWithdrawal,
        this.enrolled,
        this.oldBalance,
        this.todayAdsStatus,
        this.payLater,
        this.whatsappStatus,
        this.address,
        this.pincode,
        this.scratchCard,
        this.basic,
        this.lifetime,
        this.premium,
        this.basicDays,
        this.lifetimeDays,
        this.premiumDays,
        this.basicIncome,
        this.lifetimeIncome,
        this.premiumIncome,
        this.basicJoinedDate,
        this.lifetimeJoinedDate,
        this.premiumJoinedDate,
        this.aadhaarNum,
        this.freeIncome,
        this.todayEarn,
        this.teamSize,
        this.validTeam,
        this.totalAssets,
        this.levelIncome,
        this.referLevelIncome,
        this.recharge});

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
    withdrawals = json['withdrawals'];
    storeBalance = json['store_balance'];
    deviceId = json['device_id'];
    referredBy = json['referred_by'];
    cReferredBy = json['c_referred_by'];
    dReferredBy = json['d_referred_by'];
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
    platformType = json['platform_type'];
    missedDays = json['missed_days'];
    orderId = json['order_id'];
    paymentVerified = json['payment_verified'];
    lastMissedDays = json['last_missed_days'];
    realAds = json['real_ads'];
    oldStoreBalance = json['old_store_balance'];
    unknown = json['unknown'];
    withoutWork = json['without_work'];
    maxWithdrawal = json['max_withdrawal'];
    enrolled = json['enrolled'];
    oldBalance = json['old_balance'];
    todayAdsStatus = json['today_ads_status'];
    payLater = json['pay_later'];
    whatsappStatus = json['whatsapp_status'];
    address = json['address'];
    pincode = json['pincode'];
    scratchCard = json['scratch_card'];
    basic = json['basic'];
    lifetime = json['lifetime'];
    premium = json['premium'];
    basicDays = json['basic_days'];
    lifetimeDays = json['lifetime_days'];
    premiumDays = json['premium_days'];
    basicIncome = json['basic_income'];
    lifetimeIncome = json['lifetime_income'];
    premiumIncome = json['premium_income'];
    basicJoinedDate = json['basic_joined_date'];
    lifetimeJoinedDate = json['lifetime_joined_date'];
    premiumJoinedDate = json['premium_joined_date'];
    aadhaarNum = json['aadhaar_num'];
    freeIncome = json['free_income'];
    todayEarn = json['today_earn'];
    teamSize = json['team_size'];
    validTeam = json['valid_team'];
    totalAssets = json['total_assets'];
    levelIncome = json['level_income'];
    referLevelIncome = json['refer_level_income'];
    recharge = json['recharge'];
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
    data['withdrawals'] = withdrawals;
    data['store_balance'] = storeBalance;
    data['device_id'] = deviceId;
    data['referred_by'] = referredBy;
    data['c_referred_by'] = cReferredBy;
    data['d_referred_by'] = dReferredBy;
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
    data['platform_type'] = platformType;
    data['missed_days'] = missedDays;
    data['order_id'] = orderId;
    data['payment_verified'] = paymentVerified;
    data['last_missed_days'] = lastMissedDays;
    data['real_ads'] = realAds;
    data['old_store_balance'] = oldStoreBalance;
    data['unknown'] = unknown;
    data['without_work'] = withoutWork;
    data['max_withdrawal'] = maxWithdrawal;
    data['enrolled'] = enrolled;
    data['old_balance'] = oldBalance;
    data['today_ads_status'] = todayAdsStatus;
    data['pay_later'] = payLater;
    data['whatsapp_status'] = whatsappStatus;
    data['address'] = address;
    data['pincode'] = pincode;
    data['scratch_card'] = scratchCard;
    data['basic'] = basic;
    data['lifetime'] = lifetime;
    data['premium'] = premium;
    data['basic_days'] = basicDays;
    data['lifetime_days'] = lifetimeDays;
    data['premium_days'] = premiumDays;
    data['basic_income'] = basicIncome;
    data['lifetime_income'] = lifetimeIncome;
    data['premium_income'] = premiumIncome;
    data['basic_joined_date'] = basicJoinedDate;
    data['lifetime_joined_date'] = lifetimeJoinedDate;
    data['premium_joined_date'] = premiumJoinedDate;
    data['aadhaar_num'] = aadhaarNum;
    data['free_income'] = freeIncome;
    data['today_earn'] = todayEarn;
    data['team_size'] = teamSize;
    data['valid_team'] = validTeam;
    data['total_assets'] = totalAssets;
    data['level_income'] = levelIncome;
    data['refer_level_income'] = referLevelIncome;
    data['recharge'] = recharge;
    return data;
  }
}
