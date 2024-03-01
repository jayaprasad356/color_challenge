import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:a1_ads/controller/pcc_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:a1_ads/Helper/apiCall.dart';
import 'package:a1_ads/controller/full_time_page_con.dart';
import 'package:a1_ads/controller/home_controller.dart';
import 'package:a1_ads/model/slider_data.dart';
import 'package:a1_ads/model/user.dart';
import 'package:a1_ads/controller/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../util/Color.dart';
import '../../../util/Constant.dart';
import 'package:slide_action/slide_action.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class A1UAds extends StatefulWidget {
  const A1UAds({Key? key}) : super(key: key);

  @override
  State<A1UAds> createState() => A1UAdsState();
}

class A1UAdsState extends State<A1UAds> {
  final FullTimePageCont fullTimePageCont = Get.find<FullTimePageCont>();
  final HomeController homeController = Get.find<HomeController>();
  final PCC c = Get.find<PCC>();
  late SharedPreferences prefs;
  double starttime = 0; // Set the progress value between 0.0 and 1.0 here
  String today_ads_remain = "0";
  String level = '0', status = '';
  String history_days = '0';
  String ads_image = 'https://admin.colorjobs.site/dist/img/logo.jpeg';
  String ads_link = '';
  int time_start = 0;
  double seconds = 0.0;
  String time_left = '0';
  String max_coin = "0";
  String refer_amount = "0";
  String generate_coin = "0";
  bool _isLoading = true;
  String balance = "0";
  String storeBalance = "0";
  String ads_cost = "0";
  bool timerStarted = false;
  bool isTrial = true, isPremium = false;
  Random random = Random();
  late String contact_us;
  final TextEditingController _serialController = TextEditingController();
  String serilarandom = "",
      basic_wallet = "",
      // premium_wallet = "",
      target_refers = "",
      total_refers = "",
      today_earn = "",
      today_ads = "0",
      total_ads = "0",
      reward_ads = "0",
      ads_time = "0";
  double progressbar = 0.0;
  late String image = "", referText = "", offer_image = "", refer_bonus = "";
  int adsCount = 0;
  int rewardAds = 0;
  double progressPercentage = 0.0;
  double progressPercentageTwo = 0.0;
  late bool isButtonDisabled;
  late bool isClaimButtonDisabled;
  late String generatedOtp;
  late String syncType;
  int syncUniqueId = 1;
  double multiplyCostValue = 0;
  double maximumValue = 120.0;
  double currentValue = 60.0;
  double progressPercentage1 = 0.00;
  late String isWeb;
  late String platformType;
  bool isButtonEnabled = true; // Initially, the button is enabled.
  bool skipAdButton = true; // Initially, the button is enabled.
  Timer? buttonTimer;
  int countdown = 5;
  late Timer timer;
  late Timer timerWatchAd;
  String name = "";
  String mobile_number = "";
  String todayAdsStatus = "";
  String gender = "male";

