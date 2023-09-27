import 'package:color_challenge/data/api/api_client.dart';
import 'package:color_challenge/util/Constant.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class ShortsVideoRepo {
  late final ApiClient apiClient;
  late final FlutterSecureStorage storageLocal;

  ShortsVideoRepo({required this.apiClient, required this.storageLocal});

  Future<Response> shortsVideoList() async {
    return await apiClient.getData(
      Constant.SHORTS_URL,{
      // 'Accept' : '*/*',
      // 'Accept-Encoding' : 'gzip, deflate, br',
      // 'Connection' : 'keep-alive'
      },
    );
  }
}