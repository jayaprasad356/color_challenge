import 'dart:io';

import 'package:color_challenge/data/api/api_client.dart';
import 'package:color_challenge/util/Constant.dart';
import 'package:flutter/cupertino.dart';
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

  Future<Response> imageListData() async {
    return await apiClient.postData(
      Constant.IMAGE_LIST,{
      // 'Accept' : '*/*',
      // 'Accept-Encoding' : 'gzip, deflate, br',
      // 'Connection' : 'keep-alive'
    },
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
        headers: {},
      );
    } catch (e) {
      // Handle any errors during the request
      return Response(statusCode: 1, statusText: 'Error: $e');
    }
  }


  // Future<Response> postMyPost(String user_id, File image) async {
  //   Map<String, dynamic> body = {
  //     'user_id': user_id,
  //     'image': image,
  //   };
  //   return await apiClient.postData(
  //     Constant.POST_MY_POST,body, headers: {},
  //   );
  // }
}