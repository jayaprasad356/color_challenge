import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:color_challenge/Helper/apiCall.dart';
import 'package:color_challenge/controller/full_time_page_con.dart';
import 'package:color_challenge/model/slider_data.dart';
import 'package:color_challenge/model/user.dart';
import 'package:color_challenge/controller/utils.dart';
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
import '../job/online_jobs.dart';

class FullTimePage extends StatefulWidget {
  const FullTimePage({Key? key}) : super(key: key);

  @override
  State<FullTimePage> createState() => FullTimePageState();
}

class FullTimePageState extends State<FullTimePage> {
  final FullTimePageCont fullTimePageCont = Get.find<FullTimePageCont>();
  // TextEditingController otpController1 = TextEditingController();
  // TextEditingController otpController2 = TextEditingController();
  // TextEditingController otpController3 = TextEditingController();
  // TextEditingController otpController4 = TextEditingController();
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
  String ads_cost = "0";
  bool timerStarted = false;
  bool isTrial = true, isPremium = false;
  Random random = Random();
  late String contact_us;
  final TextEditingController _serialController = TextEditingController();
  String serilarandom = "",
      basic_wallet = "",
      premium_wallet = "",
      target_refers = "",
      today_ads = "0",
      total_ads = "0",
      ads_time = "0";
  double progressbar = 0.0;
  late String image = "", referText = "", offer_image = "", refer_bonus = "";
  int adsCount = 0;
  double progressPercentage = 0.0;
  late bool isButtonDisabled;
  late String generatedOtp;
  int syncUniqueId = 1;
  double multiplyCostValue = 0;
  // FocusNode otpFocus1 = FocusNode();
  // FocusNode otpFocus2 = FocusNode();
  // FocusNode otpFocus3 = FocusNode();
  // FocusNode otpFocus4 = FocusNode();
  // late List<FocusNode> focusNodes;
  // late List<TextEditingController> controllers;

