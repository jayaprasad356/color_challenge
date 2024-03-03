import 'dart:async';
import 'dart:convert';

import 'package:a1_ads/Helper/apiCall.dart';
import 'package:a1_ads/controller/home_controller.dart';
import 'package:a1_ads/controller/main_screen_controller.dart';
import 'package:a1_ads/controller/pcc_controller.dart';
import 'package:a1_ads/model/jobs_show.dart';
import 'package:a1_ads/model/user.dart';
import 'package:a1_ads/reports.dart';
import 'package:a1_ads/test.dart';
import 'package:a1_ads/util/Color.dart';
import 'package:a1_ads/util/Constant.dart';
import 'package:a1_ads/controller/utils.dart';
import 'package:a1_ads/view/screens/add_screen/a1u_ads.dart';
import 'package:a1_ads/view/screens/add_screen/ads_screen.dart';
import 'package:a1_ads/view/screens/add_screen/full_time_page.dart';
import 'package:a1_ads/view/screens/home_page/homePage.dart';
import 'package:a1_ads/view/screens/home_page/shop_screen.dart';
import 'package:a1_ads/view/screens/invest/invers_screen.dart';
import 'package:a1_ads/view/screens/job/job.dart';
import 'package:a1_ads/view/screens/job/jobs.dart';
import 'package:a1_ads/view/screens/job/my_team.dart';
import 'package:a1_ads/view/screens/job/plan_screen.dart';
import 'package:a1_ads/view/screens/login/loginMobile.dart';
import 'package:a1_ads/view/screens/login/recharge_screen.dart';
import 'package:a1_ads/view/screens/notification_screen/notification_screen.dart';
import 'package:a1_ads/view/screens/notification_screen/reward.dart';
import 'package:a1_ads/view/screens/profile_screen/my_customer.dart';
import 'package:a1_ads/view/screens/profile_screen/my_profile.dart';
import 'package:a1_ads/view/screens/shorts_vid/my_offer.dart';
import 'package:a1_ads/view/screens/shorts_vid/preload_page.dart';
import 'package:a1_ads/view/screens/shorts_vid/post_upload.dart';
import 'package:a1_ads/view/screens/store/store_page.dart';
import 'package:a1_ads/view/screens/upi_screen/upiPay.dart';
import 'package:a1_ads/view/screens/upi_screen/wallet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final HomeController homeController = Get.find<HomeController>();
  final MainController mainController = Get.find<MainController>();
  final PCC c = Get.find<PCC>();
  final TextEditingController _payAmountController = TextEditingController();
  final TextEditingController _addCoinController = TextEditingController();

  int _selctedIndex = 0;
  // String title = "Invest";
  String title = "My Offer";
  String upi_id = "";
  bool _actionsVisible = false;
  bool _isHomePage = false;
  bool _isAdsPage = false;
  bool _isMorePage = false;
  bool _isJobsPage = false;
  bool _logoutVisible = false;
  bool _leftArrowVisible = false;
  bool _notificationVisible = false;
  bool _addPost = false;
  late Users user;
  late SharedPreferences prefs;
  String coins = "0";
  String balance = "";
  String status = "";
  String old_plan = "";
  String without_work = "";
  String plan = "";
  String text = 'Click here Send ScreenShoot';
  String link = 'http://t.me/Colorchallengeapp1';
  final googleSignIn = GoogleSignIn();
  late String contact_us = "";
  late String _fcmToken;
  int executionCount = 0;
  Timer? timer;
  // String referralCode = '';

  @override
  void initState() {
    super.initState();
    // setupSettings();

    // userDeatils();

    // FirebaseMessaging.instance.getToken().then((token) {
    //   setState(() {
    //     _fcmToken = token!;
    //     userDeatils();
    //   });
    //   print('FCM Token: $_fcmToken');
    // });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Handle incoming message
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
    });
    startTimer();
    // offerImage();
    // if (status == '0') {
    //   _selctedIndex = 0;
    // } else {
    //   _selctedIndex = 2;
    // }
  }

  void startTimer() {
    const int maxExecutions = 2;

    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      _initializeData();
      executionCount++;

      if (executionCount >= maxExecutions) {
        timer.cancel();
      }
    });
  }

  Future<void> _initializeData() async {
    prefs = await SharedPreferences.getInstance();
    debugPrint("===> userDetail");
    homeController.allSettingsData();
    debugPrint("===> userDetail");
    mainController.userDetail(prefs.getString(Constant.ID));
    debugPrint("===> userDetail");
    c.offerAPI(prefs.getString(Constant.ID)!);
    setState(() async {
      status = prefs.getString(Constant.STATUS)!;
      old_plan = prefs.getString(Constant.OLD_PLAN)!;
      plan = prefs.getString(Constant.PLAN)!;
      without_work = prefs.getString(Constant.WITHOUT_WORK)!;
      debugPrint("plan: $without_work");
      balance = prefs.getString(Constant.BALANCE)!;
      // referralCode = (await storeLocal.read(key: Constant.REFERRAL_CODE))!;
      // debugPrint('referralCode : $referralCode');
    });
  }

  // @override
  // void setState(VoidCallback fn) {
  //   // TODO: implement setState
  //   super.setState(fn);
  //   homeController.allSettingsData();
  //   c.offerImageURS();
  // }

  // void userDeatils() async {
  //   prefs = await SharedPreferences.getInstance();
  //   var url = Constant.USER_DETAIL_URL;
  //   Map<String, dynamic> bodyObject = {
  //     Constant.USER_ID: prefs.getString(Constant.ID),
  //     Constant.FCM_ID: _fcmToken
  //   };
  //   String jsonString = await apiCall(url, bodyObject);
  //   final Map<String, dynamic> responseJson = jsonDecode(jsonString);
  //   final dataList = responseJson['data'] as List;
  //   final Users user = Users.fromJsonNew(dataList.first);
  //   debugPrint("bodyObject: $bodyObject");
  //   debugPrint("responseJson: $responseJson");
  //   debugPrint("user id: ${user.id}");
  //
  //   prefs.setString(Constant.LOGED_IN, "true");
  //   prefs.setString(Constant.ID, user.id);
  //   prefs.setString(Constant.MOBILE, user.mobile);
  //   prefs.setString(Constant.NAME, user.name);
  //   prefs.setString(Constant.UPI, user.upi);
  //   prefs.setString(Constant.EARN, user.earn);
  //   prefs.setString(Constant.BALANCE, user.balance);
  //   prefs.setString(Constant.TODAY_ADS, user.today_ads);
  //   prefs.setString(Constant.TOTAL_ADS, user.total_ads);
  //   prefs.setString(Constant.REFERRED_BY, user.referredBy);
  //   prefs.setString(Constant.REFER_CODE, user.referCode);
  //   prefs.setString(Constant.WITHDRAWAL_STATUS, user.withdrawalStatus);
  //   prefs.setString(Constant.STATUS, user.status);
  //   prefs.setString(Constant.JOINED_DATE, user.joinedDate);
  //   prefs.setString(Constant.LAST_UPDATED, user.lastUpdated);
  //   prefs.setString(Constant.MIN_WITHDRAWAL, user.min_withdrawal);
  //   prefs.setString(Constant.HOLDER_NAME, user.holder_name);
  //   prefs.setString(Constant.ACCOUNT_NUM, user.account_num);
  //   prefs.setString(Constant.IFSC, user.ifsc);
  //   prefs.setString(Constant.BANK, user.bank);
  //   prefs.setString(Constant.BRANCH, user.branch);
  //   prefs.setString(Constant.OLD_PLAN, user.old_plan);
  //   prefs.setString(Constant.PLAN, user.plan);
  //   prefs.setString(Constant.ADS_TIME, user.ads_time);
  //   prefs.setString(Constant.ADS_COST, user.ads_cost);
  //   prefs.setString(Constant.REWARD_ADS, user.reward_ads);
  //   setState(() {
  //     status = prefs.getString(Constant.STATUS)!;
  //     old_plan = prefs.getString(Constant.OLD_PLAN)!;
  //     plan = prefs.getString(Constant.PLAN)!;
  //     balance = prefs.getString(Constant.BALANCE)!;
  //   });
  //   if (user.status == "2" || user.device_id == "0") {
  //     logout();
  //     SystemNavigator.pop();
  //   }
  // }

  void _onItemTapped(int index) {
    setState(() {
      _selctedIndex = index;
      // if (index == 1) {
      //   title = "Info";
      //   _actionsVisible = false;
      //   _logoutVisible = false;
      //   _leftArrowVisible = false;
      //   _notificationVisible = true;
      //   _addPost = false;
      // } else if (index == 2) {
      if (index == 1) {
        if (old_plan == "0" &&
            (plan == "A1" || plan == "A1S" || plan == "A1U") &&
            status == "1") {
          title = "A1 Plan";
        } else {
          title = "A2 Plan";
        }
        // title = "ADS";
        _actionsVisible = false;
        _isHomePage = false;
        _isAdsPage = false;
        _isMorePage = false;
        _isJobsPage = false;
        _logoutVisible = false;
        _leftArrowVisible = false;
        _notificationVisible = false;
        _addPost = false;
      } else if (index == 2) {
        title = "My Offer";
        _actionsVisible = false;
        _isHomePage = false;
        _isAdsPage = false;
        _isMorePage = false;
        _isJobsPage = false;
        _logoutVisible = false;
        _leftArrowVisible = false;
        _notificationVisible = false;
        _addPost = false;
        // } else if (index == 2) {
        //   title = "Invest";
        //   _actionsVisible = false;
        //   _logoutVisible = false;
        //   _leftArrowVisible = false;
        //   _notificationVisible = false;
        //   _addPost = false;
      } else if (index == 3) {
        title = "Reward";
        _actionsVisible = false;
        _isHomePage = false;
        _isAdsPage = false;
        _isMorePage = false;
        _isJobsPage = false;
        _logoutVisible = false;
        _leftArrowVisible = false;
        _notificationVisible = false;
        _addPost = false;
        // } else if (index == 3) {
        //   title = "Post";
        //   _actionsVisible = false;
        //   _logoutVisible = false;
        //   _leftArrowVisible = false;
        //   _notificationVisible = false;
        //   _addPost = false;
        // } else if (index == 3) {
        //   title = "Reports";
        //   _actionsVisible = false;
        //   _logoutVisible = false;
        //   _leftArrowVisible = false;
        //   _notificationVisible = true;
        //   _addPost = false;
      } else if (index == 4) {
        title = "Profile";
        _actionsVisible = false;
        _isHomePage = false;
        _isAdsPage = false;
        _isJobsPage = false;
        _isMorePage = false;
        _logoutVisible = true;
        _leftArrowVisible = false;
        _notificationVisible = false;
        _addPost = false;
      } else {
        title = "Home";
        _actionsVisible = true;
        _isHomePage = false;
        _isAdsPage = false;
        _isMorePage = false;
        _isJobsPage = false;
        _logoutVisible = false;
        _leftArrowVisible = false;
        _notificationVisible = false;
        _addPost = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: _isHomePage == true || _isAdsPage == true || _isMorePage == true  || _isJobsPage == true ? null : AppBar(
      //   centerTitle: true,
      //   automaticallyImplyLeading: false,
      //   flexibleSpace: Container(
      //     decoration: const BoxDecoration(
      //       gradient: LinearGradient(
      //         colors: [
      //           colors.primary_color,
      //           colors.primary_color2
      //         ], // Change these colors to your desired gradient colors
      //         begin: Alignment.topCenter,
      //         end: Alignment.bottomCenter,
      //       ),
      //     ),
      //   ),
      //   title: Text(
      //     title,
      //     style:
      //         const TextStyle(fontFamily: 'Montserra', color: colors.white),
      //   ),
      //   leading: _leftArrowVisible
      //       ? const Icon(
      //           Icons.arrow_back_outlined,
      //           color: colors.black,
      //         )
      //       : (null),
      //   actions: _actionsVisible
      //       ? [
      //           // GestureDetector(
      //           //   onTap: () {
      //           //     Navigator.push(
      //           //       context,
      //           //       MaterialPageRoute(
      //           //         builder: (context) => NotifyScreen(),
      //           //       ),
      //           //     );
      //           //   },
      //           //   child: Padding(
      //           //     padding: const EdgeInsets.all(12.0),
      //           //     child: ColorFiltered(
      //           //       colorFilter: const ColorFilter.mode(
      //           //           Colors.white, BlendMode.srcIn),
      //           //       child: Image.asset(
      //           //         "assets/images/notification.png",
      //           //         height: 24,
      //           //         width: 30,
      //           //       ),
      //           //     ),
      //           //   ),
      //           // ),
      //           Padding(
      //             padding: const EdgeInsets.only(top: 10.0),
      //             child: MaterialButton(
      //               onPressed: () {
      //                 String text = 'Hello I need help in app';
      //                 String encodedText = Uri.encodeFull(text);
      //                 String uri =
      //                     Constant.A1AdsHelpWebUrl;
      //                 launchUrl(
      //                   Uri.parse(uri),
      //                   mode: LaunchMode.inAppWebView,
      //                 );
      //               },
      //               child: Row(
      //                 mainAxisSize: MainAxisSize.min,
      //                 children: <Widget>[
      //                   Image.asset(
      //                     'assets/images/help.png', // Replace with the actual image path
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ),
      //         ]
      //       : [
      //           _logoutVisible
      //               ? GestureDetector(
      //                   onTap: () {
      //                     prefs.setString(Constant.LOGED_IN, "false");
      //                     logout();
      //                   },
      //                   child: Padding(
      //                     padding: const EdgeInsets.all(12.0),
      //                     child: ColorFiltered(
      //                       colorFilter: const ColorFilter.mode(
      //                           Colors.white, BlendMode.srcIn),
      //                       child: Image.asset(
      //                         "assets/images/logout.png",
      //                         height: 24,
      //                         width: 30,
      //                       ),
      //                     ),
      //                   ),
      //                 )
      //               : const Text(""),
      //           _notificationVisible
      //               ? GestureDetector(
      //                   onTap: () {
      //                     Navigator.push(
      //                       context,
      //                       MaterialPageRoute(
      //                         builder: (context) => const NotifyScreen(),
      //                       ),
      //                     );
      //                   },
      //                   child: Padding(
      //                     padding: const EdgeInsets.all(12.0),
      //                     child: ColorFiltered(
      //                       colorFilter: const ColorFilter.mode(
      //                           Colors.white, BlendMode.srcIn),
      //                       child: Image.asset(
      //                         "assets/images/notification.png",
      //                         height: 24,
      //                         width: 30,
      //                       ),
      //                     ),
      //                   ),
      //                 )
      //               : const Text(""),
      //           _addPost
      //               ? GestureDetector(
      //                   onTap: () {
      //                     Navigator.push(
      //                       context,
      //                       MaterialPageRoute(
      //                         builder: (context) => const PostUpload(),
      //                       ),
      //                     );
      //                   },
      //                   child: const Padding(
      //                     padding: EdgeInsets.all(12.0),
      //                     child: ColorFiltered(
      //                       colorFilter: ColorFilter.mode(
      //                           Colors.white, BlendMode.srcIn),
      //                       child: Icon(
      //                         Icons.add_box,
      //                         color: Colors.white,
      //                         size: 30,
      //                       ),
      //                     ),
      //                   ),
      //                 )
      //               : const Text(""),
      //         ],
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _selctedIndex = 2;
          });
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3000000.0),
        ),
        backgroundColor: colors.widget_color,
        child: ImageIcon(
          AssetImage(
            _selctedIndex == 2
                ? "assets/icon/ShopFilled.png"
                : "assets/icon/ShopOutlined.png",
          ),
          size: _selctedIndex == 2 ? 24 : 22,
          color: _selctedIndex == 2 ? colors.primary_color : colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // bottomNavigationBar: Container(
      //     margin: const EdgeInsets.only(bottom: 1),
      //     decoration: const BoxDecoration(
      //       borderRadius: BorderRadius.all(Radius.circular(10)),
      //       boxShadow: [
      //         BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
      //       ],
      //     ),
      //     child: ClipRRect(
      //       borderRadius: const BorderRadius.all(Radius.circular(1)),
      //       child: BottomNavigationBar(
      //         type: BottomNavigationBarType.fixed,
      //         backgroundColor: colors.primary_color,
      //         items: <BottomNavigationBarItem>[
      //           BottomNavigationBarItem(
      //             icon: ImageIcon(
      //               AssetImage(
      //                 _selctedIndex == 0
      //                     ? "assets/icon/HomeFilled.png"
      //                     : "assets/icon/homeOutlined.png",
      //               ),
      //               size: _selctedIndex == 0 ? 24 : 22,
      //               color:
      //                   _selctedIndex == 0 ? colors.widget_color : colors.white,
      //             ),
      //             abell: 'Home',
      //             backgroundColor: colors.primary_color,
      //           ),
      //           // BottomNavigationBarItem(
      //           //   icon: ImageIcon(
      //           //     const AssetImage(
      //           //       "assets/icon/Vector (1).png",
      //           //     ),
      //           //     color:
      //           //         _selctedIndex == 1 ? colors.widget_color : colors.white,
      //           //   ),
      //           //   label: "ADS",
      //           //   backgroundColor: colors.primary_color,
      //           // ),
      //           BottomNavigationBarItem(
      //             icon: ImageIcon(
      //               AssetImage(
      //                 _selctedIndex == 1
      //                     ? "assets/icon/download-removebg-preview (3).png"
      //                     : "assets/icon/download-removebg-preview (1).png",
      //               ),
      //               size: _selctedIndex == 1 ? 24 : 22,
      //               color:
      //                   _selctedIndex == 1 ? colors.widget_color : colors.white,
      //             ),
      //             label: 'Plan',
      //             backgroundColor: colors.primary_color,
      //           ),
      //           BottomNavigationBarItem(
      //             icon: ImageIcon(
      //               AssetImage(
      //                 _selctedIndex == 2
      //                     ? "assets/icon/ShopFilled.png"
      //                     : "assets/icon/ShopOutlined.png",
      //               ),
      //               size: _selctedIndex == 2 ? 24 : 22,
      //               color:
      //                   _selctedIndex == 2 ? colors.widget_color : colors.white,
      //             ),
      //             // label: 'Profile',
      //             label: 'Shop',
      //             backgroundColor: colors.white,
      //           ),
      //           BottomNavigationBarItem(
      //             icon: ImageIcon(
      //               AssetImage(
      //                 _selctedIndex == 3
      //                     ? "assets/icon/teamFilled.png"
      //                     : "assets/icon/teamOutlined.png",
      //               ),
      //               size: _selctedIndex == 3 ? 28 : 26,
      //               color:
      //                   _selctedIndex == 3 ? colors.widget_color : colors.white,
      //             ),
      //             label: 'My Team',
      //             backgroundColor: colors.primary_color,
      //           ),
      //           // BottomNavigationBarItem(
      //           //   icon: Icon(
      //           //     Icons.local_offer_outlined,
      //           //     color:
      //           //         _selctedIndex == 2 ? colors.widget_color : colors.white,
      //           //   ),
      //           //   label: 'My Offer',
      //           //   backgroundColor: colors.primary_color,
      //           // ),
      //           // BottomNavigationBarItem(
      //           //   icon: Icon(
      //           //     Icons.monetization_on,
      //           //     color: _selctedIndex == 2
      //           //         ? colors.widget_color
      //           //         : colors.white,
      //           //   ),
      //           //   label: 'Invest',
      //           //   backgroundColor: colors.primary_color,
      //           // ),
      //           // BottomNavigationBarItem(
      //           //   icon: ImageIcon(
      //           //     const AssetImage(
      //           //       "assets/images/2666513_1-removebg-preview.png",
      //           // "assets/icon/Group (1).png",
      //           // ),
      //           // color:
      //           //     _selctedIndex == 3 ? colors.widget_color : colors.white,
      //           // ),
      //           // label: 'Reward',
      //           // label: 'Jobs',
      //           // backgroundColor: colors.primary_color,
      //           // ),
      //           // BottomNavigationBarItem(
      //           //   icon: Icon(
      //           //     Icons.storefront,
      //           //     color: _selctedIndex == 2
      //           //         ? colors.widget_color
      //           //         : colors.white,
      //           //   ),
      //           //   label: 'Store',
      //           //   backgroundColor: colors.primary_color,
      //           // ),
      //           BottomNavigationBarItem(
      //               // icon: Icon(Icons.person,color: _selctedIndex == 4
      //               //     ? colors.widget_color
      //               //     : colors.white),
      //               icon: ImageIcon(
      //                 AssetImage(
      //                   _selctedIndex == 4
      //                       ? "assets/icon/moreFilled.png"
      //                       : "assets/icon/moreOutelined.png",
      //                 ),
      //                 size: _selctedIndex == 4 ? 24 : 22,
      //                 color: _selctedIndex == 4
      //                     ? colors.widget_color
      //                     : colors.white,
      //               ),
      //               // label: 'Profile',
      //               label: 'More',
      //               backgroundColor: colors.white),
      //         ],
      //         currentIndex: _selctedIndex,
      //         selectedItemColor: colors.widget_color,
      //         unselectedItemColor: colors.white,
      //         onTap: _onItemTapped,
      //       ),
      //     ),),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: colors.primary_color,
        notchMargin: 10,
        child: Container(
          margin: const EdgeInsets.only(bottom: 5),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            // boxShadow: [
            //   BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            // ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selctedIndex = 0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ImageIcon(
                            AssetImage(
                              _selctedIndex == 0
                                  ? "assets/icon/HomeFilled.png"
                                  : "assets/icon/homeOutlined.png",
                            ),
                            size: _selctedIndex == 0 ? 24 : 22,
                            color: _selctedIndex == 0
                                ? colors.widget_color
                                : colors.white,
                          ),
                          Text(
                            'Home',
                            style: TextStyle(
                              fontFamily: 'MontserratMedium',
                              color: _selctedIndex == 0
                                  ? colors.widget_color
                                  : colors.white,
                              fontSize: _selctedIndex == 0
                                  ? 14 : 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selctedIndex = 1;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ImageIcon(
                            AssetImage(
                              _selctedIndex == 1
                                  ? "assets/icon/download-removebg-preview (3).png"
                                  : "assets/icon/download-removebg-preview (1).png",
                            ),
                            size: _selctedIndex == 1 ? 24 : 22,
                            color: _selctedIndex == 1
                                ? colors.widget_color
                                : colors.white,
                          ),
                          Text(
                            'Plan',
                            style: TextStyle(
                              fontFamily: 'MontserratMedium',
                              color: _selctedIndex == 1
                                  ? colors.widget_color
                                  : colors.white,
                              fontSize: _selctedIndex == 1
                                  ? 14 : 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 25,),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selctedIndex = 3;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ImageIcon(
                            AssetImage(
                              _selctedIndex == 3
                                  ? "assets/icon/teamFilled.png"
                                  : "assets/icon/teamOutlined.png",
                            ),
                            size: _selctedIndex == 3 ? 24 : 22,
                            color: _selctedIndex == 3
                                ? colors.widget_color
                                : colors.white,
                          ),
                          Text(
                            'My Team',
                            style: TextStyle(
                              fontFamily: 'MontserratMedium',
                              color: _selctedIndex == 3
                                  ? colors.widget_color
                                  : colors.white,
                              fontSize: _selctedIndex == 3
                                  ? 14 : 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selctedIndex = 4;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ImageIcon(
                            AssetImage(
                              _selctedIndex == 4
                                  ? "assets/icon/moreFilled.png"
                                  : "assets/icon/moreOutelined.png",
                            ),
                            size: _selctedIndex == 4 ? 24 : 22,
                            color: _selctedIndex == 4
                                ? colors.widget_color
                                : colors.white,
                          ),
                          Text(
                            'More',
                            style: TextStyle(
                              fontFamily: 'MontserratMedium',
                              color: _selctedIndex == 4
                                  ? colors.widget_color
                                  : colors.white,
                              fontSize: _selctedIndex == 4
                                  ? 14 : 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF2F2F2),
      // body: getPage(_selctedIndex),
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: 80,
                width: double.infinity,
                child: Image.asset(
                  'assets/images/Ellipse 11.png',
                  fit: BoxFit.fill,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20.0, left: 30),
                child: Text(
                  'A1 - Store',
                  style: TextStyle(
                    fontFamily: 'MontserratBold',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          Expanded(child: getPage(_selctedIndex)),
        ],
      ),
    );
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

  showTopupBottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(40.0),
          ),
        ),
        builder: (context) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SizedBox(
                height: 350,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(
                        height: 30,
                      ),
                      const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Top up",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: colors.black,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Center(
                          child: Text(
                        "Current Balance",
                        style: TextStyle(fontFamily: "Montserrat"),
                      )),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                          child: Text(
                        balance,
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Montserrat",
                            color: colors.primary),
                      )),
                      const SizedBox(
                        height: 15,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text("Enter Coins"),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _payAmountController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                filled: true,
                                border: InputBorder.none,
                                hintText: '5 - 1000'),
                            style: const TextStyle(
                                backgroundColor: Colors.transparent),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MaterialButton(
                        onPressed: () {
                          String amt;
                          amt = _payAmountController.text;
                          double doubleValue = double.parse(amt);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PayPage(doubleValue)),
                          );
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
                              'Pay',
                              style: TextStyle(
                                  color: colors.white,
                                  fontSize: 18,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ]),
              ),
            ),
          );
        });
  }

  showUpiDetailSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40.0),
        ),
      ),
      builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: const SizedBox(
              height: 500, // Adjust the height according to your needs
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Add Coins",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget getPage(int index) {
    switch (index) {
      case 0:
        return const Home(); //HomePage(updateAmount: updateAmount);
      case 1:
        return const PlanScreen();
      // return const ADsScreen(); //HomePage(updateAmount: updateAmount);
      // return const A1UAds();
      // if (status == "1" &&
      //     old_plan == "0" &&
      //     (plan == "A2" || plan == "A1W")) {
      //   return const ADsScreen();
      // } else if (status == "1" &&
      //     old_plan == "0" &&
      //     (plan == "A1U" || plan == "A1S") &&
      //     without_work == '0') {
      //   return const FullTimePage();
      // } else {
      //   return const A1UAds();
      // }
      case 2:
        return const ShopScreen();
      // return const MyOffer();
      // return const JobFinder();
      // return const Jobs();
      // case 1:
      //   return const JobShow();
      // case 3:
      //   return const Jobs();
      // return const NotifyScreen();
      // return const Reward();
      case 3:
        return const MyTeam();
        // return const MyCustomer();
      case 4:
        return const MyProfile();
      default:
        return const MyProfile();
    }
  }

  void setupSettings() async {
    prefs = await SharedPreferences.getInstance();

    var response = await dataCall(Constant.SETTINGS_URL);

    String jsonDataString = response.toString();
    final jsonData = jsonDecode(jsonDataString);

    final dataList = jsonData['data'] as List;

    final datass = dataList.first;

    prefs.setString(Constant.CONTACT_US, datass[Constant.CONTACT_US]);
    prefs.setString(Constant.IMAGE, datass[Constant.IMAGE]);
    prefs.setString(Constant.REFER_BONUS, datass[Constant.REFER_BONUS]);
    prefs.setString(
        Constant.WITHDRAWAL_STATUS, datass[Constant.WITHDRAWAL_STATUS]);
    prefs.setString(
        Constant.WHATSPP_GROUP_LINK, datass[Constant.WHATSPP_GROUP_LINK]);
    // prefs.setString(
    //     Constant.JOB_VIDEO, datass[Constant.JOB_VIDEO]);
    prefs.setString(Constant.JOB_DETAILS, datass[Constant.JOB_DETAILS]);
    prefs.setString(Constant.WATCH_AD_STATUS, datass[Constant.WATCH_AD_STATUS]);
  }
  // void offerImage() async {
  //   prefs = await SharedPreferences.getInstance();
  //
  //   var response = await dataCall(Constant.OFFER_LIST);
  //
  //   String jsonDataString = response.toString();
  //   final jsonData = jsonDecode(jsonDataString);
  //
  //   final dataList = jsonData['data'] as List;
  //
  //   final datass = dataList.first;
  //   prefs.setString(Constant.OFFER_IMAGE, datass[Constant.IMAGE]);
  //
  //
  // }

  // ontop() {
  //   Clipboard.setData(ClipboardData(text: link));
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(content: Text('Copied to clipboard')),
  //   );
  //   Utils().showToast("Copied!");
  // }
  Future<void> clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  void logout() async {
    clearSharedPreferences();
    SystemNavigator.pop();
    FirebaseAuth.instance.signOut();
    Get.to(const LoginMobile(
      referCode: '',
    ));
  }
}

class WebViewExample extends StatelessWidget {
  final String initialUrl;

  WebViewExample({required this.initialUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Web App'),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(initialUrl)),
      ),
    );
  }
}
