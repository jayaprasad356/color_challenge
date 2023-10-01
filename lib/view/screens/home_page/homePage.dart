import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:color_challenge/Helper/apiCall.dart';
import 'package:color_challenge/controller/home_controller.dart';
import 'package:color_challenge/controller/pcc_controller.dart';
import 'package:color_challenge/model/slider_data.dart';
import 'package:color_challenge/model/user.dart';
import 'package:color_challenge/controller/utils.dart';
import 'package:color_challenge/view/screens/shorts_vid/post_upload.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../util/Color.dart';
import '../../../util/Constant.dart';
import '../job/online_jobs.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
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
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    homeController.allSettingsData();

    SharedPreferences.getInstance().then((value) {
      prefs = value;
      userDeatils();
      contact_us = prefs.getString(Constant.CONTACT_US).toString();
      basic_wallet = prefs.getString(Constant.BASIC_WALLET)!;
      premium_wallet = prefs.getString(Constant.PREMIUM_WALLET)!;
      status = prefs.getString(Constant.STATUS)!;

      adsApi();
      //ads_status("status");
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
      backgroundColor: colors.secondary_color,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
          child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [colors.primary_color, colors.secondary_color],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Column(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                  items: sliderData.map((e) => sliderItems(e)).toList(),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: sliderData.map((e) {
                    int index = sliderData.indexOf(e);
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      height: 10,
                      width: _currentIndex == index ? 15 : 5,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentIndex == index
                              ? Colors.white
                              : Colors.grey),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (status == '0')
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextButton(
                      onPressed: () {
                        String? uri = prefs.getString(Constant.CONTACT_US);
                        launchUrl(
                          Uri.parse(uri!),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.pink),
                        // You can customize other styles of the button here as well
                      ),
                      child: const Text(
                        'Purchase Premium Plan',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextButton(
                    onPressed: () {
                      Get.to(const PostUpload());
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.transparent),
                      side: MaterialStateProperty.all<BorderSide>(
                        const BorderSide(
                          color: Colors.pink,
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: const Text(
                      'Post video earn Money',
                      style: TextStyle(
                        color: Colors.pink,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        String? uri = prefs.getString(Constant.JOB_DETAILS);
                        launchUrl(
                          Uri.parse(uri!),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        height: 40,
                        // width: 140,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/btnbg.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.1),
                        alignment: Alignment.center,
                        child: const Center(
                          child: Text(
                            'Job Details',
                            style: TextStyle(
                                color: colors.white,
                                fontSize: 14,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        String? uri = prefs.getString(Constant.JOB_VIDEO);
                        launchUrl(
                          Uri.parse(uri!),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        height: 40,
                        // width: 140,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/btnbg.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.1),
                        alignment: Alignment.center,
                        child: const Center(
                          child: Text(
                            'Demo Video',
                            style: TextStyle(
                                color: colors.white,
                                fontSize: 14,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      )),
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

  Widget sliderItems(SliderData sliderData) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          10,
        ),
        color: Colors.blue,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              sliderData.img,
              height: size.height * 0.26,
              fit: BoxFit.fitHeight,
            ),
          ),
          Padding(
              padding: EdgeInsets.only(
                  top: size.height * 0.2, left: size.width * 0.04),
              child: Text(
                sliderData.title,
                style: const TextStyle(
                  fontFamily: 'MontserratBold',
                  fontSize: 16,
                  color: Colors.black87,
                  // fontWeight: FontWeight.bold
                ),
              )),
        ],
      ),
    );
  }
}