  @override
  void initState() {
    super.initState();

    isButtonDisabled = true;



    // // Initialize focus nodes and controllers
    // focusNodes = List.generate(4, (index) => FocusNode());
    // controllers = List.generate(4, (index) => TextEditingController());

    SharedPreferences.getInstance().then((value) {
      prefs = value;
      setState(() {
        userDeatils();
        contact_us = prefs.getString(Constant.CONTACT_US).toString();
        basic_wallet = prefs.getString(Constant.BASIC_WALLET)!;
        premium_wallet = prefs.getString(Constant.PREMIUM_WALLET)!;
        status = prefs.getString(Constant.STATUS)!;
        status = prefs.getString(Constant.ADS_TIME)!;
        ads_cost = prefs.getString(Constant.ADS_COST)!;

        adsApi();
      });
      //ads_status("status");
    });
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      setState(() {
        contact_us = prefs.getString(Constant.CONTACT_US).toString();
        image = prefs.getString(Constant.IMAGE).toString();
        offer_image = prefs.getString(Constant.OFFER_IMAGE).toString();
        referText = prefs.getString(Constant.REFER_CODE)!;
        refer_bonus = prefs.getString(Constant.REFER_BONUS)!;
      });
    });
    loadTimerCount();
    debugPrint("ads_cost: $ads_cost");
    multiplyCostValue = multiplyCost(adsCount, ads_cost)!;
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
  void setState(VoidCallback fn) async{
    // TODO: implement setState
    super.setState(fn);
    // multiplyCostValue;
    debugPrint("timerCount: $adsCount");
    debugPrint("ads_time: $ads_time");
    userDeatils();
    multiplyCostValue = multiplyCost(adsCount, ads_cost)!;
    if (adsCount < 100) {
      isButtonDisabled = true; // Disable the button
    } else if (adsCount >= 100) {
      isButtonDisabled = false; // Enable the button
      // String? syncAble = await storeLocal.read(
      //     key: Constant.SYNC_ABLE);
      // if (syncAble == "true") {
      //   setState(() {
      //     isButtonDisabled = false;
      //   });
      // }
    }
  }

  void userDeatils() async {
    var url = Constant.USER_DETAIL_URL;
    Map<String, dynamic> bodyObject = {
      Constant.USER_ID: prefs.getString(Constant.ID),
    };
    String jsonString = await apiCall(url, bodyObject);
    final Map<String, dynamic> responseJson = jsonDecode(jsonString);
    final dataList = responseJson['data'] as List;
    final Users user = Users.fromJsonNew(dataList.first);

    prefs.setString(Constant.LOGED_IN, "true");
    prefs.setString(Constant.ID, user.id);
    prefs.setString(Constant.MOBILE, user.mobile);
    prefs.setString(Constant.NAME, user.name);
    prefs.setString(Constant.EARN, user.earn);
    prefs.setString(Constant.CITY, user.city);
    prefs.setString(Constant.AGE, user.age);
    prefs.setString(Constant.GENDER, user.gender);
    prefs.setString(Constant.SUPPORT_LAN, user.support_lan);
    prefs.setString(Constant.BALANCE, user.balance);
    prefs.setString(Constant.REFERRED_BY, user.referredBy);
    prefs.setString(Constant.REFER_CODE, user.referCode);
    prefs.setString(Constant.WITHDRAWAL_STATUS, user.withdrawalStatus);
    prefs.setString(Constant.STATUS, user.status);
    prefs.setString(Constant.JOINED_DATE, user.joinedDate);
    prefs.setString(Constant.LAST_UPDATED, user.lastUpdated);
    prefs.setString(Constant.MIN_WITHDRAWAL, user.min_withdrawal);
    prefs.setString(Constant.HOLDER_NAME, user.holder_name);
    prefs.setString(Constant.ACCOUNT_NUM, user.account_num);
    prefs.setString(Constant.IFSC, user.ifsc);
    prefs.setString(Constant.BANK, user.bank);
    prefs.setString(Constant.BRANCH, user.branch);
    prefs.setString(Constant.BASIC_WALLET, user.basic_wallet);
    prefs.setString(Constant.PREMIUM_WALLET, user.premium_wallet);
    prefs.setString(Constant.TARGET_REFERS, user.target_refers);
    prefs.setString(Constant.TODAY_ADS, user.today_ads);
    prefs.setString(Constant.TOTAL_ADS, user.total_ads);
    prefs.setString(Constant.STATUS, user.status);
    prefs.setString(Constant.ADS_COST, user.ads_cost);
    prefs.setString(Constant.ADS_TIME, user.ads_time);
    setState(() {
      basic_wallet = prefs.getString(Constant.BASIC_WALLET)!;
      premium_wallet = prefs.getString(Constant.PREMIUM_WALLET)!;
      target_refers = prefs.getString(Constant.TARGET_REFERS)!;
      today_ads = prefs.getString(Constant.TODAY_ADS)!;
      total_ads = prefs.getString(Constant.TOTAL_ADS)!;
      status = prefs.getString(Constant.STATUS)!;
      ads_time = prefs.getString(Constant.ADS_TIME)!;
      ads_cost = prefs.getString(Constant.ADS_COST)!;
      balance = prefs.getString(Constant.BALANCE)!;
    });
  }

  void isButtonDisabledINIT() {
    setState(() {
      debugPrint("timerCount: $adsCount");
      if (adsCount < 100) {
        isButtonDisabled = true; // Disable the button
      } else if (adsCount >= 100) {
        isButtonDisabled = false; // Enable the button
      }
    });
  }

  void startTimer() {
    // Example: Countdown from 100 to 0 with a 1-second interval
    const oneSec = Duration(seconds: 1);
    int adsTimeInSeconds = int.parse(ads_time);
    Timer.periodic(oneSec, (Timer timer) {
      if (starttime >= adsTimeInSeconds) {
        timer.cancel();

        setState(() {
          progressbar = 0.0;
          timerStarted = false;
          progressPercentage;
        });
        adsCount++;
        print('timerCount called $adsCount times.');
        setState(() {
          progressPercentage = (adsCount / 100).clamp(0.0, 1.0);
          debugPrint("timerCount: $adsCount");
          saveTimerCount(adsCount);
          if (adsCount < 100) {
            isButtonDisabled = true; // Disable the button
          } else if (adsCount >= 100) {
            syncUniqueId = fullTimePageCont.generateRandomSixDigitNumber();
            isButtonDisabled = false; // Enable the button
            // timerCount = 1;
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
      progressPercentage = (adsCount / 100).clamp(0.0, 1.0);
    });
  }

  // Save timerCount to shared preferences
  void saveTimerCount(int count) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('timerCount', count);
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
      print('str2: $str2');
      double num2 = double.parse(str2);
      print('num2: $num2');
      return timerCount * num2;
    } catch (e) {
      print('Error: Unable to parse the input string as a number.');
      return null;
    }
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                  Container(
                    color: colors.cc_velvet,
                    margin: const EdgeInsets.only(right: 10, left: 10, top: 10),
                    child: Card(
                      child: Container(
                        color: colors.cc_velvet,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Refer friend and earn ₹$refer_bonus",
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Montserrat"),
                              ),
                              const SizedBox(height: 10.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  OutlinedButton(
                                    onPressed: () {
                                      Utils().showToast("Copied !");
                                      Clipboard.setData(
                                          ClipboardData(text: referText));
                                    },
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                        side: const BorderSide(
                                            color: colors.red),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 11),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Image.asset(
                                            "assets/images/copy.png",
                                            width: 24.0,
                                            height: 24.0,
                                          ),
                                          const SizedBox(width: 8.0),
                                          Text(
                                            referText,
                                            style: const TextStyle(
                                              color: colors.primary,
                                              fontSize: 12.0,
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12.0),
                                  MaterialButton(
                                    onPressed: () {
                                      Share.share(referText +
                                          "\n Use my Refer Code and install this app https://play.google.com/store/apps/details?id=com.app.colorchallenge");
                                    },
                                    color: colors.primary_color,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0)),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 14.0, horizontal: 16.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            'Refer Friends',
                                            style: TextStyle(
                                              color: colors.white,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularPercentIndicator(
                          radius: 35.0,
                          lineWidth: 10.0,
                          animation: true,
                          percent: progressPercentage,
                          center: Text(
                            (progressPercentage * 100).toInt().toString(),
                            style: const TextStyle(
                                fontFamily: 'MontserratBold',
                                fontSize: 16.0,
                                color: Colors.white),
                          ),
                          footer: IgnorePointer(
                            ignoring: isButtonDisabled,
                            child: InkWell(
                              onTap: () async {
                                debugPrint("it is worked");
                                prefs = await SharedPreferences.getInstance();
                                // var syncUniqueId = 1;
                                setState(() {
                                  syncUniqueId;
                                });
                                debugPrint("syncUniqueId: $syncUniqueId");
                                fullTimePageCont.syncData(
                                    prefs.getString(Constant.ID),
                                  adsCount.toString(),
                                    syncUniqueId.toString(),
                                );
                                String? syncAble = await storeLocal.read(
                                    key: Constant.SYNC_ABLE);
                                if (syncAble == "true") {
                                  setState(() {
                                    adsCount = 0;
                                    isButtonDisabled = true;
                                  });
                                } else {
                                  setState(() { });
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: isButtonDisabled == false
                                        ? Colors.deepOrangeAccent
                                        : Colors.grey,
                                    borderRadius: BorderRadius.circular(10)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "Sync Now",
                                  style: TextStyle(
                                    fontFamily: 'MontserratBold',
                                    fontSize: 12.0,
                                    color: isButtonDisabled == false
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: Colors.purple,
                        ),
                        const SizedBox(
                          width: 15,
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
                              child: Column(
                                children: [
                                  const Text(
                                    "Main Balance",
                                    style: TextStyle(
                                        fontFamily: 'MontserratLight',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                        fontSize: 15.0),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "$balance + $multiplyCostValue",
                                    style: const TextStyle(
                                        fontFamily: 'MontserratBold',
                                        color: Colors.white,
                                        fontSize: 15.0),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
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
                                          fontSize: 15.0),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Total Ads",
                                      style: TextStyle(
                                          fontFamily: 'MontserratLight',
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                          fontSize: 15.0),
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
                                            fontSize: 15.0),
                                      ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "$total_ads  + ${adsCount.toString()}",
                                      style: const TextStyle(
                                          fontFamily: 'MontserratBold',
                                          color: Colors.white,
                                          fontSize: 15.0),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
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
                    onPressed: () async {
                      if (!timerStarted) {
                        generatedOtp = fullTimePageCont
                            .generateRandomFourDigitNumber()
                            .toString();
                        showAlertDialog(context, generatedOtp);
                      } else {
                        Utils().showToast("Please wait...");
                      }
                      // if (!timerStarted) {
                      //   // watchad();
                      //   starttime = 0;
                      //   timerStarted = true;
                      //   startTimer();
                      // } else {
                      //   Utils().showToast("Please wait...");
                      // }
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      height: 40,
                      width: 140,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/btnbg.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
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
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: <Widget>[
                  //     Text(
                  //       'Today Viewed Ads: $today_ads',
                  //       style: const TextStyle(
                  //           color: colors.white,
                  //           fontSize: 12,
                  //           fontFamily: "Montserrat",
                  //           fontWeight: FontWeight.bold),
                  //     ),
                  //     const SizedBox(height: 5),
                  //     Text(
                  //       'Total Viewed Ads: $total_ads',
                  //       style: const TextStyle(
                  //           color: colors.white,
                  //           fontSize: 12,
                  //           fontFamily: "Montserrat",
                  //           fontWeight: FontWeight.bold),
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(height: 5),
                  // const SizedBox(height: 5),
                  // const Padding(
                  //   padding: EdgeInsets.all(10.0),
                  //   child: Text(
                  //     'Rs 500 Register Bonus Is Credited In Your Vault Balance. Complete Months Target To Withdraw.',
                  //     style: TextStyle(
                  //         color: colors.widget_color,
                  //         fontSize: 12,
                  //         fontFamily: "Montserrat",
                  //         fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  showSheet() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(40.0),
          ),
        ),
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SingleChildScrollView(
              child: SizedBox(
                height: 500,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(
                        height: 50,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          serilarandom,
                          style: const TextStyle(
                            letterSpacing: 5.0,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: colors.black,
                            fontFamily: "Montserrat",
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          controller: _serialController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: colors.primary),
                            ),
                            hintText: 'Enter PIN',
                          ),
                          style: const TextStyle(
                              backgroundColor: Colors.transparent),
                        ),
                      ),
                      const SizedBox(height: 20),
                      MaterialButton(
                        onPressed: () {
                          if (serilarandom !=
                              _serialController.text.toString()) {
                            Utils().showToast("Pin Wrong");
                          } else {
                            _serialController.text = '';
                            Navigator.pop(context);

                            //ads_status("watch_ad");
                          }
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          height: 80,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/Verify.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Verify',
                              style: TextStyle(
                                  color: colors.white,
                                  fontSize: 18,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Today Viewed Ads: 26',
                        style: TextStyle(
                            color: colors.white,
                            fontSize: 14,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Today Viewed Ads: 26',
                        style: TextStyle(
                            color: colors.white,
                            fontSize: 14,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
              ),
            ),
          );
        });
  }

  String generateSerialNumber() {
    final random = Random();
    final maxDigits = 4;
    String randomNumber = '';

    for (int i = 0; i < maxDigits; i++) {
      randomNumber += random.nextInt(10).toString();
    }

    return randomNumber;
  }

  // Method to get device info.
  Future<void> ads_status(String type) async {
    var url = Constant.TRIAL_ADS_LIST;
    Map<String, dynamic> bodyObject = {
      Constant.USER_ID: prefs.getString(Constant.ID),
      Constant.DEVICE_ID: prefs.getString(Constant.MY_DEVICE_ID).toString(),
      Constant.TYPE: type
    };

    String jsonString = await apiCall(url, bodyObject);
    final jsonResponse = jsonDecode(jsonString);
    if (jsonResponse['success'] && type == 'status') {
      setState(() {
        today_ads_remain = jsonResponse['today_ads_remain'].toString();
        time_left = jsonResponse['time_left'].toString();
        time_start = jsonResponse['time_start'];
        refer_amount = jsonResponse['refer_amount'].toString();
        balance = jsonResponse['balance'].toString();
        history_days = jsonResponse['history_days'].toString();

        status = jsonResponse['status'].toString();
        level = jsonResponse['level'].toString();
        starttime = double.parse(time_left);
        if (status == '1') {
          isTrial = false;
          isPremium = true;
        }
        if (time_start == 1) {
          //startTimer();
        }
      });
    } else if (jsonResponse['success'] && type == 'watch_ad') {
      setState(() {
        today_ads_remain = jsonResponse['today_ads_remain'].toString();
        time_left = jsonResponse['time_left'].toString();
        time_start = jsonResponse['time_start'];
        refer_amount = jsonResponse['refer_amount'].toString();
        balance = jsonResponse['balance'].toString();
        level = jsonResponse['level'].toString();
        status = jsonResponse['status'].toString();
        history_days = jsonResponse['history_days'].toString();
        ads_image = jsonResponse['ads_image'].toString();
        starttime = double.parse(time_left);

        if (status == '1') {
          isTrial = false;
          isPremium = true;
        }
        if (time_start == 1) {
          //startTimer();
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(jsonResponse['message'])),
      );
    }
  }

  Future<void> addTomainbalance(String walletType) async {
    var url = Constant.ADD_MAIN_BALANCE_URL;
    Map<String, dynamic> bodyObject = {
      Constant.USER_ID: prefs.getString(Constant.ID),
      Constant.WALLET_TYPE: walletType,
    };

    String jsonString = await apiCall(url, bodyObject);
    final jsonResponse = jsonDecode(jsonString);
    if (jsonResponse['success']) {
      Utils().showToast(jsonResponse['message']);
    } else {
      Utils().showToast(jsonResponse['message']);
    }
    userDeatils();
  }

  Future<void> watchAdLimit() async {
    var url = Constant.VIEW_AD_URL;
    Map<String, dynamic> bodyObject = {
      Constant.USER_ID: prefs.getString(Constant.ID),
    };

    debugPrint("bodyObject: $bodyObject");

    String jsonString = await apiCall(url, bodyObject);
    final jsonResponse = jsonDecode(jsonString);

    if (jsonResponse['success']) {
      Utils().showToast(jsonResponse['message']);
      starttime = 0;
      timerStarted = true;
      adsApi();
      startTimer();
      userDeatils();
    } else {
      Utils().showToast(jsonResponse['message']);
    }
  }

  Future<void> adsApi() async {
    prefs = await SharedPreferences.getInstance();

    var response = await dataCall(Constant.ADS_URL);

    String jsonDataString = response.toString();
    final jsonData = jsonDecode(jsonDataString);

    final dataList = jsonData['data'] as List;

    final datass = dataList.first;

    prefs.setString(Constant.ADS_LINK, datass[Constant.ADS_LINK]);
    prefs.setString(Constant.ADS_IMAGE, datass[Constant.ADS_IMAGE]);

    setState(() {
      ads_image = prefs.getString(Constant.ADS_IMAGE)!;
      ads_link = prefs.getString(Constant.ADS_LINK)!;
    });
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
      userDeatils();
    } else {
      Utils().showToast(jsonData['message']);
    }
  }

  showAlertDialog(
    BuildContext context,
    String generatedOtp,
  ) {
    Size size = MediaQuery.of(context).size;

    AlertDialog alert = AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      contentPadding: const EdgeInsets.all(20),
      content: Container(
        height: size.height * 0.2,
        decoration: const BoxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: size.width * 0.5,
                  child: Text(
                    generatedOtp,
                    style: const TextStyle(
                      fontFamily: 'MontserratBold',
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Transform.rotate(
                    angle: 45 * (3.1415926535 / 180),
                    child: const Icon(
                      Icons.add,
                      // Adjust other properties as needed
                      size: 24.0,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
            OtpInputField(
              generatedOtp: generatedOtp,
              onPress: (enteredOtp) {
                if (enteredOtp == generatedOtp) {
                  print('OTP Matched');
                  watchAds();
                  // watchAdLimit();
                  // starttime = 0;
                  // timerStarted = true;
                  // startTimer();
                  Navigator.of(context).pop();
                } else {
                  print('OTP Mismatch');
                }
                print('Entered OTP: $enteredOtp');
              },
            ),
          ],
        ),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  // Widget OtpInputField(
  //     String generatedOtp
  //     ) {
  //   return Column(
  //     children: [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: [
  //           buildOtpTextField(context, controllers[0], focusNodes[1]),
  //           buildOtpTextField(context, controllers[1], focusNodes[2]),
  //           buildOtpTextField(context, controllers[2], focusNodes[3]),
  //           buildOtpTextField(context, controllers[3], null),
  //         ],
  //       ),
  //       const SizedBox(height: 20.0),
  //       ElevatedButton(
  //         style: ButtonStyle(
  //           backgroundColor:  MaterialStateProperty.all<Color>(Colors.orange),
  //         ),
  //         onPressed: () {
  //           String enteredOtp = controllers.fold<String>(
  //               "", (previousValue, controller) => previousValue + controller.text);
  //
  //           if (enteredOtp == generatedOtp) {
  //             print('OTP Matched');
  //             if (!timerStarted) {
  //               // watchad();
  //               starttime = 0;
  //               timerStarted = true;
  //               startTimer();
  //               Navigator.of(context).pop();
  //             } else {
  //               Utils().showToast("Please wait...");
  //             }
  //           } else {
  //             print('OTP Mismatch');
  //           }
  //           print('Entered OTP: $enteredOtp');
  //         },
  //         child: const Text('Submit'),
  //       ),
  //     ],
  //   );
  // }
  //
  // Widget buildOtpTextField(
  //     BuildContext context, TextEditingController controller, FocusNode? nextFocus) {
  //   return Container(
  //     width: 50.0,
  //     height: 50.0,
  //     alignment: Alignment.center,
  //     decoration: BoxDecoration(
  //       border: Border.all(color: Colors.orange, width: 2.0),
  //       borderRadius: BorderRadius.circular(10.0),
  //     ),
  //     margin: const EdgeInsets.symmetric(horizontal: 3),
  //     child: TextField(
  //       controller: controller,
  //       maxLength: 1,
  //       keyboardType: TextInputType.number,
  //       textAlign: TextAlign.center,
  //       style: const TextStyle(fontSize: 24.0),
  //       decoration: const InputDecoration(
  //         counterText: '',
  //         enabledBorder: InputBorder.none,
  //         focusedBorder: InputBorder.none,
  //       ),
  //       textInputAction: nextFocus == null ? TextInputAction.done : TextInputAction.next,
  //       onEditingComplete: () {
  //         // If there's a next focus, move to it, otherwise, unfocus
  //         if (nextFocus != null) {
  //           FocusScope.of(context).requestFocus(nextFocus);
  //         } else {
  //           FocusScope.of(context).unfocus();
  //         }
  //       },
  //       onChanged: (value) {
  //         // Move focus to the next text field when a digit is entered
  //         if (value.isNotEmpty && nextFocus != null) {
  //           FocusScope.of(context).requestFocus(nextFocus);
  //         }
  //       },
  //     ),
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
        ElevatedButton(
          onPressed: () {
            String enteredOtp =
                "${otpController1.text}${otpController2.text}${otpController3.text}${otpController4.text}";
            widget.onPress(enteredOtp);
            //
            // if (enteredOtp == widget.generatedOtp) {
            //   print('OTP Matched');
            // } else {
            //   print('OTP Mismatch');
            // }
            // print('Entered OTP: ${otpController1.text}${otpController2.text}${otpController3.text}${otpController4.text}');
          },
          child: const Text('Submit'),
        ),
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
