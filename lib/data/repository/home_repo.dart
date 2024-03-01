import 'dart:io';

import 'package:a1_ads/data/api/api_client.dart';
import 'package:a1_ads/util/Constant.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class HomeRepo {
  late final ApiClient apiClient;
  late final FlutterSecureStorage storageLocal;

  HomeRepo({required this.apiClient, required this.storageLocal});

  Future<Response> allSettingsList() async {
    return await apiClient.postData(
      Constant.SETTINGS_URL,{},{}
    );
  }

  Future<Response> uploadStatus(String userId, String noOfViews, File image) async {
    try {
      Map<String, String> body = {
        'user_id': userId,
        'no_of_views' : noOfViews,
      };

      List<MultipartBody> multipartBodies = [
        MultipartBody(key: 'image', file: image,isNetworkImage: true,),
      ];

      return await apiClient.postMultipartData(
        Constant.UPLOAD_STATUS,
        body,
        multipartBodies,
        // headers: {},
      );
    } catch (e) {
      return Response(statusCode: 1, statusText: 'uploadStatus Error: $e');
    }
  }

  Future<Response> whatsappList(String userId,) async {
    Map<String, dynamic> body = {
      'user_id' : userId,
    };
    return await apiClient.postData(
      Constant.WHATSAPP_LIST,body,{}
    );
  }

  Future<Response> sliderList(String userId,) async {
    Map<String, dynamic> body = {
      'user_id' : userId,
    };
    return await apiClient.postData(
      Constant.SLIDE_API,body,{}
    );
  }

  Future<Response> userData(String userId,) async {
    Map<String, dynamic> body = {
      'user_id' : userId,
    };
    return await apiClient.postData(
        Constant.USER_DETAIL_URL,body,{}
    );
  }

  Future<Response> categoryListData() async {
    Map<String, dynamic> body = {};
    return await apiClient.postData(
        Constant.CATEGORY_LIST,body,{}
    );
  }

  Future<Response> myOrderListData(String userId) async {
    Map<String, dynamic> body = {
      'user_id' : userId,
    };
    return await apiClient.postData(
        Constant.ORDERS_LIST,body,{}
    );
  }

  Future<Response> productListData(String categoryId) async {
    Map<String, dynamic> body = {
      'category_id' : categoryId
    };
    return await apiClient.postData(
        Constant.PRODUCT_LIST,body,{}
    );
  }

  Future<Response> placeOrder(String userId, String productId, String address, String pinCode) async {
    Map<String, dynamic> body = {
      'user_id' : userId,
      'product_id' : productId,
      'address' : address,
      'pincode' : pinCode,
    };
    return await apiClient.postData(
        Constant.ORDERS,body,{}
    );
  }

  Future<Response> scratchCard(String userId) async {
    Map<String, dynamic> body = {
      'user_id' : userId,
    };
    return await apiClient.postData(
        Constant.SCRATCH_CARD,body,{}
    );
  }
}