  @override
  void initState() {
    super.initState();
    handleAsyncInit();
    progressPercentage1 = currentValue / maximumValue;

    isButtonDisabled = true;
    isClaimButtonDisabled = true;

    // // Initialize focus nodes and controllers
    // focusNodes = List.generate(4, (index) => FocusNode());
    // controllers = List.generate(4, (index) => TextEditingController());

    SharedPreferences.getInstance().then((value) {
      prefs = value;
      debugPrint("ads_time gender");
      ads_time = prefs.getString(Constant.ADS_TIME)!;
      debugPrint("ads_time gender: $ads_time");
      balance = prefs.getString(Constant.BALANCE)!;
      debugPrint("balance gender: $balance");
      today_ads = prefs.getString(Constant.TODAY_ADS)!;
      debugPrint("today_ads gender: $today_ads");
      total_ads = prefs.getString(Constant.TOTAL_ADS)!;
      debugPrint("total_ads gender: $total_ads");
      ads_cost = prefs.getString(Constant.ADS_COST)!;
      debugPrint("ads_cost gender: $ads_cost");
      referText = prefs.getString(Constant.REFER_CODE)!;
      debugPrint("referText gender: $referText");
      reward_ads = prefs.getString(Constant.REWARD_ADS)!;
      debugPrint("reward_ads gender: $reward_ads");
      storeBalance = prefs.getString(Constant.STORE_BALANCE)!;
      debugPrint("storeBalance gender: $storeBalance");
      name = prefs.getString(Constant.NAME)!;
      debugPrint("name gender: $name");
      mobile_number = prefs.getString(Constant.MOBILE)!;
      debugPrint("mobile_number gender: $mobile_number");
      target_refers = prefs.getString(Constant.TARGET_REFERS)!;
      debugPrint("target_refers gender: $target_refers");
      total_refers = prefs.getString(Constant.TOTAL_REFERS)!;
      debugPrint("total_refers gender: $total_refers");
      today_earn = prefs.getString(Constant.TODAY_EARN)!;
      debugPrint("today_earn gender: $today_earn");
      gender = prefs.getString(Constant.GENDER)!;
      debugPrint("gender : $gender");
      debugPrint("total_refers : $total_refers");
      todayAdsStatus = prefs.getString(Constant.TODAY_ADS_STATUS)!;
      c.offerAPI(prefs.getString(Constant.ID)!);
      debugPrint("todayAdsStatus : $todayAdsStatus");
      // setState(() {
      //   ads_time = prefs.getString(Constant.ADS_TIME)!;
      //   balance = prefs.getString(Constant.BALANCE)!;
      //   today_ads = prefs.getString(Constant.TOTAL_ADS)!;
      //   total_ads = prefs.getString(Constant.TOTAL_ADS)!;
      //   ads_cost = prefs.getString(Constant.ADS_COST)!;
      //   referText = prefs.getString(Constant.REFER_CODE)!;
      //   refer_bonus = prefs.getString(Constant.REFER_BONUS)!;
      //   // adsApi();
      // });
      //ads_status("status");
    });

    loadTimerCount();
    // skipAdTimer();
    initializeData();

    // progressPercentageTwo = double.parse(reward_ads);
    // debugPrint("progressPercentageTwo : $progressPercentageTwo");
  }

  void initializeData() async {
    c.offerAPI(prefs.getString(Constant.ID)!);
    setState(() {});
  }

