// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:color_challenge/bettings.dart';
import 'package:color_challenge/login/mainScreen.dart';
import 'package:color_challenge/user.dart';
import 'package:share_plus/share_plus.dart';
import 'package:color_challenge/Helper/utils.dart';
import 'package:color_challenge/result.dart';
import 'package:color_challenge/wallet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Helper/Color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import 'Helper/Constant.dart';
import 'Helper/apiCall.dart';
import 'blinking_text.dart';
import 'colorList.dart';
import 'muChallenges.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  final void Function(String coins) updateAmount;

  const HomePage({Key? key, required this.updateAmount}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String referText = "GBD 21";
  String referCoins = "";

  Utils utils = Utils();
  String resultTime = "";
  String blinkText="";
  int leftTime=0;
  late String _fcmToken;
  final googleSignIn = GoogleSignIn();

  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      referCoins = prefs.getString(Constant.REFER_COINS)!;
    });
    FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        _fcmToken = token!;
        userDeatils();
      });
      print('FCM Token: $_fcmToken');
    });

    resultTiming();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
            child: Column(children: <Widget>[
          // Container(
          //   margin: const EdgeInsets.only(right: 20, left: 20, top: 0),
          //   child: Card(
          //     child: Padding(
          //       padding: const EdgeInsets.all(16.0),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: <Widget>[
          //            Text(
          //             "Refer  a friend and get "+referCoins+" coins",
          //             style: TextStyle(
          //                 fontSize: 16,
          //                 fontWeight: FontWeight.bold,
          //                 fontFamily: "Montserrat"),
          //           ),
          //           const SizedBox(height: 16.0),
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //             children: <Widget>[
          //               OutlinedButton(
          //                 onPressed: () {
          //                   utils.showToast("Copied !");
          //                   Clipboard.setData(ClipboardData(text: referText));
          //                 },
          //                 style: OutlinedButton.styleFrom(
          //                   shape: RoundedRectangleBorder(
          //                     borderRadius: BorderRadius.circular(6.0),
          //                     side: const BorderSide(color: colors.red),
          //                   ),
          //                 ),
          //                 child: Padding(
          //                   padding: const EdgeInsets.all(14),
          //                   child: Row(
          //                     mainAxisSize: MainAxisSize.min,
          //                     children: <Widget>[
          //                       Image.asset(
          //                         "assets/images/copy.png",
          //                         width: 24.0,
          //                         height: 24.0,
          //                       ),
          //                       const SizedBox(width: 8.0),
          //                       Text(
          //                         referText,
          //                         style: TextStyle(
          //                           color: colors.primary,
          //                           fontSize: 12.0,
          //                           fontFamily: "Montserrat",
          //                           fontWeight: FontWeight.bold,
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //               ),
          //               const SizedBox(width: 16.0),
          //               MaterialButton(
          //                 onPressed: () {
          //                   Share.share(referText + " Use my Refer Code and install this app https://play.google.com/store/apps/details?id=com.app.colorchallenge");
          //                 },
          //                 color: colors.primary,
          //                 shape: const RoundedRectangleBorder(
          //                   borderRadius:
          //                       BorderRadius.all(Radius.circular(8.0)),
          //                 ),
          //                 child: Padding(
          //                   padding:
          //                       const EdgeInsets.only(top: 16.0, bottom: 16.0),
          //                   child: Row(
          //                     mainAxisSize: MainAxisSize.min,
          //                     children: const <Widget>[
          //                       Text(
          //                         'Refer Friends',
          //                         style: TextStyle(
          //                           color: colors.white,
          //                           fontSize: 16.0,
          //                           fontWeight: FontWeight.bold,
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          SizedBox(
            height: 10,
          ),
          BlinkingText(
            text: blinkText,
          ),
          Text(
            resultTime,
            style: TextStyle(
                fontSize: 16,
                color: colors.cc_green,
                fontWeight: FontWeight.bold,
                fontFamily: "Montserrat"),
          ),
          ColorList(updateAmount: widget.updateAmount),
          SizedBox(
            height: 20,
          ),
          Bettings(),
        ])),
      ),
    );
  }

  showTopupBottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
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
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                          child: Text(
                        "Current Balance",
                        style: TextStyle(fontFamily: "Montserrat"),
                      )),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                          child: Text(
                        "500.00",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Montserrat",
                            color: colors.primary),
                      )),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text("Enter Coins"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            decoration: const InputDecoration(
                                filled: true,
                                border: InputBorder.none,
                                hintText: '5 - 1000'),
                            style: const TextStyle(
                                backgroundColor: Colors.transparent),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MaterialButton(
                        onPressed: () {
                          showSuccesDialog();
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

  showSuccesDialog() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Center(
            child: const Text(
          'Successfully challenged',
          style:
              TextStyle(fontFamily: "Montserrat", fontWeight: FontWeight.bold),
        )),
        content: Image.asset(
          "assets/images/success.png",
          height: 80,
          width: 80,
        ),
      ),
    );
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
    prefs.setString(Constant.UPI, user.upi);
    prefs.setString(Constant.EARN, user.earn);
    prefs.setString(Constant.COINS, user.coins);
    prefs.setString(Constant.BALANCE, user.balance);
    prefs.setString(Constant.REFERRED_BY, user.referredBy);
    prefs.setString(Constant.REFER_CODE, user.referCode);
    prefs.setString(Constant.WITHDRAWAL_STATUS, user.withdrawalStatus);
    prefs.setString(Constant.CHALLENGE_STATUS, user.challengeStatus);
    prefs.setString(Constant.STATUS, user.status);
    prefs.setString(Constant.JOINED_DATE, user.joinedDate);
    prefs.setString(Constant.LAST_UPDATED, user.lastUpdated);
    if(user.status=="0"){
      logout();
      SystemNavigator.pop();
    }
    setState(() {
      referText = prefs.getString(Constant.REFER_CODE)!;
    });
  }

  void resultTiming() async {
    prefs = await SharedPreferences.getInstance();
    var url = Constant.RESULT_TIME_URL;

    String jsonString = await dataCall(url);
    final Map<String, dynamic> responseJson = jsonDecode(jsonString);
    final dateTime =responseJson['result_announce_time'];
    DateTime date = DateTime.parse(dateTime);
    final formattedTime = DateFormat('h:mm a').format(date);

    setState(() {
      resultTime ="Today $formattedTime";
      leftTime = responseJson["time_diff"];
      blinkText="Result Annouce in ${leftTime} Min";
    });
  }
  void logout() async {
    prefs.setString(Constant.LOGED_IN, "false");
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
