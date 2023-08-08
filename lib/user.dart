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
    );
  }

}
