import 'dart:convert';

import 'package:a1_ads/data/repository/upi_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeaveHistoryEntry {
  late String date;
  late String reason;

  LeaveHistoryEntry({required this.date, required this.reason});

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'reason': reason,
    };
  }
}

String leaveHistoryToJson(List<LeaveHistoryEntry> leaveHistory) {
  List<Map<String, dynamic>> list = [];
  for (var entry in leaveHistory) {
    list.add(entry.toJson());
  }
  return jsonEncode(list);
}

class UPIController extends GetxController implements GetxService {
  final UPIRepo upiRepo;
  UPIController({required this.upiRepo});
  // late List<LeaveHistoryEntry> leaveHistory = [];
  late SharedPreferences prefs;

  // void addLeaveHistoryEntry(String date, String reason) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String leaveHistoryJson = leaveHistoryToJson(leaveHistory);
  //   await prefs.setString('leaveHistory', leaveHistoryJson);
  //   update();
  // }
  //
  // Future<void> loadLeaveHistory() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? leaveHistoryJson = prefs.getString('leaveHistory');
  //
  //   if (leaveHistoryJson != null) {
  //     List<dynamic> list = jsonDecode(leaveHistoryJson);
  //     leaveHistory = list.map((entryJson) {
  //       return LeaveHistoryEntry(
  //         date: entryJson['date'],
  //         reason: entryJson['reason'],
  //       );
  //     }).toList();
  //     update();
  //   }
  // }
}
