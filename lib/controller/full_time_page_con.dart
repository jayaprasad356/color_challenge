import 'dart:math';

import 'package:a1_ads/data/repository/full_time_repo.dart';
import 'package:a1_ads/model/sync_data_list.dart';
import 'package:a1_ads/model/today_income.dart';
import 'package:a1_ads/util/Constant.dart';
import 'package:a1_ads/util/index_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef SyncDataCallback = void Function(String syncDataSuccess);

class FullTimePageCont extends GetxController implements GetxService {
  final FullTimeRepo fullTimeRepo;
  FullTimePageCont({required this.fullTimeRepo}) {
    SharedPreferences.getInstance().then((value) {
      prefs = value;
    });
  }
  late String syncDataSuccess = '';
  late SharedPreferences prefs;
  String todayAds = "";
  String totalAds = "";
  String balance = "";
  String ads_cost = "";
  String ads_time = "";
  String reward_ads = "";
  String storeBalance = "";
  RxBool isLoading = false.obs;
  RxBool isTrue = false.obs;
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

  Future<void> todayIncome(context) async {
    isLoading.value = true;
    update();
    showAlertDialog(context);
    Timer(const Duration(seconds: 5), () async {
      isLoading.value = false;
      update();
      try {
        final value =
            await fullTimeRepo.todayIncome(prefs.getString(Constant.ID)!);
        var responseData = value.body;
        TodayIncome todayIncome = TodayIncome.fromJson(responseData);
        debugPrint("===> todayIncome: $todayIncome");
        debugPrint("===> todayIncome message: ${todayIncome.message}");
        debugPrint("===> todayIncome success: ${todayIncome.success}");

        if (todayIncome.success == true) {
          isTrue.value = false;
        } else {
          Get.snackbar(
            todayIncome.success.toString(),
            todayIncome.message.toString(),
            duration: const Duration(seconds: 3),
            colorText: Colors.white,
          );
          isTrue.value = true;
        }

        prefs.remove(Constant.ID);
        prefs.remove(Constant.MOBILE);
        prefs.remove(Constant.NAME);
        prefs.remove(Constant.UPI);
        prefs.remove(Constant.EARN);
        prefs.remove(Constant.BALANCE);
        prefs.remove(Constant.TODAY_ADS);
        prefs.remove(Constant.TOTAL_ADS);
        prefs.remove(Constant.REFERRED_BY);
        prefs.remove(Constant.REFER_CODE);
        prefs.remove(Constant.WITHDRAWAL_STATUS);
        prefs.remove(Constant.STATUS);
        prefs.remove(Constant.JOINED_DATE);
        prefs.remove(Constant.LAST_UPDATED);
        prefs.remove(Constant.MIN_WITHDRAWAL);
        prefs.remove(Constant.HOLDER_NAME);
        prefs.remove(Constant.ACCOUNT_NUM);
        prefs.remove(Constant.IFSC);
        prefs.remove(Constant.BANK);
        prefs.remove(Constant.BRANCH);
        prefs.remove(Constant.OLD_PLAN);
        prefs.remove(Constant.PLAN);
        prefs.remove(Constant.ADS_TIME);
        prefs.remove(Constant.ADS_COST);
        prefs.remove(Constant.REWARD_ADS);
        prefs.remove(Constant.STORE_BALANCE);
        prefs.remove(Constant.WITHOUT_WORK);
        prefs.remove(Constant.TARGET_REFERS);
        prefs.remove(Constant.TODAY_ADS_STATUS);

        for (var todayIncomeData in todayIncome.data!) {
          print(
              'User ID: ${todayIncomeData.id}');
          prefs.setString(Constant.ID, todayIncomeData.id ?? '');
          prefs.setString(Constant.MOBILE, todayIncomeData.mobile ?? '');
          prefs.setString(Constant.NAME, todayIncomeData.name ?? '');
          prefs.setString(Constant.UPI, todayIncomeData.upi ?? '');
          prefs.setString(Constant.EARN, todayIncomeData.earn ?? '');
          prefs.setString(Constant.BALANCE, todayIncomeData.balance ?? '');
          prefs.setString(Constant.TODAY_ADS, todayIncomeData.todayAds ?? '');
          prefs.setString(Constant.TOTAL_ADS, todayIncomeData.totalAds ?? '');
          prefs.setString(Constant.REFERRED_BY, todayIncomeData.referredBy ?? '');
          prefs.setString(Constant.REFER_CODE, todayIncomeData.referCode ?? '');
          prefs.setString(Constant.WITHDRAWAL_STATUS, todayIncomeData.withdrawalStatus ?? '');
          prefs.setString(Constant.STATUS, todayIncomeData.status ?? '');
          prefs.setString(Constant.JOINED_DATE, todayIncomeData.joinedDate ?? '');
          prefs.setString(Constant.LAST_UPDATED, todayIncomeData.lastUpdated ?? '');
          prefs.setString(Constant.MIN_WITHDRAWAL, todayIncomeData.minWithdrawal ?? '');
          prefs.setString(Constant.HOLDER_NAME, todayIncomeData.holderName ?? '');
          prefs.setString(Constant.ACCOUNT_NUM, todayIncomeData.accountNum ?? '');
          prefs.setString(Constant.IFSC, todayIncomeData.ifsc ?? '');
          prefs.setString(Constant.BANK, todayIncomeData.bank ?? '');
          prefs.setString(Constant.BRANCH, todayIncomeData.branch ?? '');
          prefs.setString(Constant.OLD_PLAN, todayIncomeData.oldPlan ?? '');
          prefs.setString(Constant.PLAN, todayIncomeData.plan ?? '');
          prefs.setString(Constant.ADS_TIME, todayIncomeData.adsTime ?? '');
          prefs.setString(Constant.ADS_COST, todayIncomeData.adsCost ?? '');
          prefs.setString(Constant.REWARD_ADS, todayIncomeData.rewardAds ?? '');
          prefs.setString(Constant.STORE_BALANCE, todayIncomeData.storeBalance ?? '');
          prefs.setString(Constant.WITHOUT_WORK, todayIncomeData.withoutWork ?? '');
          prefs.setString(Constant.TARGET_REFERS, todayIncomeData.targetRefers ?? '');
          prefs.setString(Constant.TOTAL_REFERS, todayIncomeData.totalReferrals ?? '');
          prefs.setString(Constant.TODAY_ADS_STATUS, todayIncomeData.todayAdsStatus ?? '');
          update();
        }

      } catch (e) {
        debugPrint("todayIncome errors: $e");
      }
      hideLoadingIndicator(context);
    });
  }

