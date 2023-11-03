import 'package:a1_ads/data/api/api_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UPIRepo {
  late final ApiClient apiClient;
  late final FlutterSecureStorage storageLocal;

  UPIRepo({required this.apiClient, required this.storageLocal});

}