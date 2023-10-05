import 'dart:math';

import 'package:color_challenge/data/repository/full_time_repo.dart';
import 'package:color_challenge/model/sync_data_list.dart';
import 'package:color_challenge/util/Constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FullTimePageCont extends GetxController implements GetxService {
  final FullTimeRepo fullTimeRepo;
  FullTimePageCont({required this.fullTimeRepo});
  RxString todayAds = "0".obs;
  RxString totalAds = "0".obs;

  int generateRandomFourDigitNumber() {
    // Generate a random number between 1000 and 9999
    Random random = Random();
    return 1000 + random.nextInt(9000);
  }

  int generateRandomSixDigitNumber() {
    // Generate a random number between 100000 and 999999
    Random random = Random();
    return 100000 + random.nextInt(900000);
  }

  Future<void> syncData(userId, ads, syncUniqueId) async {
    try {
      final value = await fullTimeRepo.syncData(userId, ads, syncUniqueId);
      var responseData = value.body;
      SyncDataList syncDataList = SyncDataList.fromJson(responseData);
      debugPrint("===> SyncDataList: $syncDataList");
      debugPrint("===> SyncDataList message: ${syncDataList.message}");

      if (syncDataList.data != null && syncDataList.data!.isNotEmpty) {
        todayAds.value = syncDataList.data![0].todayAds!;
        totalAds.value = syncDataList.data![0].totalAds!;
      }

      Get.snackbar(
        syncDataList.success.toString(),
        syncDataList.message.toString(),
        duration: const Duration(seconds: 3),
        colorText: Colors.white,
      );
      await storeLocal.write(key: Constant.SYNC_ABLE, value: "true");
    } catch (e) {
      debugPrint("shortsVideoData errors: $e");
      Get.snackbar(
        'oops',
        'Transaction updated is not successfully',
        duration: const Duration(seconds: 3),
        colorText: Colors.white,
      );
    }
  }
}