  void showLoadingIndicator(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false, // Disable back button press
          child: const AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 8),
                Text('Loading...'),
              ],
            ),
          ),
        );
      },
    );
  }

  void hideLoadingIndicator(BuildContext context) {
    Navigator.of(context).pop();
  }

  showAlertDialog(
    BuildContext context,
    // String generatedOtp,
  ) {
    Size size = MediaQuery.of(context).size;

    AlertDialog alert = AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      contentPadding: const EdgeInsets.all(20),
      content: Obx(
        () => Container(
          height: size.height * 0.28,
          decoration: const BoxDecoration(),
          alignment: Alignment.center,
          child: isLoading.value == true
              ? const Center(
                  child: CircularProgressIndicator(
                    value: null,
                    strokeWidth: 7.0,
                  ),
                )
              : isTrue.value != true
                  ? Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              padding: const EdgeInsets.all(3),
                              child: Transform.rotate(
                                angle: 45 * 3.1415926535 / 180,
                                child: const Icon(Icons.add),
                              ),
                            ),
                          ),
                        ),
                        Image.asset(
                          'assets/images/Tick_Animation.gif',
                          height: size.height * 0.15,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Rs.50 Added",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: 'MontserratBold',
                            color: Color(0xFF31800C),
                            fontSize: 24,
                          ),
                        ),
                      ],
                    )
                  : const Center(),
        ),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          // child: alert,
          child: Obx(
                () {
              if (isTrue.value == false) {
                return alert;
              } else if(isTrue.value == true) {
                Navigator.of(context).pop();
                isTrue.value = false;
                return const SizedBox();
              } else {
                return const SizedBox();
              }
            },
          ),
        );
      },
    );
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
