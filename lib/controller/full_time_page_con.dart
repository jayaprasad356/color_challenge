import 'dart:math';

import 'package:a1_ads/data/repository/full_time_repo.dart';
import 'package:a1_ads/model/sync_data_list.dart';
import 'package:a1_ads/util/Constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef SyncDataCallback = void Function(String syncDataSuccess);

class FullTimePageCont extends GetxController implements GetxService {
  final FullTimeRepo fullTimeRepo;
  FullTimePageCont({required this.fullTimeRepo});
  late String syncDataSuccess = '';
  late SharedPreferences prefs;
  String todayAds = "";
  String totalAds = "";
  String balance = "";
  String ads_cost = "";
  String ads_time = "";
  String reward_ads = "";
  String storeBalance = "";
  // String balance = "";
  // RxString ads_cost = "0.00".obs;

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

  Future<void> syncData(
      context,
    userId,
    ads,
    syncUniqueId,
    deviceId,
    syncType,
      platformType,
    SyncDataCallback callback, // Add the callback parameter
  ) async {
    prefs = await SharedPreferences.getInstance();
    try {
      showLoadingIndicator(context);

      await Future.delayed(const Duration(seconds: 5));

      final value = await fullTimeRepo.syncData(
          userId, ads, syncUniqueId, deviceId, syncType, platformType);
      var responseData = value.body;
      SyncDataList syncDataList = SyncDataList.fromJson(responseData);
      debugPrint("===> SyncDataList: $syncDataList");
      debugPrint("===> SyncDataList message: ${syncDataList.message}");
      debugPrint("===> SyncDataList success: ${syncDataList.success}");

      syncDataSuccess = syncDataList.success.toString();

      if (syncDataList.data != null && syncDataList.data!.isNotEmpty) {
        todayAds = syncDataList.data![0].todayAds!;
        totalAds = syncDataList.data![0].totalAds!;
        balance = syncDataList.data![0].balance!;
        ads_cost = syncDataList.data![0].adsCost!;
        ads_time = syncDataList.data![0].adsTime!;
        reward_ads = syncDataList.data![0].rewardAds!;
        storeBalance = syncDataList.data![0].storeBalance!;
        // balance = syncDataList.data![0].balance!;
        // ads_cost.value = syncDataList.data![0].adsCost!;
        prefs.remove(Constant.TODAY_ADS);
        prefs.remove(Constant.TOTAL_ADS);
        prefs.remove(Constant.BALANCE);
        prefs.remove(Constant.ADS_COST);
        prefs.remove(Constant.ADS_TIME);
        prefs.remove(Constant.REWARD_ADS);
        prefs.remove(Constant.STORE_BALANCE);

        prefs.setString(Constant.TODAY_ADS, todayAds);
        prefs.setString(Constant.TOTAL_ADS, totalAds);
        prefs.setString(Constant.BALANCE, balance);
        prefs.setString(Constant.ADS_COST, ads_cost);
        prefs.setString(Constant.ADS_TIME, ads_time);
        prefs.setString(Constant.REWARD_ADS, reward_ads);
        prefs.setString(Constant.STORE_BALANCE, storeBalance);
      }

      // prefs.setString(Constant.MOBILE, user.mobile);

      Get.snackbar(
        syncDataList.success.toString(),
        syncDataList.message.toString(),
        duration: const Duration(seconds: 3),
        colorText: Colors.white,
      );

      // Execute the callback after the function is completed
      callback(syncDataList.success.toString());

      hideLoadingIndicator(context);
    } catch (e) {
      debugPrint("syncData errors: $e");
      // Handle errors
      callback('error');
    }
  }

  void showLoadingIndicator(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 8),
              Text('Loading...'),
            ],
          ),
        );
      },
    );
  }

  void hideLoadingIndicator(BuildContext context) {
    Navigator.of(context).pop();
  }

  // Future<void> syncData(userId, ads, syncUniqueId) async {
  //   try {
  //     final value = await fullTimeRepo.syncData(userId, ads, syncUniqueId);
  //     var responseData = value.body;
  //     SyncDataList syncDataList = SyncDataList.fromJson(responseData);
  //     debugPrint("===> SyncDataList: $syncDataList");
  //     debugPrint("===> SyncDataList message: ${syncDataList.message}");
  //     debugPrint("===> SyncDataList success: ${syncDataList.success}");
  //
  //     // syncDataSuccess = syncDataList.success.toString();
  //
  //     // if (syncDataList.data != null && syncDataList.data!.isNotEmpty) {
  //     //   todayAds.value = syncDataList.data![0].todayAds!;
  //     //   totalAds.value = syncDataList.data![0].totalAds!;
  //     //   balance.value = syncDataList.data![0].balance!;
  //     //   ads_cost.value = syncDataList.data![0].adsCost!;
  //     // }
  //
  //     Get.snackbar(
  //       syncDataList.success.toString(),
  //       syncDataList.message.toString(),
  //       duration: const Duration(seconds: 3),
  //       colorText: Colors.white,
  //     );
  //     // if (syncDataList.success.toString() == 'true') {
  //     //   await storeLocal.write(key: Constant.SYNC_ABLE, value: "true");
  //     //   update();
  //     // } else if (syncDataList.success.toString() == 'false') {
  //     //   await storeLocal.write(key: Constant.SYNC_ABLE, value: "true");
  //     //   update();
  //     // }
  //     update();
  //   } catch (e) {
  //     debugPrint("shortsVideoData errors: $e");
  //     Get.snackbar(
  //       'oops',
  //       'Transaction updated is not successfully',
  //       duration: const Duration(seconds: 3),
  //       colorText: Colors.white,
  //     );
  //   }
  // }
}
