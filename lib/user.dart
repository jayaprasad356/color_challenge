class Users {
  final String id;
  final String upi;
  final String earn;
  final String coins;
  final String mobile;
  final String name;
  final String balance;
  final String referredBy;
  final String referCode;
  final String withdrawalStatus;
  final String challengeStatus;
  final String status;
  final String joinedDate;
  final String lastUpdated;
  final String refer_coins;
  final String min_withdrawal;
  final String device_id;


  Users({
    required this.id,
    required this.upi,
    required this.earn,
    required this.coins,
    required this.name,
    required this.mobile,
    required this.balance,
    required this.referredBy,
    required this.referCode,
    required this.withdrawalStatus,
    required this.challengeStatus,
    required this.status,
    required this.joinedDate,
    required this.lastUpdated,
    required this.refer_coins,
    required this.min_withdrawal,
    required this.device_id,

  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'],
      upi: json['upi'],
      earn: json['earn'],
      coins: json['coins'],
      name: json['name'],
      mobile: json['mobile'],
      balance: json['balance'],
      referredBy: json['referred_by'],
      referCode: json['refer_code'],
      withdrawalStatus: json['withdrawal_status'],
      challengeStatus: json['challenge_status'],
      status: json['status'],
      joinedDate: json['joined_date'],
      lastUpdated: json['last_updated'],
      refer_coins: json['refer_coins'],
      min_withdrawal: json['min_withdrawal'],
      device_id: json['device_id'],
    );
  }
  factory Users.fromJsonNew(Map<String, dynamic> json) {
    return Users(
      id: json['id'],
      upi: json['upi'],
      earn: json['earn'],
      coins: json['coins'],
      mobile: json['mobile'],
      name: json['name'],
      balance: json['balance'],
      referredBy: json['referred_by'],
      referCode: json['refer_code'],
      withdrawalStatus: json['withdrawal_status'],
      challengeStatus: json['challenge_status'],
      status: json['status'],
      joinedDate: json['joined_date'],
      lastUpdated: json['last_updated'],
      refer_coins: json['refer_coins'],
      min_withdrawal: json['min_withdrawal'],
      device_id: json['device_id'],
    );
  }

}
