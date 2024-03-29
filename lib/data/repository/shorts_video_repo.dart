import 'dart:convert';
import 'dart:io';

import 'package:a1_ads/data/api/api_client.dart';
import 'package:a1_ads/data/respons/error_response.dart';
import 'package:a1_ads/util/Constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;

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

  Future<Response> imageListData(String userId) async {
    Map<String, String> body = {
      'user_id': userId,
    };
    return await apiClient.postData(
      Constant.POSTS_LIST,body,{}
    );
  }

  Future<Response> likeAPI(String userId, String postId) async {
    Map<String, String> body = {
      'user_id': userId,
      'post_id': postId,
    };
    return await apiClient.postData(
      Constant.Like_API,body,{}
    );
  }

  Future<Response> purchaseAPI(String userId) async {
    Map<String, String> body = {
      'user_id': userId,
    };
    return await apiClient.postData(
      Constant.PURCHASE_POST,body,{}
    );
  }

  Future<Response> offerAPI(String userId) async {
    Map<String, String> body = {
      'user_id': userId,
    };
    return await apiClient.postData(
      Constant.OFFER_LIST,body,{}
    );
  }

  Future<Response> postMyPost(String userId, File image) async {
      try {
        List<MultipartBody> multipartBodies = [
          MultipartBody(key: 'image', file: image),
        ];

        Map<String, String> body = {
          'user_id': userId,
        };

        return await apiClient.postMultipartData(
          Constant.POST_MY_POST,
          body,
          multipartBodies,
          // headers: {},
        );
      } catch (e) {
        return Response(statusCode: 1, statusText: 'Error: $e');
      }
  }
}