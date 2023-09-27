import 'dart:convert';

import 'package:color_challenge/Helper/apiCall.dart';
import 'package:color_challenge/model/jobs_show.dart';
import 'package:color_challenge/model/user.dart';
import 'package:color_challenge/reports.dart';
import 'package:color_challenge/util/Color.dart';
import 'package:color_challenge/util/Constant.dart';
import 'package:color_challenge/controller/utils.dart';
import 'package:color_challenge/view/screens/add_screen/ads_screen.dart';
import 'package:color_challenge/view/screens/home_page/homePage.dart';
import 'package:color_challenge/view/screens/notification_screen/notification_screen.dart';
import 'package:color_challenge/view/screens/profile_screen/my_profile.dart';
import 'package:color_challenge/view/screens/shorts_vid/preload_page.dart';
import 'package:color_challenge/view/screens/shorts_vid/shorts_upload.dart';
import 'package:color_challenge/view/screens/store/store_page.dart';
import 'package:color_challenge/view/screens/upi_screen/upiPay.dart';
import 'package:color_challenge/view/screens/upi_screen/wallet.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final TextEditingController _payAmountController = TextEditingController();
  final TextEditingController _addCoinController = TextEditingController();

  int _selctedIndex = 0;
  String title = "HOME";
  String upi_id = "";
  bool _actionsVisible = true;
  bool _logoutVisible = false;
  bool _leftArrowVisible = false;
  bool _notificationVisible = false;
  bool _addPost = false;
  late Users user;
  late SharedPreferences prefs;
  String coins = "0";
  String balance = "";
  String text = 'Click here Send ScreenShoot';
  String link = 'http://t.me/Colorchallengeapp1';
  final googleSignIn = GoogleSignIn();
  late String contact_us = "";
  late String _fcmToken;

  @override
  void initState() {
    super.initState();
    setupSettings();
    FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        _fcmToken = token!;
        userDeatils();
      });
      print('FCM Token: $_fcmToken');
    });
  }

  void userDeatils() async {
    prefs = await SharedPreferences.getInstance();
    var url = Constant.USER_DETAIL_URL;
    Map<String, dynamic> bodyObject = {
      Constant.USER_ID: prefs.getString(Constant.ID),
      Constant.FCM_ID: _fcmToken
    };
    String jsonString = await apiCall(url, bodyObject);
    final Map<String, dynamic> responseJson = jsonDecode(jsonString);
    final dataList = responseJson['data'] as List;
    final Users user = Users.fromJsonNew(dataList.first);

    prefs.setString(Constant.LOGED_IN, "true");
    prefs.setString(Constant.ID, user.id);
    prefs.setString(Constant.MOBILE, user.mobile);
    prefs.setString(Constant.NAME, user.name);
    prefs.setString(Constant.UPI, user.upi);
    prefs.setString(Constant.EARN, user.earn);
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
    if (user.status == "2" || user.device_id == "0") {
      logout();
      SystemNavigator.pop();
    }
  }

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
        title = "ADS";
        _actionsVisible = false;
        _logoutVisible = false;
        _leftArrowVisible = false;
        _notificationVisible = true;
        _addPost = false;
      } else if (index == 2) {
        title = "Store";
        _actionsVisible = false;
        _logoutVisible = false;
        _leftArrowVisible = false;
        _notificationVisible = false;
        _addPost = true;
      } else if (index == 3) {
        title = "Shorts";
        _actionsVisible = false;
        _logoutVisible = false;
        _leftArrowVisible = false;
        _notificationVisible = false;
        _addPost = false;
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
        _logoutVisible = true;
        _leftArrowVisible = false;
        _notificationVisible = false;
        _addPost = false;
      } else {
        title = "Home";
        _actionsVisible = true;
        _logoutVisible = false;
        _leftArrowVisible = false;
        _notificationVisible = false;
        _addPost = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colors.primary_color,
                  colors.primary_color2
                ], // Change these colors to your desired gradient colors
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          title: Text(
            title,
            style:
                const TextStyle(fontFamily: 'Montserra', color: colors.white),
          ),
          leading: _leftArrowVisible
              ? const Icon(
                  Icons.arrow_back_outlined,
                  color: colors.black,
                )
              : (null),
          actions: _actionsVisible
              ? [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotifyScreen(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ColorFiltered(
                        colorFilter: const ColorFilter.mode(
                            Colors.white, BlendMode.srcIn),
                        child: Image.asset(
                          "assets/images/notification.png",
                          height: 24,
                          width: 30,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: MaterialButton(
                      onPressed: () {
                        String text = 'Hello I need help in app';
                        String encodedText = Uri.encodeFull(text);
                        String uri =
                            'https://wa.me/${prefs.getString(Constant.CONTACT_US)}?text=$encodedText';
                        launchUrl(
                          Uri.parse(uri),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/help.png', // Replace with the actual image path
                          ),
                        ],
                      ),
                    ),
                  ),
                ]
              : [
                  _logoutVisible
                      ? GestureDetector(
                          onTap: () {
                            prefs.setString(Constant.LOGED_IN, "false");
                            Utils().logout();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: ColorFiltered(
                              colorFilter: const ColorFilter.mode(
                                  Colors.white, BlendMode.srcIn),
                              child: Image.asset(
                                "assets/images/logout.png",
                                height: 24,
                                width: 30,
                              ),
                            ),
                          ),
                        )
                      : const Text(""),
                  _notificationVisible
                      ? GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NotifyScreen(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: ColorFiltered(
                              colorFilter: const ColorFilter.mode(
                                  Colors.white, BlendMode.srcIn),
                              child: Image.asset(
                                "assets/images/notification.png",
                                height: 24,
                                width: 30,
                              ),
                            ),
                          ),
                        )
                      : const Text(""),
                  _addPost
                      ? GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ShortsUpload(),
                              ),
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                  Colors.white, BlendMode.srcIn),
                              child: Icon(
                                Icons.add_box,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        )
                      : const Text(""),
                ],
        ),
        bottomNavigationBar: Container(
            margin: const EdgeInsets.only(bottom: 1),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black38, spreadRadius: 0, blurRadius: 10),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(1)),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: colors.primary_color,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                      const AssetImage(
                        "assets/images/home.png",
                      ),
                      color: _selctedIndex == 0
                          ? colors.widget_color
                          : colors.white,
                    ),
                    label: 'Home',
                    backgroundColor: colors.primary_color,
                  ),
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                      const AssetImage(
                        "assets/images/ADS_icon.png",
                      ),
                      color: _selctedIndex == 1
                          ? colors.widget_color
                          : colors.white,
                    ),
                    label: "ADS",
                    backgroundColor: colors.primary_color,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.storefront,
                      color: _selctedIndex == 2
                          ? colors.widget_color
                          : colors.white,
                    ),
                    label: 'Store',
                    backgroundColor: colors.primary_color,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.video_collection_outlined,
                      color: _selctedIndex == 3
                          ? colors.widget_color
                          : colors.white,
                    ),
                    label: 'Shorts',
                    backgroundColor: colors.primary_color,
                  ),
                  // BottomNavigationBarItem(
                  //   icon: ImageIcon(
                  //     const AssetImage(
                  //       "assets/images/result.png",
                  //     ),
                  //     color: _selctedIndex == 3
                  //         ? colors.widget_color
                  //         : colors.white,
                  //   ),
                  //   label: 'Reports',
                  //   backgroundColor: colors.primary_color,
                  // ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person,
                          color: _selctedIndex == 4
                              ? colors.widget_color
                              : colors.white),
                      label: 'Profile',
                      backgroundColor: colors.white),
                ],
                currentIndex: _selctedIndex,
                selectedItemColor: colors.widget_color,
                unselectedItemColor: colors.white,
                onTap: _onItemTapped,
              ),
            )),
        body: getPage(_selctedIndex));
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
        return const ADsScreen(); //HomePage(updateAmount: updateAmount);
        case 2:
        return const StorePage();
      // case 1:
      //   return const JobShow();
      case 3:
        return const PreloadPage();
      // case 3:
      //   return const report();
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
    prefs.setString(Constant.OFFER_IMAGE, datass[Constant.OFFER_IMAGE]);
    prefs.setString(Constant.REFER_BONUS, datass[Constant.REFER_BONUS]);
    prefs.setString(
        Constant.WITHDRAWAL_STATUS, datass[Constant.WITHDRAWAL_STATUS]);
  }

  ontop() {
    Clipboard.setData(ClipboardData(text: link));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied to clipboard')),
    );
    Utils().showToast("Copied!");
  }

  void logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
