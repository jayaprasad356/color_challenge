import 'dart:convert';
import 'dart:io';

import 'package:a1_ads/data/api/api_client.dart';
import 'package:a1_ads/data/repository/home_repo.dart';
import 'package:a1_ads/data/repository/shorts_video_repo.dart';
import 'package:a1_ads/model/category_json_file.dart';
import 'package:a1_ads/model/category_list_mod.dart';
import 'package:a1_ads/model/order_json.dart';
import 'package:a1_ads/model/order_list.dart';
import 'package:a1_ads/model/place_order.dart';
import 'package:a1_ads/model/product_json_file.dart';
import 'package:a1_ads/model/product_list_mod.dart';
import 'package:a1_ads/model/recharge_history.dart';
import 'package:a1_ads/model/recharge_history_json.dart';
import 'package:a1_ads/model/recharge_mod.dart';
import 'package:a1_ads/model/scratch_card_data.dart';
import 'package:a1_ads/model/scratch_card_json.dart';
import 'package:a1_ads/model/settings_data.dart';
import 'package:a1_ads/model/slider_data.dart';
import 'package:a1_ads/model/upload_status.dart';
import 'package:a1_ads/model/video_list.dart';
import 'package:a1_ads/model/whatsapp_list.dart';
import 'package:a1_ads/model/whatsapp_list_json.dart';
import 'package:a1_ads/util/Color.dart';
import 'package:a1_ads/util/Constant.dart';
import 'package:a1_ads/view/screens/login/recharge_screen.dart';
import 'package:a1_ads/view/screens/upi_screen/whatsapp_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class SliderItem {
  final String imageUrl;

  SliderItem(this.imageUrl);
}

class HomeController extends GetxController implements GetxService {
  final HomeRepo homeRepo;
  HomeController({required this.homeRepo}){
    SharedPreferences.getInstance().then((value) {
      prefs = value;
    });
  }
  late SharedPreferences prefs;
  final RxList sliderImageURL = [].obs;
  final RxList sliderName = [].obs;
  final RxList sliderItems = [].obs;
  final RxInt currentIndex = 0.obs;
  final RxString a1JobDetailsURS = ''.obs;
  final RxString a1JobVideoURS = ''.obs;
  final RxString a1PurchaseURS = ''.obs;
  final RxString a2JobDetailsURS = ''.obs;
  final RxString a2JobVideoURS = ''.obs;
  final RxString a2PurchaseURS = ''.obs;
  final RxString watchAdStatus = ''.obs;
  final RxString rewardAdsDetails = ''.obs;
  final RxString referBonus = ''.obs;
  final RxString scratchCardDataDataID = ''.obs;
  final RxString scratchCardDataDataUserId = ''.obs;
  final RxString scratchCardDataDataAmount = ''.obs;
  final RxString scratchCardDataDataStatus = ''.obs;
  final RxString scratchCardDataDataMessage = ''.obs;
  final RxBool scratchCardDataDataSuccess = false.obs;

  RxList<CategoryJson> categoryJson = <CategoryJson>[].obs;
  RxList<ProductJson> productJson = <ProductJson>[].obs;
  RxList<OrderJson> ordersJson = <OrderJson>[].obs;
  RxList<ScratchCardJson> scratchCardJson = <ScratchCardJson>[].obs;
  RxList<WhatsappListJson> whatsappListJson = <WhatsappListJson>[].obs;
  RxList<RechargeHistoryJson> rechargeHistoryJson = <RechargeHistoryJson>[].obs;

  final List<String> sliderAssetsImage = [
    'assets/images/Group 18196.png',
    'assets/images/Group 18196.png',
    'assets/images/Group 18196.png',
  ];

  final List<List<String>> categoryList = [
    ['assets/images/categoryList1.png','Mobile'],
    ['assets/images/categoryList2.png','Ear\nPods'],
    ['assets/images/categoryList3.png','Watch'],
    ['assets/images/categoryList4.png','Power\nBank'],
    ['assets/images/categoryList5.png','Laptop'],
  ];

