import 'dart:io';

import 'package:a1_ads/data/api/api_client.dart';
import 'package:a1_ads/data/repository/shorts_video_repo.dart';
import 'package:a1_ads/model/like_data.dart';
import 'package:a1_ads/model/offer_list.dart';
import 'package:a1_ads/model/post_list.dart';
import 'package:a1_ads/model/purchase_data.dart';
import 'package:a1_ads/model/upload_image.dart';
import 'package:a1_ads/model/video_list.dart';
import 'package:a1_ads/util/Constant.dart';
import 'package:a1_ads/view/screens/shorts_vid/post_upload.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class PCC extends GetxController implements GetxService {
  final ShortsVideoRepo shortsVideoRepo;
  PCC({required this.shortsVideoRepo});
  late SharedPreferences prefs;
  int _api = 0;
  List<VideoPlayerController?> videoPlayerControllers = [];
  List<int> initilizedIndexes = [];
  bool autoplay = true;
  int get api => _api;
  RxInt counter = 0.obs;
  final RxList videoURL = [].obs;
  final RxList imageURS = [].obs;
  final RxString offerImageURS = ''.obs;
  final RxList name = [].obs;
  final RxList caption = [].obs;
  final RxList ID = [].obs;
  final RxList likes = [].obs;
  final RxList shareLink = [].obs;
  final RxList userLike = [].obs;
  var photo = Rxn<XFile>();
  // RxList<RxBool> isLikedList = <RxBool>[].obs;
  //
  // PCC1(int length) {
  //   for (var i = 0; i < length; i++) {
  //     isLikedList.add(false.obs);
  //   }
  // }
  //
  // void toggleLike(int index) {
  //   if (index >= 0 && index < isLikedList.length) {
  //     isLikedList[index].value = !isLikedList[index].value;
  //   }
  // }

  @override
  void onInit() {
    super.onInit();
    // shortsVideoData();
    // imageListData();
    getUserId();
    // initializeData();
  }

  // Future<void> initializeData() async {
  //   prefs = await SharedPreferences.getInstance();
  //   String? userId = prefs.getString(Constant.ID);
  //   debugPrint("userId : $userId");
  //   offerAPI(userId!);
  // }

  @override
  void onClose() {
    super.onClose();
  }

  // Future<void> shortsVideoData() async {
  //   try {
  //     final value = await shortsVideoRepo.shortsVideoList();
  //     var responseData = value.body;
  //     VideoList shortVideoListData = VideoList.fromJson(responseData);
  //     debugPrint("===> shortVideoListData: $shortVideoListData");
  //
  //     for (var videoData in shortVideoListData.data!) {
  //       print('Video ID: ${videoData.id}, User ID: ${videoData.userId}, URL: ${videoData.url}');
  //       videoURL.add(videoData.url ?? '');
  //     }
  //   } catch (e) {
  //     debugPrint("shortsVideoData errors: $e");
  //   }
  // }

  Future<void> imageListData(String userId) async {
    try {
      final value = await shortsVideoRepo.imageListData(userId);
      var responseData = value.body;
      PostList imageList = PostList.fromJson(responseData);
      debugPrint("===> imageListData: $imageList");

      name.clear();
      caption.clear();
      ID.clear();
      likes.clear();
      shareLink.clear();
      imageURS.clear();
      userLike.clear();

      for (var imageData in imageList.data!) {
        print('User ID: ${imageData.id},  image: ${imageData.image}');
        imageURS.add(imageData.image ?? '');
        name.add(imageData.name ?? '');
        caption.add(imageData.caption ?? '');
        ID.add(imageData.id ?? '');
        likes.add(imageData.likes ?? '');
        shareLink.add(imageData.shareLink ?? '');
        userLike.add(imageData.userLike ?? '');
        update();
      }
      update();
    } catch (e) {
      debugPrint("imageListData errors: $e");
    }
  }

  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constant.ID);
  }

  Future<void> likeAPI(String userId, String postId) async {
    try {

      final value = await shortsVideoRepo.likeAPI(userId, postId);
      var responseData = value.body;
      LikeData likeData = LikeData.fromJson(responseData);
      debugPrint("===> likeData: $likeData");
      debugPrint("===> likeData message: ${likeData.message}");
    } catch (e) {
      debugPrint("shortsVideoData errors: $e");
    }
  }

  Future<void> purchaseAPI(String userId) async {
    try {
      final value = await shortsVideoRepo.purchaseAPI(userId);
      var responseData = value.body;
      PurchaseData purchaseData = PurchaseData.fromJson(responseData);
      debugPrint("===> likeData message: ${purchaseData.message}");
    } catch (e) {
      debugPrint("purchaseAPI errors: $e");
    }
  }

  Future<void> offerAPI(String userId) async {
    try {
      final value = await shortsVideoRepo.offerAPI(userId);
      var responseData = value.body;
      OfferList offerList = OfferList.fromJson(responseData);
      debugPrint("===> offerList message: ${offerList.message}");
      for (var offerData in offerList.data!) {
        print('User ID: ${offerData.id},  image: ${offerData.image}');
        offerImageURS.value = offerData.image ?? '';
      }
    } catch (e) {
      debugPrint("offerAPI errors: $e");
    }
  }


  Future<void> postMyPost(String userId, XFile image) async {
    try {
      File imageFile = File(image.path);
      final value = await shortsVideoRepo.postMyPost(userId, imageFile);
      debugPrint("===> value: $value");
      var responseData = value.body;

      if (responseData == null || responseData is! Map<String, dynamic>) {
        Get.snackbar(
          "Oops",
          "Invalid server response",
          duration: const Duration(seconds: 3),
          colorText: Colors.white,
        );
        // Get.snackbar("Oops", "Invalid server response");
        debugPrint("Invalid server response: $responseData");
        return;
      }

      // Process the response
      UploadImage uploadImage = UploadImage.fromJson(responseData);
      debugPrint("===> uploadImage: $uploadImage");

      Get.snackbar(
        "Success",
        "${uploadImage.message}",
        duration: const Duration(seconds: 3),
        colorText: Colors.white,
      );
      // Get.snackbar("Success", "${uploadImage.message}");
    } catch (e) {
      Get.snackbar(
        "Oops",
        "Your image is not uploaded",
        duration: const Duration(seconds: 3),
        colorText: Colors.white,
      );
      // Get.snackbar("Oops", "Your image is not uploaded");
      debugPrint("postMyPost errors: $e");
    }
  }



  Future<void> gallery() async {
    ImagePicker picker = ImagePicker();
    XFile? getPic = await picker.pickImage(source: ImageSource.gallery);

    if (getPic != null) {
      print("get pic ${getPic.path}, ${getPic.name}");
      photo.value = getPic; // Set the photo
      print("get pic ${getPic.path}");
    }
    update();
  }



  void updateAPI(int i) {
    if (videoPlayerControllers[_api] != null) {
      videoPlayerControllers[_api]!.pause();
    }
    _api = i;
    update();
  }

  Future initializePlayer(int i) async {
    // print('initializing $i');
    late VideoPlayerController singleVideoController;
    singleVideoController = VideoPlayerController.network(videoURL[i]);
    videoPlayerControllers.add(singleVideoController);
    initilizedIndexes.add(i);
    await videoPlayerControllers[i]!.initialize();
    update();
  }

  Future initializeIndexedController(int index) async {
    late VideoPlayerController singleVideoController;
    singleVideoController = VideoPlayerController.network(videoURL[index]);
    videoPlayerControllers[index] = singleVideoController;
    await videoPlayerControllers[index]!.initialize();
    update();
  }

  Future disposeController(int i) async {
    if (videoPlayerControllers[i] != null) {
      await videoPlayerControllers[i]!.dispose();
      videoPlayerControllers[i] = null;
    }
  }

  final List<String> videoURLs = [
    'https://assets.mixkit.co/videos/preview/mixkit-young-mother-with-her-little-daughter-decorating-a-christmas-tree-39745-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-mother-with-her-little-daughter-eating-a-marshmallow-in-nature-39764-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-taking-photos-from-different-angles-of-a-model-34421-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-girl-in-neon-sign-1232-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-winter-fashion-cold-looking-woman-concept-video-39874-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-womans-feet-splashing-in-the-pool-1261-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4'
  ];

  void incrementCounter() {
      counter++;
      update();
  }
}