
import 'package:color_challenge/data/api/api_client.dart';
import 'package:color_challenge/data/repository/home_repo.dart';
import 'package:color_challenge/data/repository/shorts_video_repo.dart';
import 'package:color_challenge/model/settings_data.dart';
import 'package:color_challenge/model/video_list.dart';
import 'package:color_challenge/util/Constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class HomeController extends GetxController implements GetxService {
  final HomeRepo homeRepo;

  HomeController({required this.homeRepo});

  // late Str

  @override
  void onInit() {
    super.onInit();
    allSettingsData();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> allSettingsData() async {
    try {
      final value = await homeRepo.allSettingsList();
      var responseData = value.body;
      SettingData settingData = SettingData.fromJson(responseData);
      debugPrint("===> shortVideoListData: $settingData");



    } catch (e) {
      debugPrint("shortsVideoData errors: $e");
    }
  }
}