import 'package:a1_ads/data/api/api_client.dart';
import 'package:a1_ads/util/Constant.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class JobRepo {
  late final ApiClient apiClient;
  late final FlutterSecureStorage storageLocal;

  JobRepo({required this.apiClient, required this.storageLocal});

}