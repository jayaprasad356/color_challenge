import 'dart:io';

import 'package:a1_ads/data/repository/job_repo.dart';
import 'package:a1_ads/model/activate_plan_mod.dart';
import 'package:a1_ads/model/all_job_json.dart';
import 'package:a1_ads/model/all_jobs.dart';
import 'package:a1_ads/model/apply_jobs.dart';
import 'package:a1_ads/model/claim_mod.dart';
import 'package:a1_ads/model/job_incom_json.dart';
import 'package:a1_ads/model/job_result_jsion.dart';
import 'package:a1_ads/model/jobs_income.dart';
import 'package:a1_ads/model/jobs_joined_jsers.dart';
import 'package:a1_ads/model/jobs_list.dart';
import 'package:a1_ads/model/jobs_result.dart';
import 'package:a1_ads/model/jobs_upload.dart';
import 'package:a1_ads/model/joined_user_json.dart';
import 'package:a1_ads/model/plan_list.dart';
import 'package:a1_ads/model/plan_list_json.dart';
import 'package:a1_ads/model/team_list.dart';
import 'package:a1_ads/model/team_list_json.dart';
import 'package:a1_ads/model/upload_image.dart';
import 'package:a1_ads/model/user_joined_jobs_json.dart';
import 'package:a1_ads/model/user_plan_list.dart';
import 'package:a1_ads/model/user_plan_list_json.dart';
import 'package:a1_ads/model/users_joined_jobs.dart';
import 'package:a1_ads/util/Color.dart';
import 'package:a1_ads/util/Constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobCon extends GetxController implements GetxService {
  final JobRepo jobRepo;
  JobCon({required this.jobRepo}) {
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
  RxString jobsListDataUploadStatus = ''.obs;
  RxDouble percentageBar = 0.00.obs;

  RxList<JoinedUserJson> joinedUserJson = <JoinedUserJson>[].obs;
  RxList<JobIncomeJson> jobIncomeJson = <JobIncomeJson>[].obs;
  RxList<JobResultJson> jobResultJson = <JobResultJson>[].obs;
  RxList<AllJobsData> allJobsJson = <AllJobsData>[].obs;
  RxList<AllJobsData> jobsListJson = <AllJobsData>[].obs;
  RxList<UserJoinedJobsJson> userJoinedJobsJson = <UserJoinedJobsJson>[].obs;
  RxList<PlanListJson> planListJson = <PlanListJson>[].obs;
  RxList<UserPlanListJson> userPlanListJson = <UserPlanListJson>[].obs;
  RxList<TeamListJson> teamListJson = <TeamListJson>[].obs;

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
      final value =
          await jobRepo.jobsList(prefs.getString(Constant.ID)!, jobId);
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

        percentageBar.value = double.parse(jobsListDataSlotsLeft.toString()) /
            double.parse(jobsListDataTotalSlots.toString()) *
            100;

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
      final value = await jobRepo.jobsUpload(
          jobsId, prefs.getString(Constant.ID)!, imageFile);
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
          JobResultJson data = JobResultJson(jobsResultDataID,
              jobsResultDataName, jobsResultDataIncome, jobsResultDataPosition);

          jobResultJson.add(data);
        }

        update();
      }
    } catch (e) {
      debugPrint("jobsResult errors: $e");
    }
  }

  Future<void> planList() async {
    try {
      final value = await jobRepo.planList(prefs.getString(Constant.ID)!);
      var responseData = value.body;
      PlanDetail planDetail = PlanDetail.fromJson(responseData);
      debugPrint("===> planDetail: $planDetail");
      debugPrint("===> planDetail message: ${planDetail.message}");

      planListJson.clear();

      if (planDetail.data != null && planDetail.data!.isNotEmpty) {
        // Use a loop if there can be multiple transactions
        for (var planDetailData in planDetail.data!) {
          var planDetailDataID = planDetailData.id!;
          var planDetailDataProducts = planDetailData.products!;
          var planDetailDataPrice = planDetailData.price!;
          var planDetailDataTotalIncome = planDetailData.totalIncome!;
          var planDetailDataImage = planDetailData.image!;
          var planDetailDataPosition = planDetailData.dailyIncome!;
          var planDetailDataDailyIncome = planDetailData.validity!;
          var planDetailDataInviteBonus = planDetailData.inviteBonus!;
          var planDetailDataLevelIncome = planDetailData.levelIncome!;

          // Create a TransactionData object and add it to the list
          PlanListJson data = PlanListJson(
            planDetailDataID,
            planDetailDataProducts,
            planDetailDataPrice,
            planDetailDataTotalIncome,
            planDetailDataImage,
            planDetailDataPosition,
            planDetailDataDailyIncome,
            planDetailDataInviteBonus,
            planDetailDataLevelIncome,
          );

          planListJson.add(data);
        }

        update();
      }
    } catch (e) {
      debugPrint("planDetail errors: $e");
    }
  }

  Future<void> userPlanList() async {
    try {
      final value = await jobRepo.userPlanList(prefs.getString(Constant.ID)!);
      var responseData = value.body;
      UserPlanDetail userPlanDetail = UserPlanDetail.fromJson(responseData);
      debugPrint("===> userPlanDetail: $userPlanDetail");
      debugPrint("===> userPlanDetail message: ${userPlanDetail.message}");

      userPlanListJson.clear();

      if (userPlanDetail.data != null && userPlanDetail.data!.isNotEmpty) {
        // Use a loop if there can be multiple transactions
        for (var userPlanDetailData in userPlanDetail.data!) {
          UserPlanListJson data = UserPlanListJson(
            userPlanDetailData.id!,
            userPlanDetailData.userId!,
            userPlanDetailData.planId!,
            userPlanDetailData.income!,
            userPlanDetailData.joinedDate!,
            userPlanDetailData.claim!,
            userPlanDetailData.image!,
            userPlanDetailData.products!,
            userPlanDetailData.inviteBonus!,
            userPlanDetailData.price!,
            userPlanDetailData.levelIncome!,
            userPlanDetailData.totalIncome!,
            userPlanDetailData.dailyIncome!,
            userPlanDetailData.validity!,
          );

          userPlanListJson.add(data);
        }

        update();
      }
    } catch (e) {
      debugPrint("userPlanDetail errors: $e");
    }
  }

  Future<void> teamList(String level) async {
    try {
      final value =
          await jobRepo.teamList(prefs.getString(Constant.ID)!, level);
      var responseData = value.body;
      TeamList teamList = TeamList.fromJson(responseData);
      debugPrint("===> teamList: $teamList");
      debugPrint("===> teamList message: ${teamList.message}");

      teamListJson.clear();

      if (teamList.data != null && teamList.data!.isNotEmpty) {
        // Use a loop if there can be multiple transactions
        for (var teamListData in teamList.data!) {
          TeamListJson data = TeamListJson(
              teamListData.id!,
              teamListData.mobile!,
              teamListData.registeredDate!,
              "11",
              "10.00");

          teamListJson.add(data);
        }

        update();
      }
    } catch (e) {
      debugPrint("userPlanDetail errors: $e");
    }
  }

  Future<void> activatePlan(String planId) async {
    try {
      final value =
          await jobRepo.activatePlan(prefs.getString(Constant.ID)!, planId);
      var responseData = value.body;
      ActivatePlanMod activatePlanMod = ActivatePlanMod.fromJson(responseData);
      debugPrint("===> activatePlanMod: $activatePlanMod");
      debugPrint("===> activatePlanMod message: ${activatePlanMod.message}");

      Get.snackbar(
        activatePlanMod.success.toString(),
        activatePlanMod.message.toString(),
        duration: const Duration(seconds: 3),
        colorText: colors.primary_color,
        backgroundColor: Colors.white,
      );
    } catch (e) {
      debugPrint("activatePlanMod errors: $e");
    }
  }

  Future<void> claim(String planId) async {
    try {
      final value =
          await jobRepo.activatePlan(prefs.getString(Constant.ID)!, planId);
      var responseData = value.body;
      ClaimMod claimMod = ClaimMod.fromJson(responseData);
      debugPrint("===> claimMod: $claimMod");
      debugPrint("===> claimMod message: ${claimMod.message}");

      Get.snackbar(
        claimMod.success.toString(),
        claimMod.message.toString(),
        duration: const Duration(seconds: 3),
        colorText: colors.primary_color,
        backgroundColor: Colors.white,
      );
    } catch (e) {
      debugPrint("claimMod errors: $e");
    }
  }

  Future<void> usersJoinedJobs() async {
    try {
      final value =
          await jobRepo.usersJoinedJobs(prefs.getString(Constant.ID)!);
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
              usersJoinedJobsDataAppliFees);

          userJoinedJobsJson.add(data);
        }

        update();
      }
    } catch (e) {
      debugPrint("usersJoinedJobs errors: $e");
    }
  }

  Future<void> applyJobs(jobsId) async {
    try {
      final value =
          await jobRepo.applyJobs(prefs.getString(Constant.ID)!, jobsId);
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
