class Users {
  final String id;
  final String mobile;
  final String upi;
  final String earn;
  final String coins;
  final String balance;
  final String referredBy;
  final String referCode;
  final String withdrawalStatus;
  final String challengeStatus;
  final String status;
  final String joinedDate;
  final String lastUpdated;

  Users({
    required this.id,
    required this.mobile,
    required this.upi,
    required this.earn,
    required this.coins,
    required this.balance,
    required this.referredBy,
    required this.referCode,
    required this.withdrawalStatus,
    required this.challengeStatus,
    required this.status,
    required this.joinedDate,
    required this.lastUpdated,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'],
      mobile: json['mobile'],
      upi: json['upi'],
      earn: json['earn'],
      coins: json['coins'],
      balance: json['balance'],
      referredBy: json['referred_by'],
      referCode: json['refer_code'],
      withdrawalStatus: json['withdrawal_status'],
      challengeStatus: json['challenge_status'],
      status: json['status'],
      joinedDate: json['joined_date'],
      lastUpdated: json['last_updated'],
    );
  }
  factory Users.fromJsonNew(Map<String, dynamic> json) {
    return Users(
      id: json['id'],
      mobile: json['mobile'],
      upi: json['upi'],
      earn: json['earn'],
      coins: json['coins'],
      balance: json['balance'],
      referredBy: json['referred_by'],
      referCode: json['refer_code'],
      withdrawalStatus: json['withdrawal_status'],
      challengeStatus: json['challenge_status'],
      status: json['status'],
      joinedDate: json['joined_date'],
      lastUpdated: json['last_updated'],
    );
  }

}
