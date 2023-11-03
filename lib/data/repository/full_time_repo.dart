import 'package:a1_ads/data/api/api_client.dart';
import 'package:a1_ads/util/Constant.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class FullTimeRepo {
  late final ApiClient apiClient;
  late final FlutterSecureStorage storageLocal;

  FullTimeRepo({required this.apiClient, required this.storageLocal});

  Future<Response> syncData(String userId, String ads, String syncUniqueId,
      String deviceId, String syncType) async {
    Map<String, String> body = {
      'user_id': userId,
      'ads': ads,
      'sync_unique_id': syncUniqueId,
      'device_id': deviceId,
      'sync_type': syncType,
    };
    return await apiClient.postData(Constant.WALLET, body, {});
  }
}
