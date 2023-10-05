import 'dart:math';

import 'package:color_challenge/data/repository/full_time_repo.dart';
import 'package:color_challenge/model/sync_data_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FullTimePageCont extends GetxController implements GetxService {
  final FullTimeRepo fullTimeRepo;
  FullTimePageCont({required this.fullTimeRepo});

  int generateRandomFourDigitNumber() {
    // Generate a random number between 1000 and 9999
    Random random = Random();
    return 1000 + random.nextInt(9000);
  }

  Future<void> syncData(userId, ads, syncUniqueId) async {
    try {
      final value = await fullTimeRepo.syncData(userId, ads, syncUniqueId);
      var responseData = value.body;
      SyncDataList syncDataList = SyncDataList.fromJson(responseData);
      debugPrint("===> SyncDataList: $syncDataList");
      debugPrint("===> SyncDataList message: ${syncDataList.message}");

      Get.snackbar(
        syncDataList.success.toString(),
        syncDataList.message.toString(),
        duration: const Duration(seconds: 3),
        colorText: Colors.white,
      );
    } catch (e) {
      debugPrint("shortsVideoData errors: $e");
    }
  }
}
