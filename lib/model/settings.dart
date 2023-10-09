
class Settings {
  final String id;
  final String register_coins;
  final String refer_coins;
  final String withdrawal_status;
  final String challenge_status;
  final String upi;
  final String contact_us;
  final String min_withdrawal;
  final String min_dp_coins;
  final String max_dp_coins;
  final String result;
  final String watch_ad_status;

  Settings({
    required this.id,
    required this.upi,
    required this.min_withdrawal,
    required this.register_coins,
    required this.refer_coins,
    required this.withdrawal_status,
    required this.challenge_status,
    required this.contact_us,
    required this.min_dp_coins,
    required this.max_dp_coins,
    required this.result,
    required this.watch_ad_status,
  });

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      id: json['id'],
      upi: json['upi'],
      min_withdrawal: json['min_withdrawal'],
      register_coins: json['register_coins'],
      refer_coins: json['refer_coins'],
      withdrawal_status: json['withdrawal_status'],
      challenge_status: json['challenge_status'],
      contact_us: json['contact_us'],
      min_dp_coins: json['min_dp_coins'],
      max_dp_coins: json['max_dp_coins'],
      result: json['result'],
      watch_ad_status: json['watch_ad_status'],
    );
  }
  factory Settings.fromJsonNew(Map<String, dynamic> json) {
    return Settings(
      id: json['id'],
      upi: json['upi'],
      min_withdrawal: json['min_withdrawal'],
      register_coins: json['register_coins'],
      refer_coins: json['refer_coins'],
      withdrawal_status: json['withdrawal_status'],
      challenge_status: json['challenge_status'],
      contact_us: json['contact_us'],
      min_dp_coins: json['min_dp_coins'],
      max_dp_coins: json['max_dp_coins'],
      result: json['result'],
      watch_ad_status: json['watch_ad_status'],
    );
  }
}
