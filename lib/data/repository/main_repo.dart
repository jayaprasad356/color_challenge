import 'package:a1_ads/data/api/api_client.dart';
import 'package:a1_ads/util/Constant.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class MainRepo {
  late final ApiClient apiClient;
  late final FlutterSecureStorage storageLocal;

  MainRepo({required this.apiClient, required this.storageLocal});

  Future<Response> userData(String userId,) async {
    Map<String, dynamic> body = {
      'user_id' : userId,
    };
    return await apiClient.postData(
        Constant.USER_DETAIL_URL,body,{}
    );
  }
}