  void skipAdTimer() {
    setState(() {
      skipAdButton = true;
    });
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (countdown > 0) {
          countdown--;
        } else {
          timer.cancel();
          skipAdButton = false;
          // Implement code to navigate or perform an action after skipping ad
          print('Ad skipped!');
        }
      });
    });
    setState(() {
      countdown = 5;
    });
  }

  // @override
  // void dispose() {
  //   timer.cancel(); // Cancel the timer to avoid memory leaks
  //   super.dispose();
  // }

  void handleAsyncInit() async {
    setState(() async {
      isWeb = (await storeLocal.read(key: Constant.IS_WEB))!;
      debugPrint("isWeb: $isWeb");
      if (isWeb == 'true') {
        platformType = 'web';
      } else if (isWeb == 'true') {
        platformType = 'app';
      }
    });
  }

  // @override
  // void dispose() {
  //   // Dispose focus nodes and controllers
  //   for (var node in focusNodes) {
  //     node.dispose();
  //   }
  //   for (var controller in controllers) {
  //     controller.dispose();
  //   }
  //   super.dispose();
  // }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);

    // balance;
    // total_ads;
    // today_ads;
    // multiplyCostValue = multiplyCost(adsCount, ads_cost)!;
    if (adsCount < 120) {
      isButtonDisabled = true; // Disable the button
    } else if (adsCount >= 120) {
      isButtonDisabled = false; // Enable the button
    } else if (adsCount > 120) {
      progressPercentage = 0.0;
      isButtonDisabled = false; // Enable the button
      adsCount = 0;
    }
    rewardAds = int.parse(reward_ads);
    debugPrint("rewardAds : $rewardAds");
    progressPercentageTwo = double.parse(reward_ads) / maximumValue;
    debugPrint("progressPercentageTwo : $progressPercentageTwo");

    if (rewardAds < 120) {
      isClaimButtonDisabled = true; // Disable the button
    } else if (rewardAds >= 120) {
      syncUniqueId = fullTimePageCont.generateRandomSixDigitNumber();
      isClaimButtonDisabled = false; // Enable the button
    }
  }

  void startTimer() {
    // Example: Countdown from 100 to 0 with a 1-second interval
    const oneSec = Duration(seconds: 1);
    int adsTimeInSeconds = int.parse(ads_time);
    timerWatchAd = Timer.periodic(oneSec, (Timer timer) {
      if (starttime >= adsTimeInSeconds) {
        timer.cancel();
        setState(() {
          progressbar = 0.0;
          timerStarted = false;
          progressPercentage;
        });
        adsCount++;
        skipAdButton = true;
        print('timerCount called $adsCount times.');
        multiplyCostValue = adsCount * double.parse(ads_cost);
        setState(() {
          progressPercentage = (adsCount / maximumValue);
          debugPrint("timerCount: $adsCount");
          saveTimerCount(adsCount, multiplyCostValue);
          if (adsCount < 119) {
            isButtonDisabled = true; // Disable the button
          } else if (adsCount >= 119) {
            syncUniqueId = fullTimePageCont.generateRandomSixDigitNumber();
            debugPrint("syncUniqueId: $syncUniqueId");
            isButtonDisabled = true; // Disable the button
            // adsCount = 0;
          } else if (adsCount == 120) {
            isButtonDisabled = false; // Enable the button
            // adsCount = 0;
          } else if (adsCount > 120) {
            progressPercentage = 0.0;
            isButtonDisabled = false; // Enable the button
            adsCount = 0;
          }
        });
        // if (timerCount < 100) {
        //   isButtonDisabled = true; // Disable the button
        // } else if (timerCount >= 100) {
        //   syncUniqueId = fullTimePageCont.generateRandomSixDigitNumber();
        //   isButtonDisabled = false; // Enable the button
        //   // timerCount = 1;
        // }
      } else {
        setState(() {
          starttime++;
          seconds = starttime % adsTimeInSeconds;
          progressbar = starttime / adsTimeInSeconds;
        });
      }
    });
  }

  // Load timerCount from shared preferences
  void loadTimerCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      adsCount = prefs.getInt('timerCount') ?? 0;
      multiplyCostValue = adsCount * double.parse(ads_cost);
      progressPercentage = (adsCount / maximumValue);
    });
  }

  // Save timerCount to shared preferences
  void saveTimerCount(int count, double cost) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('timerCount', count);
    await prefs.setDouble('multiplyCostValueLocal', cost);
  }

  bool isMultipleOf5(int number) {
    return number % 5 == 0;
  }

  double? multiplyCost(int timerCount, String str2) {
    try {
      double num2 = double.parse(str2);
      return timerCount * num2;
    } catch (e) {
      print('Error: Unable to parse the input string as a number.');
      return null;
    }
  }

  String maskModelNumber(String modelNumber) {
    // Assuming you want to show the first two and last two digits
    String maskedNumber =
        '${modelNumber.substring(0, 2)}******${modelNumber.substring(modelNumber.length - 2)}';
    return maskedNumber;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String maskedNumber = maskModelNumber(mobile_number);
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Image.asset(
                    gender == 'male'
                        ? 'assets/images/Group 18201.png'
                        : 'assets/images/Group 18200.png',
                    height: size.height * 0.1,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name.toString(),
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontFamily: 'MontserratBold',
                          color: Color(0xFF242426),
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        maskedNumber,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontFamily: 'MontserratLight',
                          color: Color(0xFF242426),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  'https://cdn.dribbble.com/users/5297140/screenshots/13995496/media/14926154614bfc790f749c95649a7919.gif',
                  fit: BoxFit.fill,
                ),
              ),
              // child: Obx(
              //   () => c.offerImageURS.isNotEmpty
              //       ? Container(
              //           width: size.width,
              //           height: size.height * 0.6,
              //           decoration: BoxDecoration(
              //               color: Colors.transparent,
              //               borderRadius: BorderRadius.circular(16)),
              //           child: ClipRRect(
              //             borderRadius: BorderRadius.circular(16),
              //             child: Image.network(
              //               c.offerImageURS.toString(),
              //               fit: BoxFit.fill,
              //             ),
              //           ),
              //         )
              //       : const Center(
              //           child: SizedBox(
              //             height: 50.0,
              //             width: 50.0,
              //             child: CircularProgressIndicator(
              //               value: null,
              //               strokeWidth: 7.0,
              //             ),
              //           ),
              //         ),
              // ),
            ),
            // const SizedBox(
            //   height: 10,
            // ),
            // InkWell(
            //   onTap: () async {
            //     var imageUrl = c.offerImageURS.toString();
            //     debugPrint('imageUrl: $imageUrl');
            //     Share.share(imageUrl);
            //   },
            //   child: Container(
            //     width: size.width * 0.6,
            //     height: 40,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(5),
            //       color: const Color(0xFF00D95F),
            //     ),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Image.asset(
            //           "assets/images/whatsapp-icon-2048x2048-64wjztht 1.png",
            //           height: 30,
            //         ),
            //         const Text(
            //           'Share to Whatsapp',
            //           style: TextStyle(
            //             fontFamily: 'MontserratBold',
            //             color: Colors.white,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // InkWell(
            //   onTap: () {
            //     // fullTimePageCont.todayIncome(context);
            //     if (todayAdsStatus == '1') {
            //       fullTimePageCont.todayIncome(context);
            //     }
            //     // setState(() {
            //     //   ads_time = prefs.getString(Constant.ADS_TIME)!;
            //     //   balance = prefs.getString(Constant.BALANCE)!;
            //     //   today_ads = prefs.getString(Constant.TODAY_ADS)!;
            //     //   total_ads = prefs.getString(Constant.TOTAL_ADS)!;
            //     //   ads_cost = prefs.getString(Constant.ADS_COST)!;
            //     //   referText = prefs.getString(Constant.REFER_CODE)!;
            //     //   reward_ads = prefs.getString(Constant.REWARD_ADS)!;
            //     //   storeBalance = prefs.getString(Constant.STORE_BALANCE)!;
            //     //   name = prefs.getString(Constant.NAME)!;
            //     //   mobile_number = prefs.getString(Constant.MOBILE)!;
            //     //   target_refers = prefs.getString(Constant.TARGET_REFERS)!;
            //     //   gender = prefs.getString(Constant.GENDER)!;
            //     //   todayAdsStatus = prefs.getString(Constant.TODAY_ADS_STATUS)!;
            //     //   c.offerAPI(prefs.getString(Constant.ID)!);
            //     //   debugPrint("todayAdsStatus : $todayAdsStatus");
            //     // });
            //   },
            //   child: Container(
            //     height: 50,
            //     width: size.width * 0.55,
            //     decoration: todayAdsStatus == '1'
            //         ? BoxDecoration(
            //             gradient: LinearGradient(
            //               colors: [
            //                 Colors.teal,
            //                 Colors.teal.shade200,
            //               ],
            //               begin: Alignment.topLeft,
            //               end: Alignment.bottomRight,
            //             ),
            //             borderRadius: BorderRadius.circular(20),
            //             border: Border(
            //               bottom: BorderSide(
            //                 width: 2,
            //                 color: Colors.teal.shade700,
            //               ),
            //               right: BorderSide(
            //                 width: 2,
            //                 color: Colors.teal.shade700,
            //               ),
            //             ),
            //             boxShadow: const [
            //               BoxShadow(
            //                 color: Colors.black12,
            //                 offset: Offset(5, 5),
            //                 blurRadius: 10,
            //               )
            //             ],
            //           )
            //         : BoxDecoration(
            //             color: Colors.grey,
            //             borderRadius: BorderRadius.circular(20),
            //             border: Border(
            //               bottom: BorderSide(
            //                 width: 2,
            //                 color: Colors.grey.shade700,
            //               ),
            //               right: BorderSide(
            //                 width: 2,
            //                 color: Colors.grey.shade700,
            //               ),
            //             ),
            //             boxShadow: const [
            //               BoxShadow(
            //                 color: Colors.black12,
            //                 offset: Offset(5, 5),
            //                 blurRadius: 10,
            //               )
            //             ],
            //           ),
            //     child: const Center(
            //       child: Text(
            //         'Get MY TODAY ADS EARNINGS',
            //         style: TextStyle(
            //           fontFamily: 'MontserratLight',
            //           color: Color(0xFFFFFFFF),
            //           fontWeight: FontWeight.bold,
            //           fontSize: 14,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/Group 18199.png',
                    height: 24,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text(
                    "Ads activity performance",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'MontserratBold',
                      color: Color(0xFF242426),
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Container(
                height: size.height * 0.3,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFFE27E1C),
                          Color(0xFF851161),
                        ])),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Image.asset(
                        'assets/images/noto_money-with-wings.png',
                        height: 64,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Image.asset(
                        'assets/images/Group.png',
                        height: 34,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.1,
                          vertical: size.height * 0.05),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  const Text(
                                    "Today Income",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontFamily: 'MontserratLight',
                                      color: Color(0xFFFFFFFF),
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    today_earn,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      fontFamily: 'MontserratLight',
                                      color: Color(0xFF00FFFF),
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.05,
                                  ),
                                  const Text(
                                    "Total Referrals",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontFamily: 'MontserratLight',
                                      color: Color(0xFFFFFFFF),
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    total_refers,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      fontFamily: 'MontserratLight',
                                      color: Color(0xFF00FFFF),
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text(
                                    "Total Income",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontFamily: 'MontserratLight',
                                      color: Color(0xFFFFFFFF),
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    total_ads,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      fontFamily: 'MontserratLight',
                                      color: Color(0xFF00FFFF),
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.05,
                                  ),
                                  const Text(
                                    "Remaining Balance",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontFamily: 'MontserratLight',
                                      color: Color(0xFFFFFFFF),
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    "₹ $balance",
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      fontFamily: 'MontserratLight',
                                      color: Color(0xFF00FFFF),
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
            //   child: Container(
            //     height: size.height * 0.3,
            //     width: double.infinity,
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(10),
            //         gradient: const LinearGradient(
            //             begin: Alignment.topCenter,
            //             end: Alignment.bottomCenter,
            //             colors: [
            //               Color(0xFFE27E1C),
            //               Color(0xFF851161),
            //             ])),
            //     child: Stack(
            //       children: [
            //         Align(
            //           alignment: Alignment.centerRight,
            //           child: Image.asset(
            //             'assets/images/noto_money-with-wings.png',
            //             height: 64,
            //           ),
            //         ),
            //         Align(
            //           alignment: Alignment.bottomLeft,
            //           child: Image.asset(
            //             'assets/images/Group.png',
            //             height: 34,
            //           ),
            //         ),
            //         Padding(
            //           padding: EdgeInsets.symmetric(
            //               horizontal: size.width * 0.1,
            //               vertical: size.height * 0.05),
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 children: [
            //                   Column(
            //                     children: [
            //                       const Text(
            //                         "Today Ads",
            //                         textAlign: TextAlign.start,
            //                         style: TextStyle(
            //                           fontFamily: 'MontserratLight',
            //                           color: Color(0xFFFFFFFF),
            //                           fontSize: 16,
            //                         ),
            //                       ),
            //                       Text(
            //                         today_ads,
            //                         textAlign: TextAlign.start,
            //                         style: const TextStyle(
            //                           fontFamily: 'MontserratLight',
            //                           color: Color(0xFF00FFFF),
            //                           fontSize: 20,
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                   Column(
            //                     children: [
            //                       const Text(
            //                         "Total Ads",
            //                         textAlign: TextAlign.start,
            //                         style: TextStyle(
            //                           fontFamily: 'MontserratLight',
            //                           color: Color(0xFFFFFFFF),
            //                           fontSize: 16,
            //                         ),
            //                       ),
            //                       Text(
            //                         total_ads,
            //                         textAlign: TextAlign.start,
            //                         style: const TextStyle(
            //                           fontFamily: 'MontserratLight',
            //                           color: Color(0xFF00FFFF),
            //                           fontSize: 20,
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ],
            //               ),
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 children: [
            //                   Column(
            //                     children: [
            //                       const Text(
            //                         "Total Referrals",
            //                         textAlign: TextAlign.start,
            //                         style: TextStyle(
            //                           fontFamily: 'MontserratLight',
            //                           color: Color(0xFFFFFFFF),
            //                           fontSize: 16,
            //                         ),
            //                       ),
            //                       Text(
            //                         target_refers,
            //                         textAlign: TextAlign.start,
            //                         style: const TextStyle(
            //                           fontFamily: 'MontserratLight',
            //                           color: Color(0xFF00FFFF),
            //                           fontSize: 20,
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                   Column(
            //                     children: [
            //                       const Text(
            //                         "Total Balance",
            //                         textAlign: TextAlign.start,
            //                         style: TextStyle(
            //                           fontFamily: 'MontserratLight',
            //                           color: Color(0xFFFFFFFF),
            //                           fontSize: 16,
            //                         ),
            //                       ),
            //                       Text(
            //                         "₹ $balance",
            //                         textAlign: TextAlign.start,
            //                         style: const TextStyle(
            //                           fontFamily: 'MontserratLight',
            //                           color: Color(0xFF00FFFF),
            //                           fontSize: 20,
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ],
            //               ),
            //             ],
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> watchAds() async {
    prefs = await SharedPreferences.getInstance();

    var response = await dataCall(Constant.ADS_URL);

    String jsonDataString = response.toString();
    final jsonData = jsonDecode(jsonDataString);

    if (jsonData['success']) {
      // Utils().showToast(jsonData['message']);
      final dataList = jsonData['data'] as List;
      final datass = dataList.first;
      prefs.setString(Constant.ADS_LINK, datass[Constant.ADS_LINK]);
      prefs.setString(Constant.ADS_IMAGE, datass[Constant.ADS_IMAGE]);
      setState(() {
        ads_image = prefs.getString(Constant.ADS_IMAGE)!;
        ads_link = prefs.getString(Constant.ADS_LINK)!;
      });
      starttime = 0;
      timerStarted = true;
      startTimer();
      //userDeatils();
    } else {
      Utils().showToast(jsonData['message']);
    }
  }
}

class OtpInputField extends StatefulWidget {
  final String generatedOtp;
  final Function onPress;
  const OtpInputField(
      {super.key, required this.generatedOtp, required this.onPress});

  @override
  _OtpInputFieldState createState() => _OtpInputFieldState();
}

class _OtpInputFieldState extends State<OtpInputField> {
  TextEditingController otpController1 = TextEditingController();
  TextEditingController otpController2 = TextEditingController();
  TextEditingController otpController3 = TextEditingController();
  TextEditingController otpController4 = TextEditingController();
  bool isTimer = false;

  @override
  void dispose() {
    otpController1.dispose();
    otpController2.dispose();
    otpController3.dispose();
    otpController4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildOtpTextField(otpController1),
            buildOtpTextField(otpController2),
            buildOtpTextField(otpController3),
            buildOtpTextField(otpController4),
          ],
        ),
        const SizedBox(height: 20.0),
        Container(
          height: size.height * 0.1,
          decoration: const BoxDecoration(),
          alignment: Alignment.center,
          child: SlideAction(
            trackBuilder: (context, state) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    state.isPerformingAction ? "Loading..." : "Go To ADS",
                    style: const TextStyle(
                        color: colors.black,
                        fontSize: 14,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
            thumbBuilder: (context, state) {
              return Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: state.isPerformingAction
                      ? const CupertinoActivityIndicator(
                          color: Colors.white,
                        )
                      : const Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                        ),
                ),
              );
            },
            action: () async {
              isTimer = true;
              await Future.delayed(
                const Duration(seconds: 3),
                () {
                  if (otpController1.text.isNotEmpty &&
                      otpController2.text.isNotEmpty &&
                      otpController3.text.isNotEmpty &&
                      otpController2.text.isNotEmpty) {
                    debugPrint('otp is not empty');
                    if (mounted) {
                      String enteredOtp =
                          "${otpController1.text}${otpController2.text}${otpController3.text}${otpController4.text}";
                      widget.onPress(enteredOtp);
                      debugPrint("action completed");
                    }
                    debugPrint("action completed");
                    // watchAds();
                    setState(() {
                      isTimer = false;
                    });
                    Navigator.of(context).pop();
                  } else {
                    debugPrint('otp is empty');
                  }
                },
              );
            },
          ),
        ),
        // ElevatedButton(
        //   onPressed: () {
        //     String enteredOtp =
        //         "${otpController1.text}${otpController2.text}${otpController3.text}${otpController4.text}";
        //     widget.onPress(enteredOtp);
        //     //
        //     // if (enteredOtp == widget.generatedOtp) {
        //     //   print('OTP Matched');
        //     // } else {
        //     //   print('OTP Mismatch');
        //     // }
        //     // print('Entered OTP: ${otpController1.text}${otpController2.text}${otpController3.text}${otpController4.text}');
        //   },
        //   child: const Text('Submit'),
        // ),
      ],
    );
  }

  Widget buildOtpTextField(TextEditingController controller) {
    return Container(
      width: 50.0,
      height: 50.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2.0),
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 3),
      child: TextField(
        controller: controller,
        maxLength: 1,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 24.0),
        decoration: const InputDecoration(
          counterText: '',
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        onChanged: (value) {
          FocusScope.of(context).nextFocus();
        },
      ),
    );
  }
}
