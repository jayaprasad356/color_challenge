import 'dart:convert';

import 'package:a1_ads/data/api/api_client.dart';
import 'package:a1_ads/data/repository/home_repo.dart';
import 'package:a1_ads/data/repository/job_repo.dart';
import 'package:a1_ads/data/repository/shorts_video_repo.dart';
import 'package:a1_ads/model/category_json_file.dart';
import 'package:a1_ads/model/category_list_mod.dart';
import 'package:a1_ads/model/order_json.dart';
import 'package:a1_ads/model/order_list.dart';
import 'package:a1_ads/model/place_order.dart';
import 'package:a1_ads/model/product_json_file.dart';
import 'package:a1_ads/model/product_list_mod.dart';
import 'package:a1_ads/model/settings_data.dart';
import 'package:a1_ads/model/slider_data.dart';
import 'package:a1_ads/model/video_list.dart';
import 'package:a1_ads/util/Color.dart';
import 'package:a1_ads/util/Constant.dart';
import 'package:a1_ads/view/screens/home_page/my_orders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

class JobCon extends GetxController implements GetxService {
  final JobRepo jobRepo;
  JobCon({required this.jobRepo}){
    SharedPreferences.getInstance().then((value) {
      prefs = value;
    });
  }
  late SharedPreferences prefs;

}
