import 'package:color_challenge/data/api/api_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FullTimeRepo {
  late final ApiClient apiClient;
  late final FlutterSecureStorage storageLocal;

  FullTimeRepo({required this.apiClient, required this.storageLocal});

}