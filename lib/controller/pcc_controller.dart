
import 'package:color_challenge/data/api/api_client.dart';
import 'package:color_challenge/data/repository/shorts_video_repo.dart';
import 'package:color_challenge/model/post_list.dart';
import 'package:color_challenge/model/video_list.dart';
import 'package:color_challenge/util/Constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class PCC extends GetxController implements GetxService {
  final ShortsVideoRepo shortsVideoRepo;
  PCC({required this.shortsVideoRepo});
  int _api = 0;
  List<VideoPlayerController?> videoPlayerControllers = [];
  List<int> initilizedIndexes = [];
  bool autoplay = true;
  int get api => _api;
  RxInt counter = 0.obs;
  final RxList videoURL = [].obs;
  final RxList imageURS = [].obs;
  final RxList name = [].obs;
  final RxList description = [].obs;
  final RxList ID = [].obs;
  final RxList likes = [].obs;
  RxBool isLiked = false.obs;

  void toggleLike() {
    isLiked.toggle();
    debugPrint("isLiked: $isLiked");

    // Check the value of isLiked
    if (isLiked.value) {
      // Do something if isLiked is true
      debugPrint('Post is liked');
    } else {
      // Do something if isLiked is false
      debugPrint('Post is not liked');
    }

    update();
  }

  @override
  void onInit() {
    super.onInit();
    // shortsVideoData();
    imageListData();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> shortsVideoData() async {
    try {
      final value = await shortsVideoRepo.shortsVideoList();
      var responseData = value.body;
      VideoList shortVideoListData = VideoList.fromJson(responseData);
      debugPrint("===> shortVideoListData: $shortVideoListData");

      for (var videoData in shortVideoListData.data!) {
        print('Video ID: ${videoData.id}, User ID: ${videoData.userId}, URL: ${videoData.url}');
        videoURL.add(videoData.url ?? '');
      }
    } catch (e) {
      debugPrint("shortsVideoData errors: $e");
    }
  }

  Future<void> imageListData() async {
    try {
      final value = await shortsVideoRepo.imageListData();
      var responseData = value.body;
      PostList imageList = PostList.fromJson(responseData);
      debugPrint("===> shortVideoListData: $imageList");

      for (var imageData in imageList.data!) {
        print('User ID: ${imageData.id},  image: ${imageData.image}');
        imageURS.add(imageData.image ?? '');
        name.add(imageData.name ?? '');
        description.add(imageData.description ?? '');
        ID.add(imageData.id ?? '');
        likes.add(imageData.likes ?? '');
      }
    } catch (e) {
      debugPrint("shortsVideoData errors: $e");
    }
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