  final List<List<String>> productList = [
    ['assets/images/product1.png','Redmi Note 4','₹ 894','₹ 2499','50% OFF','Pending','23-Dec-2023'],
    ['assets/images/produt2.png','Apple Watch - series 6','₹ 894','₹ 2499','50% OFF','Completed','23-Dec-2023'],
    ['assets/images/produt2.png','Apple Watch - series 5','₹ 894','₹ 2499','50% OFF','Completed','23-Dec-2023'],
    ['assets/images/produt2.png','Apple Watch - series 4','₹ 894','₹ 2499','50% OFF','Completed','23-Dec-2023'],
  ];

  @override
  void onInit() {
    super.onInit();
    // allSettingsData();
    // shortsVideoData();
    // getUserId();
  }

  // @override
  // void onInit() async {
  //   super.onInit();
  //   prefs = await SharedPreferences.getInstance();
  //   slideList(prefs.getString(Constant.ID));
  //   // allSettingsData();
  //   // String? userId = await getUserId();
  //   // slideList(userId);
  // }

  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constant.ID);
  }

  Future<String?> getIpAddress() async {
    final response = await http.get(Uri.parse('https://admin.colorjobs.site/'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load IP address');
    }
  }

  Future<void> allSettingsData() async {
    try {
      final value = await homeRepo.allSettingsList();
      var responseData = value.body;
      SettingData settingData = SettingData.fromJson(responseData);
      debugPrint("===> settingData: $settingData");
      debugPrint("===> settingData message: ${settingData.message}");

      for (var settingsData in settingData.data!) {
        print(
            'User ID: ${settingsData.id},\na1jobVideo: ${settingsData.a1JobVideo},\na1jobDetails: ${settingsData.a1JobDetails},\na1PurchaseLink: ${settingsData.a1PurchaseLink},\na2jobVideo: ${settingsData.a2JobVideo},\na2jobDetails: ${settingsData.a2JobDetails},\na2PurchaseLink: ${settingsData.a2PurchaseLink},\nwatchAdStatus: ${settingsData.watchAdStatus}');
        a1JobDetailsURS.value = settingsData.a1JobDetails ?? '';
        a1JobVideoURS.value = settingsData.a1JobVideo ?? '';
        a1PurchaseURS.value = settingsData.a1PurchaseLink ?? '';
        a2JobDetailsURS.value = settingsData.a2JobDetails ?? '';
        a2JobVideoURS.value = settingsData.a2JobVideo ?? '';
        a2PurchaseURS.value = settingsData.a2PurchaseLink ?? '';
        watchAdStatus.value = settingsData.watchAdStatus ?? '';
        rewardAdsDetails.value = settingsData.rewardAdsDetails ?? '';
        referBonus.value = settingsData.referBonus ?? '';
      }
    } catch (e) {
      debugPrint("shortsVideoData errors: $e");
    }
  }

  Future<void> uploadStatus(context, String noOfView, XFile image) async {
    try {
      File imageFile = File(image.path);
      debugPrint("===> imageFile: $imageFile");
      final value = await homeRepo.uploadStatus( prefs.getString(Constant.ID)!, noOfView, imageFile);
      debugPrint("===> value: $value");

      if (value == null || value.body == null) {
        Get.snackbar(
          "Oops",
          "Invalid server response",
          duration: const Duration(seconds: 3),
          colorText: colors.primary_color,
          backgroundColor: Colors.white,
        );
        debugPrint("Invalid server response: $value");
        return;
      }

      var responseData = value.body;
      debugPrint("===> responseData: $responseData");

      // Process the response
      if (responseData is Map<String, dynamic>) {
        UploadStatus uploadStatus = UploadStatus.fromJson(responseData);
        debugPrint("===> uploadStatus: ${uploadStatus.success}");
        debugPrint("===> uploadStatus: ${uploadStatus.message}");

        Get.snackbar(
          uploadStatus.success.toString(),
          "${uploadStatus.message}",
          duration: const Duration(seconds: 3),
          colorText: colors.primary_color,
          backgroundColor: Colors.white,
        );

        if(uploadStatus.success.toString() == 'true'){
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const WhatsappStatus()),
          );
        }
      } else {
        Get.snackbar(
          "Oops",
          "Invalid server response format",
          duration: const Duration(seconds: 3),
          colorText: colors.primary_color,
          backgroundColor: Colors.white,
        );
        debugPrint("Invalid server response format: $responseData");
      }
    } catch (e) {
      Get.snackbar(
        "Oops",
        "Your image is not uploaded",
        duration: const Duration(seconds: 3),
        colorText: colors.primary_color,
        backgroundColor: Colors.white,
      );
      debugPrint("jobsUpload errors: $e");
    }
  }

  Future<void> uploadRechargePhoto(context, XFile image) async {
    try {
      File imageFile = File(image.path);
      debugPrint("===> imageFile: $imageFile");
      final value = await homeRepo.uploadRechargePhoto( prefs.getString(Constant.ID)!, imageFile);
      debugPrint("===> value: $value");

      if (value == null || value.body == null) {
        Get.snackbar(
          "Oops",
          "Invalid server response",
          duration: const Duration(seconds: 3),
          colorText: colors.primary_color,
          backgroundColor: Colors.white,
        );
        debugPrint("Invalid server response: $value");
        return;
      }

      var responseData = value.body;
      debugPrint("===> responseData: $responseData");

      // Process the response
      if (responseData is Map<String, dynamic>) {
        RechargeMod rechargeMod = RechargeMod.fromJson(responseData);
        debugPrint("===> rechargeMod: ${rechargeMod.success}");
        debugPrint("===> rechargeMod: ${rechargeMod.message}");

        Get.snackbar(
          rechargeMod.success.toString(),
          rechargeMod.message.toString(),
          duration: const Duration(seconds: 3),
          colorText: colors.primary_color,
          backgroundColor: Colors.white,
        );

        if(rechargeMod.success.toString() == 'true'){
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const RechargeScreen()),
          );
        }
      } else {
        Get.snackbar(
          "Oops",
          "Invalid server response format",
          duration: const Duration(seconds: 3),
          colorText: colors.primary_color,
          backgroundColor: Colors.white,
        );
        debugPrint("Invalid server response format: $responseData");
      }
    } catch (e) {
      Get.snackbar(
        "Oops",
        "Your image is not uploaded",
        duration: const Duration(seconds: 3),
        colorText: colors.primary_color,
        backgroundColor: Colors.white,
      );
      debugPrint("rechargeMod errors: $e");
    }
  }

  Future<void> rechargeHistory() async {
    try {
      final value = await homeRepo.rechargeHistory(prefs.getString(Constant.ID)!);
      var responseData = value.body;
      RechargeHistory rechargeHistory = RechargeHistory.fromJson(responseData);
      debugPrint("===> RechargeHistory: $rechargeHistory");
      debugPrint("===> RechargeHistory message: ${rechargeHistory.message}");

      rechargeHistoryJson.clear();

      if (rechargeHistory.data != null && rechargeHistory.data!.isNotEmpty) {
        // Use a loop if there can be multiple transactions
        for (var rechargeHistoryData in rechargeHistory.data!) {

          // Create a TransactionData object and add it to the list
          RechargeHistoryJson data = RechargeHistoryJson(
            rechargeHistoryData.id!,
            rechargeHistoryData.userId!,
            rechargeHistoryData.image!,
            rechargeHistoryData.rechargeAmount!,
            rechargeHistoryData.status!,
            rechargeHistoryData.datetime!,
          );

          rechargeHistoryJson.add(data);
        }
        update();
      }

    } catch (e) {
      debugPrint("whatsappList errors: $e");
    }
  }

  Future<void> whatsappListData() async {
    try {
      final value = await homeRepo.whatsappList('9462');
      var responseData = value.body;
      WhatsappList whatsappList = WhatsappList.fromJson(responseData);
      debugPrint("===> whatsappList: $whatsappList");
      debugPrint("===> whatsappList message: ${whatsappList.message}");

      whatsappListJson.clear();

      if (whatsappList.data != null && whatsappList.data!.isNotEmpty) {
        // Use a loop if there can be multiple transactions
        for (var whatsappListData in whatsappList.data!) {
          var whatsappListDataId = whatsappListData.id!;
          var whatsappListDataUserId = whatsappListData.userId!;
          var whatsappListDataImage = whatsappListData.image!;
          var whatsappListNoOfViews = whatsappListData.noOfViews!;
          var whatsappListDataStatus = whatsappListData.status!;
          var whatsappListDataDatetime = whatsappListData.datetime!;

          // Create a TransactionData object and add it to the list
          WhatsappListJson data = WhatsappListJson(
            whatsappListDataId,
              whatsappListDataUserId,
              whatsappListDataImage,
              whatsappListNoOfViews,
              whatsappListDataStatus,
              whatsappListDataDatetime,
          );

          whatsappListJson.add(data);
        }
        update();
      }

    } catch (e) {
      debugPrint("whatsappList errors: $e");
    }
  }

  Future<void> slideList(userId) async {
    try {
      final value = await homeRepo.sliderList(userId);
      var responseData = value.body;
      SliderDataItem sliderData = SliderDataItem.fromJson(responseData);
      debugPrint("===> sliderData: $sliderData");
      debugPrint("===> sliderData message: ${sliderData.message}");

      // Clear the existing data before adding new data
      sliderImageURL.clear();
      sliderName.clear();

      for (var slideData in sliderData.data!) {
        print('User ID: ${slideData.id},  image: ${slideData.image}');
        sliderImageURL.add(slideData.image ?? '');
        sliderName.add(slideData.name ?? '');
      }
    } catch (e) {
      debugPrint("shortsVideoData errors: $e");
    }
  }

  Future<void> categoryListData() async {
    try {
      final value = await homeRepo.categoryListData();
      var responseData = value.body;
      CategoryList categoryList = CategoryList.fromJson(responseData);
      debugPrint("===> categoryList: $categoryList");
      debugPrint("===> categoryList message: ${categoryList.message}");

      categoryJson.clear();

      if (categoryList.data != null && categoryList.data!.isNotEmpty) {
        // Use a loop if there can be multiple transactions
        for (var categoryData in categoryList.data!) {
          debugPrint("categoryData.image: ${categoryData.image}");
          var categoryDataID = categoryData.id!;
          var categoryDataName = categoryData.name!;
          var categoryDataStatus = categoryData.status!;
          var categoryDataImage = categoryData.image!;

          // Create a TransactionData object and add it to the list
          CategoryJson data = CategoryJson(
            categoryDataID,
            categoryDataName,
            categoryDataStatus,
            categoryDataImage,
          );

          categoryJson.add(data);
        }

        update();
      }
    } catch (e) {
      debugPrint("categoryList errors: $e");
    }
  }

  Future<void> myOrderListData() async {
    try {
      final value = await homeRepo.myOrderListData(prefs.getString(Constant.ID)!);
      var responseData = value.body;
      OrdersList ordersList = OrdersList.fromJson(responseData);
      debugPrint("===> ordersList: $ordersList");
      debugPrint("===> ordersList message: ${ordersList.message}");

      ordersJson.clear();

      if (ordersList.data != null && ordersList.data!.isNotEmpty) {
        // Use a loop if there can be multiple transactions
        for (var ordersListData in ordersList.data!) {
          debugPrint("===> ordersListData: $ordersListData");
          var ordersListDataID = ordersListData.productId!;
          var ordersListDataName = ordersListData.name!;
          var ordersListDataImage = ordersListData.image!;
          var ordersListDataDescription = ordersListData.description!;
          var ordersListDataCategoryId = ordersListData.categoryId!;
          var ordersListDataAds = ordersListData.ads!;
          var ordersListDataOriginalPrice = ordersListData.originalPrice!;
          var ordersListDataDeliveryDate = ordersListData.deliveryDate! == null ? '0' : ordersListData.deliveryDate!;
          var ordersListDataStatus = ordersListData.status!;
          debugPrint("===> ordersListDataID: $ordersListDataID\n$ordersListDataName\n$ordersListDataImage\n$ordersListDataDescription\n$ordersListDataCategoryId\n$ordersListDataAds\n$ordersListDataOriginalPrice\n");
          debugPrint("===> ordersListData.deliveryDate: $ordersListDataDeliveryDate");

          // Create a TransactionData object and add it to the list
          OrderJson data = OrderJson(
            ordersListDataID,
            ordersListDataName,
            ordersListDataImage,
            ordersListDataDescription,
            ordersListDataCategoryId,
            ordersListDataAds,
            ordersListDataOriginalPrice,
            ordersListDataDeliveryDate,
            ordersListDataStatus,
          );

          ordersJson.add(data);
        }

        update();
      }
    } catch (e) {
      debugPrint("ordersList errors: $e");
    }
  }

  Future<void> productListData(categoryId) async {
    try {
      final value = await homeRepo.productListData(categoryId);
      var responseData = value.body;
      ProductList productList = ProductList.fromJson(responseData);
      debugPrint("===> productList: $productList");
      debugPrint("===> productList message: ${productList.message}");

      productJson.clear();

      if (productList.data != null && productList.data!.isNotEmpty) {
        // Use a loop if there can be multiple transactions
        for (var productData in productList.data!) {
          debugPrint("productData.image: ${productData.image}");
          var productDataID = productData.id!;
          var productDataName = productData.name!;
          var productDataImage = productData.image!;
          var productDataDescription = productData.description!;
          var productDataCategoryId = productData.categoryId!;
          var productDataAds = productData.ads!;
          var productDataOriginalPrice = productData.originalPrice!;
          var productDataStatus = productData.status!;

          // Create a TransactionData object and add it to the list
          ProductJson data = ProductJson(
            productDataID,
            productDataName,
            productDataImage,
            productDataDescription,
            productDataCategoryId,
            productDataAds,
            productDataOriginalPrice,
            productDataStatus,
          );

          productJson.add(data);
        }

        update();
      }
    } catch (e) {
      debugPrint("productJson errors: $e");
    }
  }

  Future<void> placeOrder(productId, address, pinCode) async {
    try {
      debugPrint("prefs.getString(Constant.ID)!: {prefs.getString(Constant.ID)!},widget.productId: $productId, addressController.text: $address, pinCondeController.text: $pinCode");
      final value = await homeRepo.placeOrder(prefs.getString(Constant.ID)!, productId, address, pinCode);
      var responseData = value.body;
      PlaceOrder placeOrder = PlaceOrder.fromJson(responseData);
      debugPrint("===> placeOrder: $placeOrder");
      debugPrint("===> placeOrder message: ${placeOrder.message}");
      if(placeOrder.success.toString() == 'true'){
        Get.back();
      }
      Get.snackbar('Place Order', placeOrder.message.toString(),colorText: colors.primary,backgroundColor: Colors.white,duration: const Duration(seconds: 3),);
    } catch (e) {
      debugPrint("placeOrder errors: $e");
    }
  }

  Future<void> scratchCard() async {
    try {
      final value = await homeRepo.scratchCard(prefs.getString(Constant.ID)!);
      var responseData = value.body;
      ScratchCardData scratchCardData = ScratchCardData.fromJson(responseData);
      debugPrint("===> scratchCardData: $scratchCardData");
      debugPrint("===> scratchCardData message: ${scratchCardData.message}");
      scratchCardDataDataMessage.value = scratchCardData.message!;
      scratchCardDataDataSuccess.value = scratchCardData.success!;
      // if(placeOrder.success.toString() == 'true'){
      //   Get.back();
      // }
      // Get.snackbar('Place Order', placeOrder.message.toString(),colorText: colors.primary,backgroundColor: Colors.white,duration: const Duration(seconds: 3),);

      scratchCardJson.clear();

      if (scratchCardData.data != null && scratchCardData.data!.isNotEmpty) {
        // Use a loop if there can be multiple transactions
        for (var scratchCardDataData in scratchCardData.data!) {
          scratchCardDataDataID.value = scratchCardDataData.id!;
          scratchCardDataDataUserId.value = scratchCardDataData.userId!;
          scratchCardDataDataAmount.value = scratchCardDataData.amount!;
          scratchCardDataDataStatus.value = scratchCardDataData.status!;

          // // Create a TransactionData object and add it to the list
          // ScratchCardJson data = ScratchCardJson(
          //   scratchCardDataDataScratchCard,
          // );
          //
          // scratchCardJson.add(data);
        }

        update();
      }
    } catch (e) {
      debugPrint("scratchCardData errors: $e");
    }
  }
}
