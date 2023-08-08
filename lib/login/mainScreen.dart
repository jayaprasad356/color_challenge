import 'dart:convert';

import 'package:color_challenge/coinList.dart';
import 'package:color_challenge/contest_ad.dart';
import 'package:color_challenge/jobs_show.dart';
import 'package:color_challenge/muChallenges.dart';
import 'package:color_challenge/online_jobs.dart';
import 'package:color_challenge/result.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Helper/Color.dart';
import '../Helper/Constant.dart';
import '../Helper/apiCall.dart';
import '../Helper/utils.dart';
import '../generate_coins.dart';
import '../homePage.dart';
import '../my_challenges.dart';
import '../task_show.dart';
import '../trial_ad.dart';
import '../upiPay.dart';
import '../user.dart';
import '../wallet.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController _payAmountController = TextEditingController();
  TextEditingController _addCoinController = TextEditingController();

  int _selctedIndex = 0;
  String title = "HOME";
  String upi_id = "";
  bool _actionsVisible = true;
  bool _logoutVisible = false;
  bool _leftArrowVisible = false;
  late Users user;
  late SharedPreferences prefs;
  String coins = "0";
  String balance = "";
  String mailId = "";
  String text = 'Click here Send ScreenShoot';
  String link = 'http://t.me/Colorchallengeapp1';
  final googleSignIn = GoogleSignIn();
  late String contact_us;
  late String _fcmToken;


  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      setupSettings();
      setState(() {

        coins = prefs.getString(Constant.COINS)!;
        balance = prefs.getString(Constant.BALANCE)!;
        mailId = prefs.getString(Constant.EMAIL)!;
        contact_us = prefs.getString(Constant.CONTACT_US).toString();
      });
    });
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
      Constant.FCM_ID:_fcmToken
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
    if(user.status=="2" || user.device_id=="0"){
      logout();
      SystemNavigator.pop();
    }
  }


  void _onItemTapped(int index) {
    setState(() {
      _selctedIndex = index;
      if (index == 2) {
        title = "Wallet";
        _actionsVisible = false;
        _logoutVisible = true;
        _leftArrowVisible = false;
      } else if (index == 1) {
        title = "Info";
        _actionsVisible = false;
        _logoutVisible = false;
        _leftArrowVisible = false;
      } else if (index == 3) {
        title = "wallet";
        _actionsVisible = false;
        _logoutVisible = true;
        _leftArrowVisible = false;
      } else {
        title = "HOME";
        _actionsVisible = true;
        _logoutVisible = false;
        _leftArrowVisible = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: colors.white,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            title,
            style:
                const TextStyle(fontFamily: 'Montserra', color: colors.black),
          ),
          leading: _leftArrowVisible
              ? const Icon(
                  Icons.arrow_back_outlined,
                  color: colors.black,
                )
              : (null),
          actions: _actionsVisible
              ? [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                onPressed:() {
                  String text =
                      'Hello I need help in app';

                  // Encode the text for the URL
                  String encodedText = Uri.encodeFull(text);
                  String uri =
                      'https://wa.me/$contact_us?text=$encodedText';
                  launchUrl(
                    Uri.parse(uri),
                    mode: LaunchMode.externalApplication,
                  );
                },
                color:  colors.cc_green,

                shape: const RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Padding(
                  padding:
                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Help',
                        style: TextStyle(
                          color: colors.white,
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
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
                            child: Image.asset(
                              "assets/images/logout.png",
                              height: 24,
                              width: 30,
                            ),
                          ),
                        )
                      : const Text("")
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
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                      const AssetImage(
                        "assets/images/home.png",
                      ),
                      color: _selctedIndex == 0 ? colors.primary : colors.black,
                    ),
                    label: 'Home',
                    backgroundColor: colors.white,
                  ),
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                      const AssetImage(
                        "assets/images/challenge.png",
                      ),
                      color: _selctedIndex == 1 ? colors.primary : colors.black,
                    ),
                    label: 'Info',
                    backgroundColor: colors.white,
                  ),
                  // BottomNavigationBarItem(
                  //     icon: ImageIcon(
                  //         const AssetImage("assets/images/result.png"),
                  //         color: _selctedIndex == 2
                  //             ? colors.primary
                  //             : colors.black),
                  //     label: 'Task',
                  //     backgroundColor: colors.white),
                  BottomNavigationBarItem(
                      icon: ImageIcon(
                          const AssetImage("assets/images/Wallet.png"),
                          color: _selctedIndex == 2
                              ? colors.primary
                              : colors.black),
                      label: 'Wallet',
                      backgroundColor: colors.white),
                ],
                currentIndex: _selctedIndex,
                selectedItemColor: colors.primary,
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
              child: Container(
                height: 350,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
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
            child: Container(
              height: 500, // Adjust the height according to your needs
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
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
                  const SizedBox(
                    height: 20,
                  ),
                  CoinList(),
                  // todo below lines are commented for card view implementation
                  // Padding(
                  //   padding: const EdgeInsets.only(right: 30.0, left: 30.0),
                  //   child: ClipRRect(
                  //     borderRadius:
                  //     const BorderRadius.all(Radius.circular(12.0)),
                  //     child: TextField(
                  //       keyboardType: TextInputType.number,
                  //       controller: _addCoinController,
                  //       decoration: const InputDecoration(
                  //         filled: true,
                  //         border: InputBorder.none,
                  //         hintText: 'Enter Coins1',
                  //       ),
                  //       style: const TextStyle(
                  //         backgroundColor: Colors.transparent,
                  //       ),
                  //       enabled:
                  //       true, // set to false if you want the text field to be disabled
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // Center(
                  //   child: MaterialButton(
                  //     onPressed: () {
                  //       if (_addCoinController.text.isNotEmpty) {
                  //         String messageText =
                  //             "Please add ${_addCoinController.text} coins... \n$mailId";
                  //         link = '$link&text=${Uri.encodeFull(messageText)}';
                  //         launch(link);
                  //         _addCoinController.text = "";
                  //       } else {
                  //         Utils().showToast("Please Enter Coins");
                  //       }
                  //     },
                  //     color: colors.primary,
                  //     shape: const RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  //     ),
                  //     child: Padding(
                  //       padding: const EdgeInsets.only(
                  //           top: 16.0, bottom: 16.0),
                  //       child: Row(
                  //         mainAxisSize: MainAxisSize.min,
                  //         children: const <Widget>[
                  //           Text(
                  //             'Add Coins',
                  //             style: TextStyle(
                  //               color: Colors.white,
                  //               fontSize: 16.0,
                  //               fontWeight: FontWeight.bold,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: <Widget>[
                  //     Expanded(
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(0),
                  //         child: Card(
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(12.0),
                  //           ),
                  //           child: Container(
                  //             height: 160,
                  //             width: double.infinity,
                  //             padding: const EdgeInsets.all(0),
                  //             margin: EdgeInsets.all(4),
                  //             child: Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 const SizedBox(height: 12.0),
                  //
                  //                 Center(
                  //                   child: Image.asset(
                  //                     "assets/images/multidoller.png",
                  //                     height: 40,
                  //                     width: 40,
                  //                   ),
                  //                 ),
                  //                 const SizedBox(height: 15.0),
                  //                 const Center(
                  //                   child: Text(
                  //                     '4500 ',
                  //                     style: TextStyle(
                  //                       fontSize: 16,
                  //                       fontWeight: FontWeight.bold,
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 const SizedBox(height: 12.0),
                  //                 const Center(
                  //                   child: Text(
                  //                     '4500',
                  //                     style: TextStyle(
                  //                       fontSize: 16,
                  //                       fontWeight: FontWeight.bold,
                  //                       decoration: TextDecoration.lineThrough,
                  //                       color: Colors.grey,
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 const Spacer(), // Added Spacer to push '125' to the bottom
                  //                 Container(
                  //                   color: Colors.grey, // Change to desired background color
                  //                   child: Center(
                  //                     child: Padding(
                  //                       padding: const EdgeInsets.symmetric(vertical: 8.0),
                  //                       child: Text(
                  //                         '125',
                  //                         style: TextStyle(
                  //                           fontSize: 16,
                  //                           fontWeight: FontWeight.bold,
                  //                           color: Colors.white,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     Expanded(
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(0),
                  //         child: Card(
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(12.0),
                  //           ),
                  //           child: Container(
                  //             height: 160,
                  //             width: double.infinity,
                  //             padding: const EdgeInsets.all(0),
                  //             margin: EdgeInsets.all(4),
                  //             child: Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 const SizedBox(height: 12.0),
                  //
                  //                 Center(
                  //                   child: Image.asset(
                  //                     "assets/images/multidoller.png",
                  //                     height: 40,
                  //                     width: 40,
                  //                   ),
                  //                 ),
                  //                 const SizedBox(height: 15.0),
                  //                 const Center(
                  //                   child: Text(
                  //                     '4500 ',
                  //                     style: TextStyle(
                  //                       fontSize: 16,
                  //                       fontWeight: FontWeight.bold,
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 const SizedBox(height: 12.0),
                  //                 const Center(
                  //                   child: Text(
                  //                     '4500',
                  //                     style: TextStyle(
                  //                       fontSize: 16,
                  //                       fontWeight: FontWeight.bold,
                  //                       decoration: TextDecoration.lineThrough,
                  //                       color: Colors.grey,
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 const Spacer(), // Added Spacer to push '125' to the bottom
                  //                 Container(
                  //                   color: Colors.grey, // Change to desired background color
                  //                   child: Center(
                  //                     child: Padding(
                  //                       padding: const EdgeInsets.symmetric(vertical: 8.0),
                  //                       child: Text(
                  //                         '125',
                  //                         style: TextStyle(
                  //                           fontSize: 16,
                  //                           fontWeight: FontWeight.bold,
                  //                           color: Colors.white,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: <Widget>[
                  //     Expanded(
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(0),
                  //         child: Card(
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(12.0),
                  //           ),
                  //           child: Container(
                  //             height: 160,
                  //             width: double.infinity,
                  //             padding: const EdgeInsets.all(0),
                  //             margin: EdgeInsets.all(4),
                  //             child: Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 const SizedBox(height: 12.0),
                  //
                  //                 Center(
                  //                   child: Image.asset(
                  //                     "assets/images/multidoller.png",
                  //                     height: 40,
                  //                     width: 40,
                  //                   ),
                  //                 ),
                  //                 const SizedBox(height: 15.0),
                  //                 const Center(
                  //                   child: Text(
                  //                     '4500 ',
                  //                     style: TextStyle(
                  //                       fontSize: 16,
                  //                       fontWeight: FontWeight.bold,
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 const SizedBox(height: 12.0),
                  //                 const Center(
                  //                   child: Text(
                  //                     '4500',
                  //                     style: TextStyle(
                  //                       fontSize: 16,
                  //                       fontWeight: FontWeight.bold,
                  //                       decoration: TextDecoration.lineThrough,
                  //                       color: Colors.grey,
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 const Spacer(), // Added Spacer to push '125' to the bottom
                  //                 Container(
                  //                   color: Colors.grey, // Change to desired background color
                  //                   child: Center(
                  //                     child: Padding(
                  //                       padding: const EdgeInsets.symmetric(vertical: 8.0),
                  //                       child: Text(
                  //                         '125',
                  //                         style: TextStyle(
                  //                           fontSize: 16,
                  //                           fontWeight: FontWeight.bold,
                  //                           color: Colors.white,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     Expanded(
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(0),
                  //         child: Card(
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(12.0),
                  //           ),
                  //           child: Container(
                  //             height: 160,
                  //             width: double.infinity,
                  //             padding: const EdgeInsets.all(0),
                  //             margin: EdgeInsets.all(4),
                  //             child: Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 const SizedBox(height: 12.0),
                  //
                  //                 Center(
                  //                   child: Image.asset(
                  //                     "assets/images/multidoller.png",
                  //                     height: 40,
                  //                     width: 40,
                  //                   ),
                  //                 ),
                  //                 const SizedBox(height: 15.0),
                  //                 const Center(
                  //                   child: Text(
                  //                     '4500 ',
                  //                     style: TextStyle(
                  //                       fontSize: 16,
                  //                       fontWeight: FontWeight.bold,
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 const SizedBox(height: 12.0),
                  //                 const Center(
                  //                   child: Text(
                  //                     '4500',
                  //                     style: TextStyle(
                  //                       fontSize: 16,
                  //                       fontWeight: FontWeight.bold,
                  //                       decoration: TextDecoration.lineThrough,
                  //                       color: Colors.grey,
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 const Spacer(), // Added Spacer to push '125' to the bottom
                  //                 Container(
                  //                   color: Colors.grey, // Change to desired background color
                  //                   child: Center(
                  //                     child: Padding(
                  //                       padding: const EdgeInsets.symmetric(vertical: 8.0),
                  //                       child: Text(
                  //                         '125',
                  //                         style: TextStyle(
                  //                           fontSize: 16,
                  //                           fontWeight: FontWeight.bold,
                  //                           color: Colors.white,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
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
        return TrialAd();//HomePage(updateAmount: updateAmount);
      case 1:
        return const JobShow();
      case 2:
        return const wallet();
      default:
        return const wallet();
    }
  }

  void setupSettings() async {
    prefs = await SharedPreferences.getInstance();

    var response = await dataCall(Constant.SETTINGS_URL);

    String jsonDataString = response.toString();
    final jsonData = jsonDecode(jsonDataString);

    final dataList = jsonData['data'] as List;

    final datass = dataList.first;
    setState(() {
      upi_id=datass[Constant.UPI];
      link=datass[Constant.CONTACT_US];
    });
    prefs.setString(
        Constant.CONTACT_US, datass[Constant.CONTACT_US]);
    prefs.setString(
        Constant.IMAGE, datass[Constant.IMAGE]);
    prefs.setString(
        Constant.WITHDRAWAL_STATUS, datass[Constant.WITHDRAWAL_STATUS]);
    // prefs.setString(
    //     Constant.REFER_COINS, datass[Constant.REFER_COINS]);
    prefs.setString(
        Constant.CHALLENGE_STATUS, datass[Constant.CHALLENGE_STATUS]);
   // prefs.setString(Constant.REGISTER_POINTS, datass[Constant.REGISTER_POINTS]);
    //prefs.setString(Constant.MIN_WITHDRAWAL, datass[Constant.MIN_WITHDRAWAL]);
    prefs.setString(Constant.MIN_DP_COINS, datass[Constant.MIN_DP_COINS]);
    prefs.setString(Constant.MAX_DP_COINS, datass[Constant.MAX_DP_COINS]);

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
