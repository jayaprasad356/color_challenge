import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:a1_ads/model/transactionl_data.dart';
import 'package:a1_ads/model/withdrawal_data.dart';
import 'package:a1_ads/view/screens/home_page/product_details.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:a1_ads/Helper/apiCall.dart';
import 'package:a1_ads/controller/home_controller.dart';
import 'package:a1_ads/controller/pcc_controller.dart';
import 'package:a1_ads/model/slider_data.dart';
import 'package:a1_ads/model/user.dart';
import 'package:a1_ads/controller/utils.dart';
import 'package:a1_ads/view/screens/shorts_vid/post_upload.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../util/Color.dart';
import '../../../util/Constant.dart';
import '../job/online_jobs.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  final HomeController homeController = Get.find<HomeController>();
  late SharedPreferences prefs;
  double starttime = 0; // Set the progress value between 0.0 and 1.0 here
  String today_ads_remain = "0";
  String level = '0', status = '', group_link = '';
  late List<WithdrawalData> withdrawalsData = [];
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
      totalIncome = "",
      remainingBalance = "",
  recharge = "";
  double progressbar = 0.0;
  int _currentIndex = 0;
  PageController _pageController = PageController();
  int _currentPage = 0;
  int selectedCategoryIndex = 0;
  int selectedProductIndex = -1;
  // String referralCode = '';

  @override
  void initState() {
    super.initState();

    // homeController.allSettingsData();

    handleAsyncInit();
    settingsApi();
    homeController.categoryListData();
    homeController.productListData('1');
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      // userDeatils();
      contact_us = prefs.getString(Constant.CONTACT_US).toString();
      contact_us = prefs.getString(Constant.CONTACT_US).toString();
      basic_wallet = prefs.getString(Constant.BASIC_WALLET)!;
      premium_wallet = prefs.getString(Constant.PREMIUM_WALLET)!;
      status = prefs.getString(Constant.STATUS)!;
      group_link = prefs.getString(Constant.WHATSPP_GROUP_LINK)!;

      adsApi();
      //ads_status("status");
    });
  }

  void handleAsyncInit() async {
    prefs = await SharedPreferences.getInstance();
    homeController.slideList(prefs.getString(Constant.ID));
    setState(() async {
      debugPrint(homeController.sliderImageURL.string);
      debugPrint(homeController.sliderName.string);
      totalIncome = prefs.getString(Constant.EARN)!;
      remainingBalance = prefs.getString(Constant.BALANCE)!;
      recharge = prefs.getString(Constant.RECHARGE)!;
      // referralCode = (await storeLocal.read(key: Constant.REFERRAL_CODE))!;
      // debugPrint('referralCode : $referralCode');
    });
  }

  void settingsApi() async {
    homeController.allSettingsData();

    setState(() {
      debugPrint(
          "homeController.a1JobVideoURS.string: ${homeController.a1JobVideoURS.string}");
      debugPrint(homeController.a1JobDetailsURS.string);
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
    prefs.setString(Constant.MEDIA_WALLET, user.media_wallet);
    prefs.setString(Constant.POST_LEFT, user.post_left);
    prefs.setString(Constant.DEAF, user.deaf);
    prefs.setString(Constant.EMAIL, user.email);
    setState(() {
      basic_wallet = prefs.getString(Constant.BASIC_WALLET)!;
      premium_wallet = prefs.getString(Constant.PREMIUM_WALLET)!;
      target_refers = prefs.getString(Constant.TARGET_REFERS)!;
      status = prefs.getString(Constant.STATUS)!;
    });
  }

  void startTimer() {
    // Example: Countdown from 100 to 0 with a 1-second interval
    const oneSec = Duration(seconds: 1);
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

  Future<List<WithdrawalData>> _getWithdrawalsData() async {
    prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> bodyObject = {
      Constant.USER_ID: prefs.getString(Constant.ID)!,
    };

    String response =
    await apiCall(Constant.MY_WITHDRAWALS_LIST_URL, bodyObject);

    final jsonsData = jsonDecode(response);
    withdrawalsData.clear();

    for (var Data in jsonsData['data']) {
      final id = Data['id'];
      final amount = Data["amount"];
      final status = Data['status'];
      final datetime = Data['datetime'];

      WithdrawalData data = WithdrawalData(id, amount, status, datetime);
      withdrawalsData.add(data);
    }
    return withdrawalsData;
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
    // return Scaffold(
    //   backgroundColor: const Color(0xFFF2F2F2),
    //   body: Container(
    //     height: size.height,
    //     width: size.width,
    //     decoration: const BoxDecoration(
    //       gradient: LinearGradient(
    //         colors: [colors.primary_color, colors.secondary_color],
    //         begin: Alignment.topCenter,
    //         end: Alignment.bottomCenter,
    //       ),
    //     ),
    //     padding: const EdgeInsets.all(20),
    //     child: SafeArea(
    //       child: Container(
    //         width: size.width,
    //         decoration: BoxDecoration(
    //             color: Colors.transparent,
    //             borderRadius: BorderRadius.circular(16)),
    //         child: ClipRRect(
    //           borderRadius: BorderRadius.circular(16),
    //           child: Image.asset('assets/images/WhatsApp Image 2023-12-20 at 1.35.15 AM.jpeg',
    //             fit: BoxFit.cover,
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
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
                  Expanded(
                    child: Container(
                      height: size.height * 0.1,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xFFFF6644),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Stack(
                        children: [
                          Align(
                              alignment: Alignment.bottomRight,
                              child: Image.asset(
                                "assets/images/profits 1.png",
                                height: 40,
                              )),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total Earning',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontFamily: 'MontserratLight',
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                '₹12,670',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontFamily: 'MontserratBold',
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: size.height * 0.1,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xFF161C7E),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Stack(
                        children: [
                          Align(
                              alignment: Alignment.bottomRight,
                              child: Image.asset(
                                "assets/images/profits 1.png",
                                height: 40,
                              )),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Total Income',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontFamily: 'MontserratLight',
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                '₹$totalIncome',
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  fontFamily: 'MontserratBold',
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: size.height * 0.1,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xFF8E02B1),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Stack(
                        children: [
                          Align(
                              alignment: Alignment.bottomRight,
                              child: Image.asset(
                                "assets/images/profits 1.png",
                                height: 40,
                              )),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Recharge balance',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontFamily: 'MontserratLight',
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                '₹$recharge',
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  fontFamily: 'MontserratBold',
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: size.height * 0.1,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xFF0291B1),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Stack(
                        children: [
                          Align(
                              alignment: Alignment.bottomRight,
                              child: Image.asset(
                                "assets/images/profits 1.png",
                                height: 40,
                              )),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Remaining balance',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontFamily: 'MontserratLight',
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                '₹$remainingBalance',
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  fontFamily: 'MontserratBold',
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xFFFFFFFF),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: FutureBuilder(
                future: _getWithdrawalsData(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (withdrawalsData.isEmpty) {
                    return const Center(
                        child: Column(
                          children: [
                            // CircularProgressIndicator(color: colors.primary),
                          ],
                        ));
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: withdrawalsData.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return SingleChildScrollView(
                            child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: size.height * 0.1,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: const Color(0xFFF1F1F9),
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: size.height * 0.07,
                                        width: size.height * 0.07,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: const Color(0xFFC6C8E9),
                                        ),
                                        padding: const EdgeInsets.all(10),
                                        child: Image.asset(
                                          "assets/images/transfer 1.png",
                                        ),
                                      ),
                                      const SizedBox(width: 15,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            withdrawalsData[index].status=="0"? "Pending": withdrawalsData[index].status=="1" ? "Completed" : "Cancelled",
                                            style: TextStyle(
                                              color: withdrawalsData[index].status=="0"? colors.primary : withdrawalsData[index].status=="1" ? const Color(0xFF31800C) : Colors.red,
                                              fontFamily: 'MontserratMedium',
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(width: 5,),
                                          Text(
                                            withdrawalsData[index].datetime,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'MontserratLight',
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Expanded(child: Container()),
                                      Text(
                                        "₹${withdrawalsData[index].amount}",
                                        style: const TextStyle(
                                          color: Colors.green,
                                          fontFamily: 'MontserratMedium',
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ),
          ],
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

  Widget buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: homeController.sliderImageURL.map((url) {
        int index = homeController.sliderImageURL.indexOf(url);
        return Container(
          width: _currentIndex == index ? 10 : 8.0,
          height: _currentIndex == index ? 10 : 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentIndex == index ? Colors.white : Colors.grey,
          ),
        );
      }).toList(),
    );
  }
}
