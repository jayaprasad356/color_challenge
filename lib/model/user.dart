class Users {
  final String id;
  final String upi;
  final String earn;
  final String mobile;
  final String name;
  final String balance;
  final String referredBy;
  final String referCode;
  final String withdrawalStatus;
  final String status;
  final String joinedDate;
  final String lastUpdated;
  final String min_withdrawal;
  final String device_id;
  final String account_num;
  final String ifsc;
  final String holder_name;
  final String bank;
  final String branch;
  final String basic_wallet;
  final String premium_wallet;
  final String target_refers;
  final String today_ads;
  final String total_ads;
  final String city;
  final String age;
  final String gender;
  final String support_lan;
  final String media_wallet;
  final String post_left;
  final String ads_cost;
  final String ads_time;
  final String old_plan;
  final String plan;
  final String deaf;
  final String email;
  final String reward_ads;



  Users({
    required this.id,
    required this.upi,
    required this.earn,
    required this.name,
    required this.mobile,
    required this.balance,
    required this.referredBy,
    required this.referCode,
    required this.withdrawalStatus,
    required this.status,
    required this.joinedDate,
    required this.lastUpdated,
    required this.min_withdrawal,
    required this.device_id,
    required this.account_num,
    required this.ifsc,
    required this.holder_name,
    required this.bank,
    required this.branch,
    required this.basic_wallet,
    required this.premium_wallet,
    required this.target_refers,
    required this.today_ads,
    required this.total_ads,
    required this.city,
    required this.age,
    required this.gender,
    required this.support_lan,
    required this.media_wallet,
    required this.post_left,
    required this.ads_cost,
    required this.ads_time,
    required this.old_plan,
    required this.plan,
    required this.deaf,
    required this.email,
    required this.reward_ads,

  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'],
      upi: json['upi'],
      earn: json['earn'],
      name: json['name'],
      mobile: json['mobile'],
      balance: json['balance'],
      referredBy: json['referred_by'],
      referCode: json['refer_code'],
      withdrawalStatus: json['withdrawal_status'],
      status: json['status'],
      joinedDate: json['joined_date'],
      lastUpdated: json['last_updated'],
      min_withdrawal: json['min_withdrawal'],
      device_id: json['device_id'],
      account_num: json['account_num'],
      ifsc: json['ifsc'],
      holder_name: json['holder_name'],
      bank: json['bank'],
      branch: json['branch'],
      basic_wallet: json['basic_wallet'],
      premium_wallet: json['premium_wallet'],
      target_refers: json['target_refers'],
      today_ads: json['today_ads'],
      total_ads: json['total_ads'],
      city: json['city'],
      age: json['age'],
      gender: json['gender'],
      support_lan: json['support_lan'],
      media_wallet: json['media_wallet'],
      post_left: json['post_left'],
      ads_cost: json['ads_cost'],
      ads_time: json['ads_time'],
      old_plan: json['old_plan'],
      plan: json['plan'],
      deaf: json['deaf'],
      email: json['email'],
      reward_ads: json['reward_ads'],
    );
  }
  factory Users.fromJsonNew(Map<String, dynamic> json) {
    return Users(
      id: json['id'],
      upi: json['upi'],
      earn: json['earn'],
      mobile: json['mobile'],
      name: json['name'],
      balance: json['balance'],
      referredBy: json['referred_by'],
      referCode: json['refer_code'],
      withdrawalStatus: json['withdrawal_status'],
      status: json['status'],
      joinedDate: json['joined_date'],
      lastUpdated: json['last_updated'],
      min_withdrawal: json['min_withdrawal'],
      device_id: json['device_id'],
      account_num: json['account_num'],
      ifsc: json['ifsc'],
      holder_name: json['holder_name'],
      bank: json['bank'],
      branch: json['branch'],
      basic_wallet: json['basic_wallet'],
      premium_wallet: json['premium_wallet'],
      target_refers: json['target_refers'],
      today_ads: json['today_ads'],
      total_ads: json['total_ads'],
      city: json['city'],
      age: json['age'],
      gender: json['gender'],
      support_lan: json['support_lan'],
      media_wallet: json['media_wallet'],
      post_left: json['post_left'],
      ads_cost: json['ads_cost'],
      ads_time: json['ads_time'],
      old_plan: json['old_plan'],
      plan: json['plan'],
      deaf: json['deaf'],
      email: json['email'],
      reward_ads: json['reward_ads'],
    );
  }

}
