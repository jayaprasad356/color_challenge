import 'package:a1_ads/data/api/api_client.dart';
import 'package:a1_ads/util/Constant.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'dart:io';

class JobRepo {
  late final ApiClient apiClient;
  late final FlutterSecureStorage storageLocal;

  JobRepo({required this.apiClient, required this.storageLocal});

  Future<Response> allJobs(String userId) async {
    Map<String, String> body = {
      'user_id': userId,
    };
    return await apiClient.postData(Constant.ALL_JOBS, body, {});
  }

  Future<Response> jobsList(String userId, String jobsId) async {
    Map<String, String> body = {
      'user_id': userId,
      'jobs_id': jobsId,
    };
    return await apiClient.postData(Constant.JOB_LIST_API, body, {});
  }

  Future<Response> jobsUpload(String jobsId, String userId, File image) async {
    try {
      Map<String, String> body = {
        'jobs_id': jobsId,
        'user_id': userId,
      };

      List<MultipartBody> multipartBodies = [
        MultipartBody(key: 'image', file: image,isNetworkImage: true,),
      ];

      return await apiClient.postMultipartData(
        Constant.UPLOAD_JOBS,
        body,
        multipartBodies,
        // headers: {},
      );
    } catch (e) {
      return Response(statusCode: 1, statusText: 'Error: $e');
    }
  }


  Future<Response> jobsJoinedUsers(String jobsId) async {
    Map<String, String> body = {
      'jobs_id': jobsId,
    };
    return await apiClient.postData(Constant.JOBS_JOINED_USERS, body, {});
  }

  Future<Response> jobsIncome(String jobsId) async {
    Map<String, String> body = {
      'jobs_id': jobsId,
    };
    return await apiClient.postData(Constant.JOB_INCOME, body, {});
  }

  Future<Response> jobsResult(String jobsId) async {
    Map<String, String> body = {
      'jobs_id': jobsId,
    };
    return await apiClient.postData(Constant.JOB_RESULT, body, {});
  }

  Future<Response> planList(String userId) async {
    Map<String, String> body = {
      'user_id': userId,
    };
    return await apiClient.postData(Constant.PLAN_LIST, body, {});
  }

  Future<Response> userPlanList(String userId) async {
    Map<String, String> body = {
      'user_id': userId,
    };
    return await apiClient.postData(Constant.USER_PLAN_LIST, body, {});
  }

  Future<Response> teamList(String userId, String level) async {
    Map<String, String> body = {
      'user_id': userId,
      'level': level,
    };
    return await apiClient.postData(Constant.TEAM_LIST, body, {});
  }

  Future<Response> activatePlan(String userId, String planId) async {
    Map<String, String> body = {
      'user_id': userId,
      'plan_id': planId,
    };
    return await apiClient.postData(Constant.ACTIVATE_PLAN, body, {});
  }

  Future<Response> claim(String userId, String planId) async {
    Map<String, String> body = {
      'user_id': userId,
      'plan_id': planId,
    };
    return await apiClient.postData(Constant.CLAIM, body, {});
  }

  Future<Response> usersJoinedJobs(String userId) async {
    Map<String, String> body = {
      'user_id': userId,
    };
    return await apiClient.postData(Constant.USER_JOINED_JOBS, body, {});
  }

  Future<Response> applyJobs(String userId, String jobsId) async {
    Map<String, String> body = {
      'user_id': userId,
      'jobs_id': jobsId,
    };
    return await apiClient.postData(Constant.APPLY_JOBS, body, {});
  }

}