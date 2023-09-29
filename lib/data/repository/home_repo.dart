import 'package:color_challenge/data/api/api_client.dart';
import 'package:color_challenge/util/Constant.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class HomeRepo {
  late final ApiClient apiClient;
  late final FlutterSecureStorage storageLocal;

  HomeRepo({required this.apiClient, required this.storageLocal});

  Future<Response> allSettingsList() async {
    return await apiClient.postData(
      Constant.SETTINGS_URL_ALL,{},
    );
  }
}