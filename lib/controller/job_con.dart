import 'dart:io';

import 'package:a1_ads/data/repository/job_repo.dart';
import 'package:a1_ads/model/all_job_json.dart';
import 'package:a1_ads/model/all_jobs.dart';
import 'package:a1_ads/model/apply_jobs.dart';
import 'package:a1_ads/model/job_incom_json.dart';
import 'package:a1_ads/model/job_result_jsion.dart';
import 'package:a1_ads/model/jobs_income.dart';
import 'package:a1_ads/model/jobs_joined_jsers.dart';
import 'package:a1_ads/model/jobs_list.dart';
import 'package:a1_ads/model/jobs_result.dart';
import 'package:a1_ads/model/jobs_upload.dart';
import 'package:a1_ads/model/joined_user_json.dart';
import 'package:a1_ads/model/upload_image.dart';
import 'package:a1_ads/model/user_joined_jobs_json.dart';
import 'package:a1_ads/model/users_joined_jobs.dart';
import 'package:a1_ads/util/Color.dart';
import 'package:a1_ads/util/Constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobCon extends GetxController implements GetxService {
  final JobRepo jobRepo;
  JobCon({required this.jobRepo}){
    SharedPreferences.getInstance().then((value) {
      prefs = value;
    });
  }
  late SharedPreferences prefs;
  RxString jobsListDataID = ''.obs;
  RxString jobsListDataJobId = ''.obs;
  RxString jobsListDataName = ''.obs;
  RxString jobsListDataProfile = ''.obs;
  RxString jobsListDataDescription = ''.obs;
  RxString jobsListDataTotalSlots = ''.obs;
  RxString jobsListDataSlotsLeft = ''.obs;
  RxString jobsListDataAppliFees = ''.obs;
  RxString jobsListDataAppliedStatus = ''.obs;
  RxString jobsListDataJobUpdate = ''.obs;
  RxString jobsListDataUploadStatus= ''.obs;
  RxDouble percentageBar = 0.00.obs;

  RxList<JoinedUserJson> joinedUserJson = <JoinedUserJson>[].obs;
  RxList<JobIncomeJson> jobIncomeJson = <JobIncomeJson>[].obs;
  RxList<JobResultJson> jobResultJson = <JobResultJson>[].obs;
  RxList<AllJobsData> allJobsJson = <AllJobsData>[].obs;
  RxList<AllJobsData> jobsListJson = <AllJobsData>[].obs;
  RxList<UserJoinedJobsJson> userJoinedJobsJson = <UserJoinedJobsJson>[].obs;

  Future<void> allJobs() async {
    try {
      final value = await jobRepo.allJobs(prefs.getString(Constant.ID)!);
      var responseData = value.body;
      AllJobs allJobs = AllJobs.fromJson(responseData);
      debugPrint("===> allJobs: $allJobs");
      debugPrint("===> allJobs message: ${allJobs.message}");

      allJobsJson.clear();

      if (allJobs.data != null && allJobs.data!.isNotEmpty) {
        // Use a loop if there can be multiple transactions
        for (var allJobsData in allJobs.data!) {
          var allJobsDataID = allJobsData.id!;
          var allJobsDataJobId = allJobsData.jobId!;
          var allJobsDataName = allJobsData.name!;
          var allJobsDataProfile = allJobsData.profile!;
          var allJobsDataDescription = allJobsData.description!;
          var allJobsDataTotalSlots = allJobsData.totalSlots!;
          var allJobsDataSlotsLeft = allJobsData.slotsLeft!;
          var allJobsDataAppliFees = allJobsData.appliFees!;

          // Create a TransactionData object and add it to the list
          AllJobsData data = AllJobsData(
            allJobsDataID,
            allJobsDataJobId,
            allJobsDataName,
            allJobsDataProfile,
            allJobsDataDescription,
            allJobsDataTotalSlots,
            allJobsDataSlotsLeft,
            allJobsDataAppliFees,
          );

          allJobsJson.add(data);
        }

        update();
      }

    } catch (e) {
      debugPrint("allJobs errors: $e");
    }
  }

  Future<void> jobsList(jobId) async {
    try {
      final value = await jobRepo.jobsList(prefs.getString(Constant.ID)!,jobId);
      var responseData = value.body;
      JobsList jobsList = JobsList.fromJson(responseData);
      debugPrint("===> jobsList: $jobsList");
      debugPrint("===> jobsList message: ${jobsList.message}");

      if (jobsList.data != null && jobsList.data!.isNotEmpty) {
        // Use a loop if there can be multiple transactions
        for (var jobsListData in jobsList.data!) {
          jobsListDataID.value = jobsListData.id!;
           jobsListDataJobId.value = jobsListData.jobId!;
           jobsListDataName.value = jobsListData.name!;
           jobsListDataProfile.value = jobsListData.profile!;
           jobsListDataDescription.value = jobsListData.description!;
           jobsListDataTotalSlots.value = jobsListData.totalSlots!;
           jobsListDataSlotsLeft.value = jobsListData.slotsLeft!;
           jobsListDataAppliFees.value = jobsListData.appliFees!;
          jobsListDataAppliedStatus.value = jobsListData.appliedStatus!;
           jobsListDataJobUpdate.value = jobsListData.jobUpdate!;
          jobsListDataUploadStatus.value = jobsListData.uploadStatus!;
        }

        percentageBar.value =
            double.parse(jobsListDataSlotsLeft.toString()) / double.parse(jobsListDataTotalSlots.toString()) * 100;

        update();
      }

    } catch (e) {
      debugPrint("jobsList errors: $e");
    }
  }

  Future<void> jobsUpload(String jobsId, XFile image) async {
    try {
      File imageFile = File(image.path);
      debugPrint("===> imageFile: $imageFile");
      final value = await jobRepo.jobsUpload(jobsId, prefs.getString(Constant.ID)!, imageFile);
      debugPrint("===> value: $value");

      if (value == null || value.body == null) {
        Get.snackbar(
          "Oops",
          "Invalid server response",
          duration: const Duration(seconds: 3),
          colorText: colors.primary_color,
        );
        debugPrint("Invalid server response: $value");
        return;
      }

      var responseData = value.body;
      debugPrint("===> responseData: $responseData");

      // Process the response
      if (responseData is Map<String, dynamic>) {
        JobsUpload jobsUpload = JobsUpload.fromJson(responseData);
        debugPrint("===> jobsUpload: ${jobsUpload.success}");
        debugPrint("===> jobsUpload: ${jobsUpload.message}");

        Get.snackbar(
          jobsUpload.success.toString(),
          "${jobsUpload.message}",
          duration: const Duration(seconds: 3),
          colorText: colors.primary_color,
        );
      } else {
        Get.snackbar(
          "Oops",
          "Invalid server response format",
          duration: const Duration(seconds: 3),
          colorText: colors.primary_color,
        );
        debugPrint("Invalid server response format: $responseData");
      }
    } catch (e) {
      Get.snackbar(
        "Oops",
        "Your image is not uploaded",
        duration: const Duration(seconds: 3),
        colorText: colors.primary_color,
      );
      debugPrint("jobsUpload errors: $e");
    }
  }


  // Future<void> jobsUpload( jobsId, image) async {
  //   try {
  //     final value = await jobRepo.jobsUpload( jobsId, prefs.getString(Constant.ID)!, image);
  //     var responseData = value.body;
  //     JobsUpload jobsUpload = JobsUpload.fromJson(responseData);
  //     debugPrint("===> jobsUpload: $jobsUpload");
  //     debugPrint("===> jobsUpload message: ${jobsUpload.message}");
  //
  //   } catch (e) {
  //     debugPrint("jobsUpload errors: $e");
  //   }
  // }

  Future<void> jobsJoinedUsers(jobId) async {
    try {
      final value = await jobRepo.jobsJoinedUsers(jobId);
      var responseData = value.body;
      JobsJoinedUsers jobsJoinedUsers = JobsJoinedUsers.fromJson(responseData);
      debugPrint("===> jobsJoinedUsers: $jobsJoinedUsers");
      debugPrint("===> jobsJoinedUsers message: ${jobsJoinedUsers.message}");

      joinedUserJson.clear();

      if (jobsJoinedUsers.data != null && jobsJoinedUsers.data!.isNotEmpty) {
        // Use a loop if there can be multiple transactions
        for (var jobsJoinedUsersData in jobsJoinedUsers.data!) {
          var jobsJoinedUsersDataID = jobsJoinedUsersData.id!;
          var jobsJoinedUsersDataName = jobsJoinedUsersData.name!;
          var jobsJoinedUsersDataStatus = jobsJoinedUsersData.status!;

          // Create a TransactionData object and add it to the list
          JoinedUserJson data = JoinedUserJson(
            jobsJoinedUsersDataID,
            jobsJoinedUsersDataName,
            jobsJoinedUsersDataStatus,
          );

          joinedUserJson.add(data);
        }

        update();
      }

    } catch (e) {
      debugPrint("jobsJoinedUsers errors: $e");
    }
  }

  Future<void> jobsIncome(jobId) async {
    try {
      final value = await jobRepo.jobsIncome(jobId);
      var responseData = value.body;
      JobsIncome jobsIncome = JobsIncome.fromJson(responseData);
      debugPrint("===> jobsIncome: $jobsIncome");
      debugPrint("===> jobsIncome message: ${jobsIncome.message}");

      jobIncomeJson.clear();

      if (jobsIncome.data != null && jobsIncome.data!.isNotEmpty) {
        // Use a loop if there can be multiple transactions
        for (var jobsIncomeData in jobsIncome.data!) {
          var jobsIncomeDataID = jobsIncomeData.id!;
          var jobsIncomeDataIncome = jobsIncomeData.income!;
          var jobsIncomeDataPosition = jobsIncomeData.position!;

          // Create a TransactionData object and add it to the list
          JobIncomeJson data = JobIncomeJson(
            jobsIncomeDataID,
            jobsIncomeDataIncome,
            jobsIncomeDataPosition,
          );

          jobIncomeJson.add(data);
        }

        update();
      }

    } catch (e) {
      debugPrint("jobsIncome errors: $e");
    }
  }

  Future<void> jobsResult(jobId) async {
    try {
      final value = await jobRepo.jobsResult(jobId);
      var responseData = value.body;
      JobsResult jobsResult = JobsResult.fromJson(responseData);
      debugPrint("===> jobsResult: $jobsResult");
      debugPrint("===> jobsResult message: ${jobsResult.message}");

      jobResultJson.clear();

      if (jobsResult.data != null && jobsResult.data!.isNotEmpty) {
        // Use a loop if there can be multiple transactions
        for (var jobsResultData in jobsResult.data!) {
          var jobsResultDataID = jobsResultData.id!;
          var jobsResultDataName = jobsResultData.name!;
          debugPrint("jobsResultDataName: $jobsResultDataName");
          var jobsResultDataIncome = jobsResultData.income!;
          var jobsResultDataPosition = jobsResultData.position!;

          // Create a TransactionData object and add it to the list
          JobResultJson data = JobResultJson(
            jobsResultDataID,
            jobsResultDataName,
            jobsResultDataIncome,
              jobsResultDataPosition
          );

          jobResultJson.add(data);
        }

        update();
      }

    } catch (e) {
      debugPrint("jobsResult errors: $e");
    }
  }

  Future<void> usersJoinedJobs() async {
    try {
      final value = await jobRepo.usersJoinedJobs(prefs.getString(Constant.ID)!);
      var responseData = value.body;
      UsersJoinedJobs usersJoinedJobs = UsersJoinedJobs.fromJson(responseData);
      debugPrint("===> usersJoinedJobs: $usersJoinedJobs");
      debugPrint("===> usersJoinedJobs message: ${usersJoinedJobs.message}");

      userJoinedJobsJson.clear();

      if (usersJoinedJobs.data != null && usersJoinedJobs.data!.isNotEmpty) {
        // Use a loop if there can be multiple transactions
        for (var usersJoinedJobsData in usersJoinedJobs.data!) {
          var usersJoinedJobsDataID = usersJoinedJobsData.id!;
          var usersJoinedJobsDataJobID = usersJoinedJobsData.jobId!;
          var usersJoinedJobsDataName = usersJoinedJobsData.name!;
          var usersJoinedJobsDataProfile = usersJoinedJobsData.profile!;
          var usersJoinedJobsDataDescription = usersJoinedJobsData.description!;
          var usersJoinedJobsDataTotalSlots = usersJoinedJobsData.totalSlots!;
          var usersJoinedJobsDataSlotsLeft = usersJoinedJobsData.slotsLeft!;
          var usersJoinedJobsDataAppliFees = usersJoinedJobsData.appliFees!;

          // Create a TransactionData object and add it to the list
          UserJoinedJobsJson data = UserJoinedJobsJson(
            usersJoinedJobsDataID,
              usersJoinedJobsDataJobID,
            usersJoinedJobsDataName,
            usersJoinedJobsDataProfile,
            usersJoinedJobsDataDescription,
              usersJoinedJobsDataTotalSlots,
              usersJoinedJobsDataSlotsLeft,
              usersJoinedJobsDataAppliFees
          );

          userJoinedJobsJson.add(data);
        }

        update();
      }

    } catch (e) {
      debugPrint("usersJoinedJobs errors: $e");
    }
  }

  Future<void> applyJobs( jobsId) async {
    try {
      final value = await jobRepo.applyJobs( prefs.getString(Constant.ID)!, jobsId);
      var responseData = value.body;
      ApplyJobs applyJobs = ApplyJobs.fromJson(responseData);
      debugPrint("===> applyJobs: $applyJobs");
      debugPrint("===> applyJobs message: ${applyJobs.message}");

      Get.snackbar(
        applyJobs.success.toString(),
        applyJobs.message.toString(),
        duration: const Duration(seconds: 3),
        colorText: colors.primary_color,
      );
    } catch (e) {
      debugPrint("applyJobs errors: $e");
    }
  }
}
