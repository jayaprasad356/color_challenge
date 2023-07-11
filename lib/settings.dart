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


  Settings({
    required this.id,
    required this.register_coins,
    required this.refer_coins,
    required this.withdrawal_status,
    required this.challenge_status,
    required this.upi,
    required this.contact_us,
    required this.min_withdrawal,
    required this.min_dp_coins,
    required this.max_dp_coins,
    required this.result

});




  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      id: json['id'],
      register_coins: json['register_coins'],
      refer_coins: json['refer_coins'],
      withdrawal_status: json['withdrawal_status'],
      challenge_status: json['challenge_status'],
      upi: json['upi'],
      contact_us: json['contact_us'],
      min_withdrawal: json['min_withdrawal'],
      min_dp_coins: json['min_dp_coins'],
      max_dp_coins: json['max_dp_coins'],
      result: json['result'],
    );
  }


}
