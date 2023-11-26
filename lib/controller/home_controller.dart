import 'dart:convert';

import 'package:a1_ads/data/api/api_client.dart';
import 'package:a1_ads/data/repository/home_repo.dart';
import 'package:a1_ads/data/repository/shorts_video_repo.dart';
import 'package:a1_ads/model/settings_data.dart';
import 'package:a1_ads/model/slider_data.dart';
import 'package:a1_ads/model/video_list.dart';
import 'package:a1_ads/util/Constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

class SliderItem {
  final String imageUrl;

  SliderItem(this.imageUrl);
}

class HomeController extends GetxController implements GetxService {
  final HomeRepo homeRepo;
  HomeController({required this.homeRepo});
  final RxList sliderImageURL = [].obs;
  final RxList sliderName = [].obs;
  final RxList sliderItems = [].obs;
  final RxInt currentIndex = 0.obs;
  late SharedPreferences prefs;
  final RxString a1JobDetailsURS = ''.obs;
  final RxString a1JobVideoURS = ''.obs;
  final RxString a1PurchaseURS = ''.obs;
  final RxString a2JobDetailsURS = ''.obs;
  final RxString a2JobVideoURS = ''.obs;
  final RxString a2PurchaseURS = ''.obs;
  final RxString watchAdStatus = ''.obs;
  final RxString rewardAdsDetails = ''.obs;
  final RxString referBonus = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // allSettingsData();
    // shortsVideoData();
    // getUserId();
  }

  // @override
  // void onInit() async {
  //   super.onInit();
  //   prefs = await SharedPreferences.getInstance();
  //   slideList(prefs.getString(Constant.ID));
  //   // allSettingsData();
  //   // String? userId = await getUserId();
  //   // slideList(userId);
  // }

  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constant.ID);
  }

  Future<String?> getIpAddress() async {
    final response = await http.get(Uri.parse('https://admin.colorjobs.site/'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load IP address');
    }
  }

  Future<void> allSettingsData() async {
    try {
      final value = await homeRepo.allSettingsList();
      var responseData = value.body;
      SettingData settingData = SettingData.fromJson(responseData);
      debugPrint("===> settingData: $settingData");
      debugPrint("===> settingData message: ${settingData.message}");

      for (var settingsData in settingData.data!) {
        print(
            'User ID: ${settingsData.id},\na1jobVideo: ${settingsData.a1JobVideo},\na1jobDetails: ${settingsData.a1JobDetails},\na1PurchaseLink: ${settingsData.a1PurchaseLink},\na2jobVideo: ${settingsData.a2JobVideo},\na2jobDetails: ${settingsData.a2JobDetails},\na2PurchaseLink: ${settingsData.a2PurchaseLink},\nwatchAdStatus: ${settingsData.watchAdStatus}');
        a1JobDetailsURS.value = settingsData.a1JobDetails ?? '';
        a1JobVideoURS.value = settingsData.a1JobVideo ?? '';
        a1PurchaseURS.value = settingsData.a1PurchaseLink ?? '';
        a2JobDetailsURS.value = settingsData.a2JobDetails ?? '';
        a2JobVideoURS.value = settingsData.a2JobVideo ?? '';
        a2PurchaseURS.value = settingsData.a2PurchaseLink ?? '';
        watchAdStatus.value = settingsData.watchAdStatus ?? '';
        rewardAdsDetails.value = settingsData.rewardAdsDetails ?? '';
        referBonus.value = settingsData.referBonus ?? '';
      }
    } catch (e) {
      debugPrint("shortsVideoData errors: $e");
    }
  }

  Future<void> slideList(userId) async {
    try {
      final value = await homeRepo.sliderList(userId);
      var responseData = value.body;
      SliderDataItem sliderData = SliderDataItem.fromJson(responseData);
      debugPrint("===> sliderData: $sliderData");
      debugPrint("===> sliderData message: ${sliderData.message}");

      // Clear the existing data before adding new data
      sliderImageURL.clear();
      sliderName.clear();

      for (var slideData in sliderData.data!) {
        print('User ID: ${slideData.id},  image: ${slideData.image}');
        sliderImageURL.add(slideData.image ?? '');
        sliderName.add(slideData.name ?? '');
      }
    } catch (e) {
      debugPrint("shortsVideoData errors: $e");
    }
  }
}
