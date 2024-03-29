import 'package:a1_ads/data/api/api_client.dart';
import 'package:a1_ads/data/repository/home_repo.dart';
import 'package:a1_ads/data/repository/main_repo.dart';
import 'package:a1_ads/data/repository/shorts_video_repo.dart';
import 'package:a1_ads/model/settings_data.dart';
import 'package:a1_ads/model/slider_data.dart';
import 'package:a1_ads/model/user_detail.dart';
import 'package:a1_ads/model/video_list.dart';
import 'package:a1_ads/util/Constant.dart';
import 'package:a1_ads/util/dynamic_link_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class SliderItem {
  final String imageUrl;

  SliderItem(this.imageUrl);
}

class MainController extends GetxController implements GetxService {
  final MainRepo mainRepo;
  MainController({required this.mainRepo}){
    // deeplinkApi.handleDynamicLink();
    SharedPreferences.getInstance().then((value) {
      prefs = value;
    });
  }
  // final deeplinkApi = GetIt.I.get<DynamicLinkApi>();
  late SharedPreferences prefs;
  RxString whatsppGroupLink = ''.obs;

  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constant.ID);
  }

  Future<void> userDetail(userId) async {
    try {
      debugPrint("===> userDetail: $userId");
      final value = await mainRepo.userData(userId);
      var responseData = value.body;
      UserDetail userDetail = UserDetail.fromJson(responseData);
      debugPrint("===> userDetail: $userDetail");
      debugPrint("===> userDetail message: ${userDetail.message}");

      for (var userDetailData in userDetail.data!) {
        print(
            'User ID: ${userDetailData.id}');
        prefs.setString(Constant.LOGED_IN, "true");
        prefs.setString(Constant.ID, userDetailData.id ?? '');
        prefs.setString(Constant.MOBILE, userDetailData.mobile ?? '');
        prefs.setString(Constant.NAME, userDetailData.name ?? '');
        prefs.setString(Constant.UPI, userDetailData.upi ?? '');
        prefs.setString(Constant.EARN, userDetailData.earn ?? '');
        prefs.setString(Constant.BALANCE, userDetailData.balance ?? '');
        prefs.setString(Constant.TODAY_ADS, userDetailData.todayAds ?? '');
        prefs.setString(Constant.TOTAL_ADS, userDetailData.totalAds ?? '');
        prefs.setString(Constant.REFERRED_BY, userDetailData.referredBy ?? '');
        prefs.setString(Constant.REFER_CODE, userDetailData.referCode ?? '');
        prefs.setString(Constant.WITHDRAWAL_STATUS, userDetailData.withdrawalStatus ?? '');
        prefs.setString(Constant.STATUS, userDetailData.status ?? '');
        prefs.setString(Constant.JOINED_DATE, userDetailData.joinedDate ?? '');
        prefs.setString(Constant.LAST_UPDATED, userDetailData.lastUpdated ?? '');
        prefs.setString(Constant.MIN_WITHDRAWAL, userDetailData.minWithdrawal ?? '');
        prefs.setString(Constant.HOLDER_NAME, userDetailData.holderName ?? '');
        prefs.setString(Constant.ACCOUNT_NUM, userDetailData.accountNum ?? '');
        prefs.setString(Constant.IFSC, userDetailData.ifsc ?? '');
        prefs.setString(Constant.BANK, userDetailData.bank ?? '');
        prefs.setString(Constant.BRANCH, userDetailData.branch ?? '');
        prefs.setString(Constant.OLD_PLAN, userDetailData.oldPlan ?? '');
        prefs.setString(Constant.PLAN, userDetailData.plan ?? '');
        prefs.setString(Constant.ADS_TIME, userDetailData.adsTime ?? '');
        prefs.setString(Constant.ADS_COST, userDetailData.adsCost ?? '');
        prefs.setString(Constant.REWARD_ADS, userDetailData.rewardAds ?? '');
        prefs.setString(Constant.STORE_BALANCE, userDetailData.storeBalance ?? '');
        prefs.setString(Constant.WITHOUT_WORK, userDetailData.withoutWork ?? '');
        prefs.setString(Constant.TARGET_REFERS, userDetailData.targetRefers ?? '');
        prefs.setString(Constant.TOTAL_REFERS, userDetailData.totalReferrals ?? '');
        prefs.setString(Constant.TODAY_EARN, userDetailData.todayEarn ?? '');
        prefs.setString(Constant.TODAY_ADS_STATUS, userDetailData.todayAdsStatus ?? '');
        prefs.setString(Constant.GENDER, userDetailData.gender ?? '');
        prefs.setString(Constant.TEAM_SIZE, userDetailData.teamSize ?? '');
        prefs.setString(Constant.VALID_TEAM, userDetailData.validTeam ?? '');
        prefs.setString(Constant.LEVEL_INCOME, userDetailData.levelIncome ?? '');
        prefs.setString(Constant.TOTAL_ASSETS, userDetailData.totalAssets ?? '');
        prefs.setString(Constant.RECHARGE, userDetailData.recharge ?? '');
        debugPrint("userDetailData.todayAdsStatus : ${userDetailData.todayAdsStatus}");
        update();
      }
      for (var userDetailSettings in userDetail.settings!) {
        print(
            'userDetailData User ID: ${userDetailSettings.id}');
        whatsppGroupLink.value = userDetailSettings.whatsppGroupLink ?? '';
        prefs.setString(Constant.WHATSPP_GROUP_LINK, userDetailSettings.whatsppGroupLink ?? '');
        update();
      }
    } catch (e) {
      debugPrint("shortsVideoData errors: $e");
    }
  }

  Future<void> loginApi(userId) async {
    try {
      final value = await mainRepo.userData(userId);
      var responseData = value.body;
      UserDetail userDetail = UserDetail.fromJson(responseData);
      debugPrint("===> userDetail: $userDetail");
      debugPrint("===> userDetail message: ${userDetail.message}");

      for (var userDetailData in userDetail.data!) {
        print(
            'User ID: ${userDetailData.id}');
        prefs.setString(Constant.LOGED_IN, "true");
        prefs.setString(Constant.ID, userDetailData.id ?? '');
        prefs.setString(Constant.MOBILE, userDetailData.mobile ?? '');
        prefs.setString(Constant.NAME, userDetailData.name ?? '');
        prefs.setString(Constant.UPI, userDetailData.upi ?? '');
        prefs.setString(Constant.EARN, userDetailData.earn ?? '');
        prefs.setString(Constant.BALANCE, userDetailData.balance ?? '');
        prefs.setString(Constant.TODAY_ADS, userDetailData.todayAds ?? '');
        prefs.setString(Constant.TOTAL_ADS, userDetailData.totalAds ?? '');
        prefs.setString(Constant.REFERRED_BY, userDetailData.referredBy ?? '');
        prefs.setString(Constant.REFER_CODE, userDetailData.referCode ?? '');
        prefs.setString(Constant.WITHDRAWAL_STATUS, userDetailData.withdrawalStatus ?? '');
        prefs.setString(Constant.STATUS, userDetailData.status ?? '');
        prefs.setString(Constant.JOINED_DATE, userDetailData.joinedDate ?? '');
        prefs.setString(Constant.LAST_UPDATED, userDetailData.lastUpdated ?? '');
        prefs.setString(Constant.MIN_WITHDRAWAL, userDetailData.minWithdrawal ?? '');
        prefs.setString(Constant.HOLDER_NAME, userDetailData.holderName ?? '');
        prefs.setString(Constant.ACCOUNT_NUM, userDetailData.accountNum ?? '');
        prefs.setString(Constant.IFSC, userDetailData.ifsc ?? '');
        prefs.setString(Constant.BANK, userDetailData.bank ?? '');
        prefs.setString(Constant.BRANCH, userDetailData.branch ?? '');
        prefs.setString(Constant.OLD_PLAN, userDetailData.oldPlan ?? '');
        prefs.setString(Constant.PLAN, userDetailData.plan ?? '');
        prefs.setString(Constant.ADS_TIME, userDetailData.adsTime ?? '');
        prefs.setString(Constant.ADS_COST, userDetailData.adsCost ?? '');
        prefs.setString(Constant.REWARD_ADS, userDetailData.rewardAds ?? '');
        prefs.setString(Constant.STORE_BALANCE, userDetailData.storeBalance ?? '');
        prefs.setString(Constant.WITHOUT_WORK, userDetailData.withoutWork ?? '');
        prefs.setString(Constant.TARGET_REFERS, userDetailData.targetRefers ?? '');
        prefs.setString(Constant.TOTAL_REFERS, userDetailData.totalReferrals ?? '');
        prefs.setString(Constant.TODAY_EARN, userDetailData.todayEarn ?? '');
        prefs.setString(Constant.TODAY_ADS_STATUS, userDetailData.todayAdsStatus ?? '');
        prefs.setString(Constant.GENDER, userDetailData.gender ?? '');
        prefs.setString(Constant.RECHARGE, userDetailData.recharge ?? '');
        debugPrint("userDetailData.todayAdsStatus : ${userDetailData.todayAdsStatus}");
        update();
      }
      for (var userDetailSettings in userDetail.settings!) {
        print(
            'User ID: ${userDetailSettings.id}');
        whatsppGroupLink.value = userDetailSettings.whatsppGroupLink ?? '';
        prefs.setString(Constant.WHATSPP_GROUP_LINK, userDetailSettings.whatsppGroupLink ?? '');
        update();
      }
    } catch (e) {
      debugPrint("shortsVideoData errors: $e");
    }
  }
}

