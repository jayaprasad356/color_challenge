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

class FullTimePage extends StatefulWidget {
  const FullTimePage({Key? key}) : super(key: key);

  @override
  State<FullTimePage> createState() => FullTimePageState();
}

class FullTimePageState extends State<FullTimePage> {
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
      ads_time = prefs.getString(Constant.ADS_TIME)!;
      balance = prefs.getString(Constant.BALANCE)!;
      today_ads = prefs.getString(Constant.TODAY_ADS)!;
      total_ads = prefs.getString(Constant.TOTAL_ADS)!;
      ads_cost = prefs.getString(Constant.ADS_COST)!;
      referText = prefs.getString(Constant.REFER_CODE)!;
      reward_ads = prefs.getString(Constant.REWARD_ADS)!;
      storeBalance = prefs.getString(Constant.STORE_BALANCE)!;
      name = prefs.getString(Constant.NAME)!;
      mobile_number = prefs.getString(Constant.MOBILE)!;
      gender = prefs.getString(Constant.GENDER)!;
      c.offerAPI(prefs.getString(Constant.ID)!);
      debugPrint("ads_time : $ads_time");
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

    // progressPercentageTwo = double.parse(reward_ads);
    // debugPrint("progressPercentageTwo : $progressPercentageTwo");
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
  void setState(VoidCallback fn) async {
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

  String separateNumber(String number) {
    if (number.length != 12) {
      throw Exception("Number must be 12 digits long.");
    }

    List<String> groups = [];

    for (int i = 0; i < 12; i += 4) {
      groups.add(number.substring(i, i + 4));
    }

    return groups.join('-');
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
    // String maskedNumber = maskModelNumber(mobile_number);
    // return Scaffold(
    //   backgroundColor: const Color(0xFFF2F2F2),
    //   body: SingleChildScrollView(
    //     physics: const BouncingScrollPhysics(),
    //     child: Column(
    //       children: [
    //         const SizedBox(
    //           height: 10,
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 20.0),
    //           child: Row(
    //             children: [
    //               Image.asset(
    //                 gender == 'male'
    //                     ? 'assets/images/Group 18201.png'
    //                     : 'assets/images/Group 18200.png',
    //                 height: size.height * 0.1,
    //               ),
    //               const SizedBox(
    //                 width: 15,
    //               ),
    //               Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Text(
    //                     name.toString(),
    //                     textAlign: TextAlign.start,
    //                     style: const TextStyle(
    //                       fontFamily: 'MontserratBold',
    //                       color: Color(0xFF242426),
    //                       fontSize: 20,
    //                     ),
    //                   ),
    //                   const SizedBox(
    //                     height: 5,
    //                   ),
    //                   Text(
    //                     maskedNumber,
    //                     textAlign: TextAlign.start,
    //                     style: const TextStyle(
    //                       fontFamily: 'MontserratLight',
    //                       color: Color(0xFF242426),
    //                       fontSize: 16,
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ),
    //         const SizedBox(
    //           height: 10,
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 20.0),
    //           child: Obx(
    //             () => c.offerImageURS.isNotEmpty
    //                 ? Container(
    //                     width: size.width,
    //                     height: size.height * 0.3,
    //                     decoration: BoxDecoration(
    //                         color: Colors.transparent,
    //                         borderRadius: BorderRadius.circular(16)),
    //                     child: ClipRRect(
    //                       borderRadius: BorderRadius.circular(16),
    //                       child: Image.network(
    //                         c.offerImageURS.toString(),
    //                         fit: BoxFit.fill,
    //                       ),
    //                     ),
    //                   )
    //                 : const Center(
    //                     child: SizedBox(
    //                       height: 50.0,
    //                       width: 50.0,
    //                       child: CircularProgressIndicator(
    //                         value: null,
    //                         strokeWidth: 7.0,
    //                       ),
    //                     ),
    //                   ),
    //           ),
    //         ),
    //         const SizedBox(
    //           height: 10,
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 20.0),
    //           child: Row(
    //             children: [
    //               Image.asset(
    //                 'assets/images/Group 18199.png',
    //                 height: 24,
    //               ),
    //               const SizedBox(
    //                 width: 15,
    //               ),
    //               const Text(
    //                 "Ads activity performance",
    //                 textAlign: TextAlign.start,
    //                 style: TextStyle(
    //                   fontFamily: 'MontserratBold',
    //                   color: Color(0xFF242426),
    //                   fontSize: 20,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         const SizedBox(
    //           height: 10,
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 20.0),
    //           child: Container(
    //             height: size.height * 0.3,
    //             width: double.infinity,
    //             decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(10),
    //                 gradient: const LinearGradient(
    //                     begin: Alignment.topCenter,
    //                     end: Alignment.bottomCenter,
    //                     colors: [
    //                       Color(0xFFE27E1C),
    //                       Color(0xFF851161),
    //                     ])),
    //             child: Stack(
    //               children: [
    //                 Align(
    //                   alignment: Alignment.centerRight,
    //                   child: Image.asset(
    //                     'assets/images/noto_money-with-wings.png',
    //                     height: 64,
    //                   ),
    //                 ),
    //                 Align(
    //                   alignment: Alignment.bottomLeft,
    //                   child: Image.asset(
    //                     'assets/images/Group.png',
    //                     height: 34,
    //                   ),
    //                 ),
    //                 Padding(
    //                   padding: EdgeInsets.symmetric(
    //                       horizontal: size.width * 0.1,
    //                       vertical: size.height * 0.05),
    //                   child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                       Row(
    //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                         children: [
    //                           Column(
    //                             children: [
    //                               const Text(
    //                                 "Today Ads",
    //                                 textAlign: TextAlign.start,
    //                                 style: TextStyle(
    //                                   fontFamily: 'MontserratLight',
    //                                   color: Color(0xFFFFFFFF),
    //                                   fontSize: 16,
    //                                 ),
    //                               ),
    //                               Text(
    //                                 today_ads,
    //                                 textAlign: TextAlign.start,
    //                                 style: const TextStyle(
    //                                   fontFamily: 'MontserratLight',
    //                                   color: Color(0xFF00FFFF),
    //                                   fontSize: 20,
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                           Column(
    //                             children: [
    //                               const Text(
    //                                 "Total Ads",
    //                                 textAlign: TextAlign.start,
    //                                 style: TextStyle(
    //                                   fontFamily: 'MontserratLight',
    //                                   color: Color(0xFFFFFFFF),
    //                                   fontSize: 16,
    //                                 ),
    //                               ),
    //                               Text(
    //                                 total_ads,
    //                                 textAlign: TextAlign.start,
    //                                 style: const TextStyle(
    //                                   fontFamily: 'MontserratLight',
    //                                   color: Color(0xFF00FFFF),
    //                                   fontSize: 20,
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                         ],
    //                       ),
    //                       Row(
    //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                         children: [
    //                           const Column(
    //                             children: [
    //                               Text(
    //                                 "Total Referrals",
    //                                 textAlign: TextAlign.start,
    //                                 style: TextStyle(
    //                                   fontFamily: 'MontserratLight',
    //                                   color: Color(0xFFFFFFFF),
    //                                   fontSize: 16,
    //                                 ),
    //                               ),
    //                               Text(
    //                                 "5",
    //                                 textAlign: TextAlign.start,
    //                                 style: TextStyle(
    //                                   fontFamily: 'MontserratLight',
    //                                   color: Color(0xFF00FFFF),
    //                                   fontSize: 20,
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                           Column(
    //                             children: [
    //                               const Text(
    //                                 "Total Balance",
    //                                 textAlign: TextAlign.start,
    //                                 style: TextStyle(
    //                                   fontFamily: 'MontserratLight',
    //                                   color: Color(0xFFFFFFFF),
    //                                   fontSize: 16,
    //                                 ),
    //                               ),
    //                               Text(
    //                                 "₹ $balance",
    //                                 textAlign: TextAlign.start,
    //                                 style: const TextStyle(
    //                                   fontFamily: 'MontserratLight',
    //                                   color: Color(0xFF00FFFF),
    //                                   fontSize: 20,
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //         const SizedBox(
    //           height: 10,
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    return Scaffold(
      body: Container(
        width:
            MediaQuery.of(context).size.width, // Set width to the screen width
        height: MediaQuery.of(context)
            .size
            .height, // Set height to the screen height
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [colors.primary_color, colors.secondary_color],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Column(
                children: [
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Container(
                  //       decoration: BoxDecoration(
                  //         border: Border.all(
                  //           color: colors.widget_color,
                  //           width: 2,
                  //         ),
                  //         borderRadius: BorderRadius.circular(8),
                  //       ),
                  //       padding: const EdgeInsets.symmetric(
                  //         horizontal: 15,
                  //         vertical: 10,
                  //       ),
                  //       child: Column(
                  //         children: [
                  //           const Text(
                  //             "Main Balance",
                  //             style: TextStyle(
                  //                 fontFamily: 'MontserratLight',
                  //                 fontWeight: FontWeight.w500,
                  //                 color: Colors.white,
                  //                 fontSize: 15.0),
                  //           ),
                  //           const SizedBox(
                  //             height: 5,
                  //           ),
                  //           Text(
                  //             "$balance + $multiplyCostValue",
                  //             style: const TextStyle(
                  //                 fontFamily: 'MontserratBold',
                  //                 color: Colors.white,
                  //                 fontSize: 15.0),
                  //           ),
                  //           // Obx(() => Text(
                  //           //   "$balance + $multiplyCostValue",
                  //           //   // "${fullTimePageCont.balance} + $multiplyCostValue",
                  //           //   style: const TextStyle(
                  //           //       fontFamily: 'MontserratBold',
                  //           //       color: Colors.white,
                  //           //       fontSize: 15.0),
                  //           // ),),
                  //         ],
                  //       ),
                  //     ),
                  //     const SizedBox(
                  //       width: 10,
                  //     ),
                  //     const Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Text(
                  //           "Today Ads",
                  //           style: TextStyle(
                  //               fontFamily: 'MontserratLight',
                  //               fontWeight: FontWeight.w500,
                  //               color: Colors.white,
                  //               fontSize: 15.0),
                  //         ),
                  //         SizedBox(
                  //           height: 10,
                  //         ),
                  //         Text(
                  //           "Total Ads",
                  //           style: TextStyle(
                  //               fontFamily: 'MontserratLight',
                  //               fontWeight: FontWeight.w500,
                  //               color: Colors.white,
                  //               fontSize: 15.0),
                  //         ),
                  //       ],
                  //     ),
                  //     const SizedBox(
                  //       width: 10,
                  //     ),
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Text(
                  //           "$today_ads + ${adsCount.toString()}",
                  //           style: const TextStyle(
                  //               fontFamily: 'MontserratBold',
                  //               color: Colors.white,
                  //               fontSize: 15.0),
                  //         ),
                  //         // Obx(() => Text(
                  //         //   "$today_ads + ${adsCount.toString()}",
                  //         //   // "${fullTimePageCont.totalAds} + ${adsCount.toString()}",
                  //         //   style: const TextStyle(
                  //         //       fontFamily: 'MontserratBold',
                  //         //       color: Colors.white,
                  //         //       fontSize: 15.0),
                  //         // ),),
                  //         const SizedBox(
                  //           height: 10,
                  //         ),
                  //         Text(
                  //           "$total_ads + ${adsCount.toString()}",
                  //           // "${fullTimePageCont.totalAds}  + ${adsCount.toString()}",
                  //           style: const TextStyle(
                  //               fontFamily: 'MontserratBold',
                  //               color: Colors.white,
                  //               fontSize: 15.0),
                  //         ),
                  //         // Obx(() => Text(
                  //         //   "$total_ads + ${adsCount.toString()}",
                  //         //   // "${fullTimePageCont.totalAds}  + ${adsCount.toString()}",
                  //         //   style: const TextStyle(
                  //         //       fontFamily: 'MontserratBold',
                  //         //       color: Colors.white,
                  //         //       fontSize: 15.0),
                  //         // ),),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircularPercentIndicator(
                          radius: 40.0,
                          lineWidth: 13.0,
                          animation: true,
                          backgroundColor: Colors.grey.shade400,
                          percent: progressPercentage.clamp(0.0, 1.0),
                          animateFromLastPercent: true,
                          center: Text(
                            (progressPercentage * maximumValue)
                                .toInt()
                                .toString(),
                            style: const TextStyle(
                                fontFamily: 'MontserratBold',
                                fontSize: 16.0,
                                color: Colors.white),
                          ),
                          footer: IgnorePointer(
                            ignoring: isButtonDisabled,
                            child: InkWell(
                              onTap: () async {
                                syncType = 'regular_sync';
                                debugPrint("syncType: $syncType");
                                try {
                                  prefs = await SharedPreferences.getInstance();
                                  setState(() {
                                    syncUniqueId;
                                  });
                                  debugPrint("syncUniqueId: $syncUniqueId");
                                  // Call the syncData function and get the result immediately
                                  fullTimePageCont.syncData(
                                    context,
                                    prefs.getString(Constant.ID),
                                    adsCount.toString(),
                                    syncUniqueId.toString(),
                                    prefs
                                        .getString(Constant.MY_DEVICE_ID)
                                        .toString(),
                                    syncType,
                                    platformType,
                                    (String syncDataSuccess) {
                                      debugPrint(
                                          "syncDataSuccess: $syncDataSuccess");
                                      // Perform actions based on the result of the syncData function
                                      if (syncDataSuccess == 'true') {
                                        setState(() {
                                          saveTimerCount(0, 0.0);
                                          loadTimerCount();
                                          isButtonDisabled = true;
                                          multiplyCostValue = 0.0;
                                          ads_time = prefs
                                              .getString(Constant.ADS_TIME)!;
                                          balance = prefs
                                              .getString(Constant.BALANCE)!;
                                          today_ads = prefs
                                              .getString(Constant.TODAY_ADS)!;
                                          total_ads = prefs
                                              .getString(Constant.TOTAL_ADS)!;
                                          ads_cost = prefs
                                              .getString(Constant.ADS_COST)!;
                                          storeBalance = prefs
                                              .getString(Constant.STORE_BALANCE)!;
                                        });
                                      } else {}
                                    },
                                  );
                                } catch (e) {
                                  // Handle any errors that occur during the process
                                  debugPrint("Error: $e");
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: isButtonDisabled == false
                                        ? Colors.deepPurpleAccent
                                        : Colors.purple[50],
                                    borderRadius: BorderRadius.circular(10)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                margin:
                                    const EdgeInsets.only(top: 20),
                                child: Text(
                                  "Sync Now",
                                  style: TextStyle(
                                    fontFamily: 'MontserratBold',
                                    fontSize: 12.0,
                                    color: isButtonDisabled == false
                                        ? Colors.white
                                        : Colors.grey[500],
                                    // : Colors.purpleAccent[200],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          progressColor: Colors.deepPurpleAccent,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: colors.widget_color,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      const Text(
                                        "Store Ads",
                                        style: TextStyle(
                                            fontFamily: 'MontserratLight',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                            fontSize: 13.0),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        "$storeBalance",
                                        style: const TextStyle(
                                            fontFamily: 'MontserratBold',
                                            color: Colors.white,
                                            fontSize: 15.0),
                                      ),
                                      // Obx(() => Text(
                                      //   "$balance + $multiplyCostValue",
                                      //   // "${fullTimePageCont.balance} + $multiplyCostValue",
                                      //   style: const TextStyle(
                                      //       fontFamily: 'MontserratBold',
                                      //       color: Colors.white,
                                      //       fontSize: 15.0),
                                      // ),),
                                    ],
                                  ),
                                  // const SizedBox(
                                  //   width: 10,
                                  // ),
                                  // InkWell(
                                  //   onTap: (){
                                  //     String uri =
                                  //         Constant.PurchaseWebUrl;
                                  //     launchUrl(
                                  //       Uri.parse(uri),
                                  //       mode: LaunchMode.inAppWebView,
                                  //     );
                                  //   },
                                  //   child: Container(
                                  //     height: 30,
                                  //     padding: const EdgeInsets.symmetric(horizontal: 10),
                                  //     decoration: BoxDecoration(
                                  //         borderRadius: BorderRadius.circular(10000),
                                  //       color: colors.widget_color,
                                  //     ),
                                  //     alignment: Alignment.center,
                                  //     child: const Text(
                                  //       'Purchase',
                                  //       style: TextStyle(
                                  //           fontWeight: FontWeight.bold,
                                  //           fontSize: 10,
                                  //           color: Colors.white
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Today Ads",
                                      style: TextStyle(
                                          fontFamily: 'MontserratLight',
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                          fontSize: 13.0),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "Total Ads",
                                      style: TextStyle(
                                          fontFamily: 'MontserratLight',
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                          fontSize: 13.0),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "Balance",
                                      style: TextStyle(
                                        fontFamily: 'MontserratLight',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                        fontSize: 13.0,),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "$today_ads + ${adsCount.toString()}",
                                      style: const TextStyle(
                                          fontFamily: 'MontserratBold',
                                          color: Colors.white,
                                          fontSize: 13.0),
                                    ),
                                    // Obx(() => Text(
                                    //   "$today_ads + ${adsCount.toString()}",
                                    //   // "${fullTimePageCont.totalAds} + ${adsCount.toString()}",
                                    //   style: const TextStyle(
                                    //       fontFamily: 'MontserratBold',
                                    //       color: Colors.white,
                                    //       fontSize: 15.0),
                                    // ),),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "$total_ads + ${adsCount.toString()}",
                                      // "${fullTimePageCont.totalAds}  + ${adsCount.toString()}",
                                      style: const TextStyle(
                                          fontFamily: 'MontserratBold',
                                          color: Colors.white,
                                          fontSize: 13.0),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "$balance",
                                      style: const TextStyle(
                                          fontFamily: 'MontserratBold',
                                          color: Colors.white,
                                          fontSize: 13.0),),
                                    // Obx(() => Text(
                                    //   "$total_ads + ${adsCount.toString()}",
                                    //   // "${fullTimePageCont.totalAds}  + ${adsCount.toString()}",
                                    //   style: const TextStyle(
                                    //       fontFamily: 'MontserratBold',
                                    //       color: Colors.white,
                                    //       fontSize: 15.0),
                                    // ),),
                                  ],
                                ),
                              ],
                            )
                          ],
                        )
                        // CircularPercentIndicator(
                        //   radius: 35.0,
                        //   lineWidth: 10.0,
                        //   animation: true,
                        //   percent: progressPercentageTwo.clamp(0.0, 1.0),
                        //   backgroundWidth: 13,
                        //   center: Text(
                        //     (progressPercentageTwo * maximumValue)
                        //         .toInt()
                        //         .toString(),
                        //     style: const TextStyle(
                        //         fontFamily: 'MontserratBold',
                        //         fontSize: 16.0,
                        //         color: Colors.white),
                        //   ),
                        //   footer: Column(
                        //     children: [
                        //       IgnorePointer(
                        //         ignoring: isClaimButtonDisabled,
                        //         child: InkWell(
                        //           onTap: () async {
                        //             syncType = 'reward_sync';
                        //             debugPrint("syncType: $syncType");
                        //             try {
                        //               prefs =
                        //                   await SharedPreferences.getInstance();
                        //               setState(() {
                        //                 syncUniqueId;
                        //               });
                        //               debugPrint("syncUniqueId: $syncUniqueId");
                        //               // Call the syncData function and get the result immediately
                        //               fullTimePageCont.syncData(
                        //                 prefs.getString(Constant.ID),
                        //                 adsCount.toString(),
                        //                 syncUniqueId.toString(),
                        //                 prefs
                        //                     .getString(Constant.MY_DEVICE_ID)
                        //                     .toString(),
                        //                 syncType,
                        //                 platformType,
                        //                 (String syncDataSuccess) {
                        //                   debugPrint(
                        //                       "syncDataSuccess: $syncDataSuccess");
                        //                   // Perform actions based on the result of the syncData function
                        //                   if (syncDataSuccess == 'true') {
                        //                     setState(() {
                        //                       isClaimButtonDisabled = true;
                        //                       reward_ads = prefs.getString(
                        //                           Constant.REWARD_ADS)!;
                        //                       ads_time = prefs.getString(
                        //                           Constant.ADS_TIME)!;
                        //                       balance = prefs
                        //                           .getString(Constant.BALANCE)!;
                        //                       today_ads = prefs.getString(
                        //                           Constant.TODAY_ADS)!;
                        //                       total_ads = prefs.getString(
                        //                           Constant.TOTAL_ADS)!;
                        //                       ads_cost = prefs.getString(
                        //                           Constant.ADS_COST)!;
                        //                     });
                        //                   } else {}
                        //                 },
                        //               );
                        //             } catch (e) {
                        //               // Handle any errors that occur during the process
                        //               debugPrint("Error: $e");
                        //             }
                        //           },
                        //           child: Container(
                        //             decoration: isClaimButtonDisabled == false
                        //                 ? BoxDecoration(
                        //                     gradient: const LinearGradient(
                        //                       begin: Alignment.topRight,
                        //                       end: Alignment.bottomLeft,
                        //                       colors: [
                        //                         Colors.deepOrangeAccent,
                        //                         Colors.pink,
                        //                       ],
                        //                     ),
                        //                     borderRadius:
                        //                         BorderRadius.circular(10),
                        //                   )
                        //                 : BoxDecoration(
                        //                     color: Colors.orange.shade50,
                        //                     borderRadius:
                        //                         BorderRadius.circular(10),
                        //                   ),
                        //             padding: const EdgeInsets.symmetric(
                        //                 horizontal: 15, vertical: 10),
                        //             margin: const EdgeInsets.only(top: 10),
                        //             child: Text(
                        //               "Claim Reward",
                        //               style: TextStyle(
                        //                   fontFamily: 'MontserratBold',
                        //                   fontSize: 12.0,
                        //                   color: isClaimButtonDisabled == false
                        //                       ? Colors.white
                        //                       : Colors.grey[500]
                        //                   // : Colors.orangeAccent[200],
                        //                   ),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //       InkWell(
                        //         onTap: () {
                        //           launchUrl(
                        //             Uri.parse(homeController.rewardAdsDetails
                        //                 .toString()),
                        //             mode: LaunchMode.externalApplication,
                        //           );
                        //         },
                        //         child: Text(
                        //           "more details",
                        //           style: GoogleFonts.poppins(
                        //             fontSize: 14,
                        //             color: Colors.white,
                        //             fontWeight: FontWeight.normal,
                        //             decoration: TextDecoration.underline,
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        //   linearGradient: const LinearGradient(
                        //     colors: [
                        //       Colors.deepOrangeAccent,
                        //       Colors.pink,
                        //     ],
                        //   ),
                        //   circularStrokeCap: CircularStrokeCap.round,
                        //   // progressColor: Colors.deepOrangeAccent,
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    margin: const EdgeInsets.only(right: 30),
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: skipAdButton == false ? () {
                        timerWatchAd.cancel();
                        watchAds();
                        skipAdTimer();
                        print('Ad skipped manually!');
                      } : () {},
                      child: Container(
                          height: 30,
                          width: 80,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1000),
                              color: skipAdButton == false ? Colors.deepPurpleAccent : Colors.purple[50],),
                          child: countdown == 0 ? Text(
                            'Skip Ad',
                            style: TextStyle(
                              fontSize: 12, color: skipAdButton == false ? Colors.white
                                : Colors.grey[500],fontWeight: FontWeight.bold,),
                          ): Text(
                            'Skip Ad ($countdown)',
                            style: TextStyle(
                                fontSize: 12, color: skipAdButton == false ? Colors.white
                                : Colors.grey[500],fontWeight: FontWeight.bold,),
                          )),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Image.network(
                    ads_image,
                    fit: BoxFit.contain,
                    height: 300, // Set the desired height
                    width: 300, // Set the desired width
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        _isLoading = false;
                        return child;
                      } else if (_isLoading) {
                        return const CircularProgressIndicator(); // Show loading indicator
                      } else {
                        return child;
                      }
                    },
                  ),
                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: () {
                      launchUrl(
                        Uri.parse(ads_link),
                        mode: LaunchMode.externalApplication,
                      );
                    },
                    child: Text(
                      "click here to purchase",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  // Text(
                  //   timerStarted ? "$seconds seconds" : "",
                  //   style: const TextStyle(
                  //     fontSize: 14,
                  //     color: Colors.red,
                  //     fontWeight: FontWeight.normal,
                  //   ),
                  // ),
                  const SizedBox(height: 5),
                  MaterialButton(
                    onPressed: isButtonEnabled == true
                        ? () async {
                            debugPrint(
                                "homeController.watchAdStatus: ${homeController.watchAdStatus}");
                            int adsTimeInSeconds = int.parse(ads_time);
                            debugPrint("adsCount: $adsCount");
                            var myDeviceId = isWeb == 'true'
                                ? '12345678'
                                : prefs.getString(Constant.MY_DEVICE_ID);
                            var watchAdStatus =
                                prefs.getString(Constant.WATCH_AD_STATUS);
                            debugPrint("myDeviceId: $myDeviceId");
                            if (homeController.watchAdStatus == "1" &&
                                adsCount < 120) {
                              if (!timerStarted) {
                                generatedOtp = fullTimePageCont
                                    .generateRandomFourDigitNumber()
                                    .toString();
                                showAlertDialog(context);
                                // showAlertDialog(context, generatedOtp);
                                debugPrint("isButtonEnabled is false");
                                setState(() {
                                  isButtonEnabled = false;
                                });
                                Future.delayed(
                                  Duration(seconds: adsTimeInSeconds),
                                  () {
                                    debugPrint("isButtonEnabled is true");
                                    setState(() {
                                      isButtonEnabled = true;
                                    });
                                  },
                                );
                                // showAlertDialog(context);
                              } else {
                                Utils().showToast("Please wait...");
                              }
                            } else if (adsCount >= 120) {
                              Utils().showToast("Sync Now Try Again...");
                            } else {
                              Utils().showToast("Watch Ad is disable...");
                            }
                            // if (!timerStarted) {
                            //   // watchad();
                            //   starttime = 0;
                            //   timerStarted = true;
                            //   startTimer();
                            // } else {
                            //   Utils().showToast("Please wait...");
                            // }
                          }
                        : () {
                            Utils().showToast("Please wait...");
                          },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      height: 40,
                      width: 140,
                      decoration: homeController.watchAdStatus == "1" &&
                              adsCount < 120
                          ? const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/btnbg.png"),
                                fit: BoxFit.fill,
                              ),
                            )
                          : BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(100)),
                      child: const Center(
                        child: Text(
                          'Watch Ad',
                          style: TextStyle(
                              color: colors.white,
                              fontSize: 14,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  LinearProgressIndicator(
                    value: progressbar,
                    minHeight: 10, // Set the desired height of the progress bar
                    backgroundColor: Colors
                        .grey[300], // Background color of the progress bar
                    valueColor: const AlwaysStoppedAnimation<Color>(
                        colors.widget_color), // Color of the progress indicator
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ),
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

  showAlertDialog(
    BuildContext context,
    // String generatedOtp,
  ) {
    Size size = MediaQuery.of(context).size;

    AlertDialog alert = AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      contentPadding: const EdgeInsets.all(20),
      content: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          // Handle the tap, or do nothing to prevent dismissal
        },
        child: Container(
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
              await Future.delayed(
                const Duration(seconds: 3),
                () {
                  debugPrint("action completed");
                  skipAdTimer();
                  setState(() {
                    countdown = 5;
                  });
                  watchAds();
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        ),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(onWillPop: () async => false, child: alert);
      },
    );
  }

  // showAlertDialog(
  //   BuildContext context,
  //   String generatedOtp,
  // ) {
  //   Size size = MediaQuery.of(context).size;
  //
  //   AlertDialog alert = AlertDialog(
  //     shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.all(Radius.circular(10))),
  //     contentPadding: const EdgeInsets.all(20),
  //     content: Container(
  //       height: size.height * 0.25,
  //       decoration: const BoxDecoration(),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               SizedBox(
  //                 width: size.width * 0.5,
  //                 child: Text(
  //                   generatedOtp,
  //                   style: const TextStyle(
  //                     fontFamily: 'MontserratBold',
  //                     fontSize: 14,
  //                     color: Colors.black,
  //                   ),
  //                 ),
  //               ),
  //               // InkWell(
  //               //   onTap: () => Navigator.of(context).pop(),
  //               //   child: Transform.rotate(
  //               //     angle: 45 * (3.1415926535 / 180),
  //               //     child: const Icon(
  //               //       Icons.add,
  //               //       // Adjust other properties as needed
  //               //       size: 24.0,
  //               //       color: Colors.black,
  //               //     ),
  //               //   ),
  //               // )
  //             ],
  //           ),
  //           OtpInputField(
  //             generatedOtp: generatedOtp,
  //             onPress: (enteredOtp) {
  //               if (enteredOtp == generatedOtp) {
  //                 print('OTP Matched');
  //                 watchAds();
  //               } else {
  //                 print('OTP Mismatch');
  //               }
  //               print('Entered OTP: $enteredOtp');
  //             },
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  //
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return WillPopScope(onWillPop: () async => false, child: alert);
  //     },
  //   );
  // }
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
