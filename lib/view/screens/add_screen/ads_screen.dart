import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:a1_ads/controller/home_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:a1_ads/Helper/apiCall.dart';
import 'package:a1_ads/model/slider_data.dart';
import 'package:a1_ads/model/user.dart';
import 'package:a1_ads/controller/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../util/Color.dart';
import '../../../util/Constant.dart';
import '../job/online_jobs.dart';

class ADsScreen extends StatefulWidget {
  const ADsScreen({Key? key}) : super(key: key);

  @override
  State<ADsScreen> createState() => ADsScreenState();
}

class ADsScreenState extends State<ADsScreen> {
  final HomeController homeController = Get.find<HomeController>();
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
      total_ads = "0";
  double progressbar = 0.0;
  late String image = "", referText = "", offer_image = "", refer_bonus = "";

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((value) {
      prefs = value;
      // userDeatils();
      contact_us = prefs.getString(Constant.CONTACT_US).toString();
      basic_wallet = prefs.getString(Constant.BASIC_WALLET)!;
      premium_wallet = prefs.getString(Constant.PREMIUM_WALLET)!;
      status = prefs.getString(Constant.STATUS)!;
      // refer_bonus = prefs.getString(Constant.REFER_BONUS)!;

      adsApi();
      //ads_status("status");
    });
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      setState(() {
        contact_us = prefs.getString(Constant.CONTACT_US).toString();
        image = prefs.getString(Constant.IMAGE).toString();
        offer_image = prefs.getString(Constant.OFFER_IMAGE).toString();
        referText = prefs.getString(Constant.REFER_CODE)!;
        // refer_bonus = homeController.referBonus.toString();
      });
    });
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
    setState(() {
      basic_wallet = prefs.getString(Constant.BASIC_WALLET)!;
      premium_wallet = prefs.getString(Constant.PREMIUM_WALLET)!;
      target_refers = prefs.getString(Constant.TARGET_REFERS)!;
      today_ads = prefs.getString(Constant.TODAY_ADS)!;
      total_ads = prefs.getString(Constant.TOTAL_ADS)!;
      status = prefs.getString(Constant.STATUS)!;
    });
  }

  void startTimer() {
    // Example: Countdown from 100 to 0 with a 1-second interval
    const oneSec = const Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer timer) {
      if (starttime >= 60) {
        timer.cancel();

        setState(() {
          progressbar = 0.0;
          timerStarted = false;
        });
      } else {
        setState(() {
          starttime++;
          seconds = starttime % 60;
          progressbar = starttime / 60;
        });
      }
    });
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SingleChildScrollView(
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
                            Obx(
                              () => Text(
                                "Refer friend and earn ₹${homeController.referBonus.toString()}",
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Montserrat"),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                      borderRadius: BorderRadius.circular(6.0),
                                      side: const BorderSide(color: colors.red),
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
                                    Share.share(
                                        "$referText\nUse my Refer Code and Login to our website https://a1-ads-web.web.app");
                                        // "$referText\nUse my Refer Code and Login to our website ${Constant.A1AdsWebUrl}");
                                  },
                                  color: colors.primary_color,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
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
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: colors.widget_color, // Set the border color
                          width: 2, // Set the border width
                        ),
                        color: const Color(0xFFF2F2F2),
                        borderRadius:
                            BorderRadius.circular(8), // Set border radius
                      ),
                      padding: const EdgeInsets.only(
                          top: 5.0, left: 5.0, right: 5.0, bottom: 5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Text(
                          //       "Basic Wallet",
                          //       style: GoogleFonts.poppins(
                          //         // Use GoogleFonts.poppins() to access Poppins font
                          //         fontSize: 14,
                          //         color: Colors.white,
                          //         fontWeight: FontWeight.bold,
                          //       ),
                          //     ),
                          //     const SizedBox(width: 5),
                          //     GestureDetector(
                          //       onTap: () {
                          //         Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //             builder: (context) =>
                          //             const OnlineJobs(),
                          //           ),
                          //         );
                          //       },
                          //       child: Image.asset(
                          //         'assets/images/info.png',
                          //         height: 30,
                          //         width: 20,
                          //       ),
                          //     )
                          //   ],
                          // ),
                          const Text(
                            "Basic Wallet",
                            style: TextStyle(
                              fontFamily: 'MontserratBold',
                              color: Color(0xFF000000),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const Text(
                            "No Refers",
                            style: TextStyle(
                              fontFamily: 'MontserratLight',
                              color: Color(0xFF000000),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFFDDDDDD),
                            ),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/dollar 1.png',
                                  height: 24,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '₹ $basic_wallet',
                                  style: const TextStyle(
                                    fontFamily: 'MontserratBold',
                                    color: Color(0xFF31800C),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              addTomainbalance('basic_wallet');
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/main_balance_btn.png',
                                  height: 50,
                                  width:
                                      120, // Replace with the actual image path
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: colors.widget_color, // Set the border color
                          width: 2, // Set the border width
                        ),
                        color: const Color(0xFFF2F2F2),
                        borderRadius:
                            BorderRadius.circular(8), // Set border radius
                      ),
                      padding: const EdgeInsets.only(
                          top: 5.0, left: 5.0, right: 5.0, bottom: 5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Text(
                          //       "Premium Wallet",
                          //       style: GoogleFonts.poppins(
                          //         // Use GoogleFonts.poppins() to access Poppins font
                          //         fontSize: 14,
                          //         color: colors.widget_color,
                          //         fontWeight: FontWeight.bold,
                          //       ),
                          //     ),
                          //     const SizedBox(width: 5),
                          //     GestureDetector(
                          //       onTap: () {
                          //         Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //             builder: (context) =>
                          //             const OnlineJobs(),
                          //           ),
                          //         );
                          //       },
                          //       child: Image.asset(
                          //         'assets/images/info.png',
                          //         height: 30,
                          //         width: 20,
                          //       ),
                          //     )
                          //   ],
                          // ),
                          const Text(
                            "Premium Wallet",
                            style: TextStyle(
                              fontFamily: 'MontserratBold',
                              color: colors.widget_color,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "$target_refers Refers",
                            style: const TextStyle(
                              fontFamily: 'MontserratLight',
                              color: colors.widget_color,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFFDDDDDD),
                            ),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/dollar 1.png',
                                  height: 24,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '₹ $premium_wallet',
                                  style: const TextStyle(
                                    fontFamily: 'MontserratBold',
                                    color: Color(0xFF31800C),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              addTomainbalance('premium_wallet');
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/main_balance_btn.png',
                                  height: 50,
                                  width:
                                      120, // Replace with the actual image path
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
                  child: const Text(
                    "click here to purchase",
                    style: TextStyle(
                      fontFamily: 'MontserratLight',
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                Text(
                  timerStarted ? "$seconds seconds" : "",
                  style: const TextStyle(
                    fontFamily: 'MontserratLight',
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 5),
                MaterialButton(
                  onPressed: () async {
                    if (!timerStarted) {
                      watchad();
                    } else {
                      Utils().showToast("Please wait...");
                    }
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
                          fontFamily: 'MontserratBold',
                          color: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                LinearProgressIndicator(
                  value: progressbar,
                  minHeight: 10, // Set the desired height of the progress bar
                  backgroundColor:
                      Colors.grey[300], // Background color of the progress bar
                  valueColor: const AlwaysStoppedAnimation<Color>(
                      colors.widget_color), // Color of the progress indicator
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'Today Viewed Ads: $today_ads',
                      style: const TextStyle(
                        fontFamily: 'MontserratLight',
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Total Viewed Ads: $total_ads',
                      style: const TextStyle(
                        fontFamily: 'MontserratLight',
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
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

  Future<void> addTomainbalance(String wallet_type) async {
    var url = Constant.ADD_MAIN_BALANCE_URL;
    Map<String, dynamic> bodyObject = {
      Constant.USER_ID: prefs.getString(Constant.ID),
      Constant.WALLET_TYPE: wallet_type,
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

  Future<void> watchad() async {
    var url = Constant.VIEW_AD_URL;
    Map<String, dynamic> bodyObject = {
      Constant.USER_ID: prefs.getString(Constant.ID),
    };

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
}
