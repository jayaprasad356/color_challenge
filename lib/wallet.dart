import 'dart:convert';

import 'package:color_challenge/Helper/utils.dart';
import 'package:color_challenge/addupi.dart';
import 'package:color_challenge/my_withdrawal_records.dart';
import 'package:color_challenge/user.dart';
import 'package:color_challenge/withdrawal_data.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'Helper/Color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Helper/Constant.dart';
import 'Helper/apiCall.dart';

class wallet extends StatefulWidget {
  const wallet({Key? key}) : super(key: key);

  @override
  State<wallet> createState() => _walletState();
}

class _walletState extends State<wallet> {
  final TextEditingController _withdrawalAmtController =
      TextEditingController();
  TextEditingController _upiIdController = TextEditingController();
  Utils utils = Utils();
  late SharedPreferences prefs;
  String balance = "";
  String minimum = "";
  String name = "";
  String mobile = "";
  String earn = "";

  late String _upiId;
  late String _fcmToken;

  @override
  void initState() {
    // TODO: implement initState
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      setState(() {
        balance = prefs.getString(Constant.BALANCE)!;
        minimum = prefs.getString(Constant.MIN_WITHDRAWAL)!;
        _upiIdController.text = prefs.getString(Constant.UPI)!;
        mobile = prefs.getString(Constant.MOBILE).toString();
        earn = prefs.getString(Constant.EARN).toString();
        name=prefs.getString(Constant.NAME).toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool _isDisabled = true;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: colors.white,
          child: Column(
            children: [
              Container(
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: colors.light_greyss
                  ),
                  margin: EdgeInsets.only(right: 10,left: 10),
                 // color: colors.greyss,
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage("assets/images/profile.png"),
                        radius: 30,
                      ),
                      SizedBox(width: 18),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            mobile,
                            style: TextStyle(
                              fontSize: 16,
                                color: colors.black
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Total Earnings = Rs.'+earn,
                            style: TextStyle(
                                fontSize: 16,
                                color: colors.black
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10,),

                    const Text(
                      "My Balance",
                      style: TextStyle(
                          fontSize: 14,
                          color: colors.greyss,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Montserrat"),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "₹$balance",
                      style: const TextStyle(
                          fontSize: 24,
                          color: colors.primary,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Montserra"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                child: const Text(
                                  "UPI ID",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: colors.black,
                                      fontFamily: "Montserra"),
                                ),
                              ),
                            ),
                          ],
                        )),
                    Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 4),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12.0)),
                            child: IgnorePointer(
                              ignoring: _isDisabled,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: _upiIdController,
                                decoration: const InputDecoration(
                                  filled: true,
                                  border: InputBorder.none,
                                ),
                                style: const TextStyle(
                                    backgroundColor: Colors.transparent),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          bottom: 0,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: IconButton(
                              icon: Icon(
                                _isDisabled ? Icons.edit : Icons.check,
                                color: colors.primary,
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      buildUpdateUpiDialog(context,
                                          (String upiId) {
                                    // update the UPI ID here using the upiId parameter
                                    // ...
                                  }),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                child: const Text(
                                  "Withdrawal Amount",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: colors.black,
                                      fontFamily: "Montserra"),
                                ),
                              ),
                            ),
                          ],
                        )),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 4),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12.0)),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _withdrawalAmtController,
                          decoration: const InputDecoration(
                            filled: true,
                            border: InputBorder.none,
                            hintText: '₹ Please Input',
                          ),
                          style: const TextStyle(
                              backgroundColor: Colors.transparent),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: RichText(
                          text: TextSpan(
                            text: "Minimum : ",
                            style: const TextStyle(
                                color: colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Montserrat"),
                            children: [
                              TextSpan(
                                text: "₹$minimum",
                                style: const TextStyle(
                                    color: colors.primary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Montserrat"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      onPressed: () {
                        double withdrawalAmt =
                            double.tryParse(_withdrawalAmtController.text) ??
                                0.0;
                        double minimumAmt =
                            double.tryParse(minimum) ??
                                0.0;
                        if (withdrawalAmt < minimumAmt) {
                          utils.showToast("please enter minimum $minimum");
                        } else {
                          doWithdrawal();
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        height: 80,
                        width: double.infinity,
                        margin: const EdgeInsets.only(left: 10),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/Verify.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Withdrawal',
                            style: TextStyle(
                                fontSize: 14,
                                color: colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Montserrat"),
                          ),
                        ),
                      ),
                    ),
                    Container(
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 15),
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                child: const Text(
                                  "Withdrawal Record",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: colors.black,
                                      fontFamily: "Montserra"),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
              MyWithdrawals()
            ],
          ),
        ),
      ),
    );
  }

  void doWithdrawal() async {
    prefs = await SharedPreferences.getInstance();
    var url = Constant.WITHDRAWAL_URL;
    Map<String, dynamic> bodyObject = {
      Constant.USER_ID: prefs.getString(Constant.ID),
      Constant.AMOUNT: _withdrawalAmtController.text,
      Constant.TYPE: Constant.DEBIT,
    };
    String jsonString = await apiCall(url, bodyObject);
    final jsonResponse = jsonDecode(jsonString);
    final message = jsonResponse['message'];
    final status = jsonResponse['success'];

    if (status) {
      FirebaseMessaging.instance.getToken().then((token) {
        setState(() {
          _fcmToken = token!;
          userDeatils();
        });
        print('FCM Token: $_fcmToken');
      });
      setState(() {
        _withdrawalAmtController.text = "";
      });
    }
    utils.showToast(message);
  }

  void updateUpi(String upi) async {
    prefs = await SharedPreferences.getInstance();

    var url = Constant.UPDATE_UPI_URL;
    Map<String, dynamic> bodyObject = {
      Constant.USER_ID: prefs.getString(Constant.ID),
      Constant.UPI: upi
    };
    String jsonString = await apiCall(url, bodyObject);
    final jsonData = jsonDecode(jsonString);
    Utils().showToast(jsonData["message"]);
    final dataList = jsonData['data'] as List;
    if (jsonData["success"]) {
      final datass = dataList.first;
      setState(() {
        String upi_id = datass[Constant.UPI];
        prefs.setString(Constant.UPI, datass[Constant.UPI]);
        _upiIdController.text = upi_id;
      });
    }
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
    setState(() {
      balance = user.balance!;
    });
  }

  Widget buildUpdateUpiDialog(
      BuildContext context, void Function(String) upiIdCallback) {
    final TextEditingController _enterupiController = TextEditingController();

    return AlertDialog(
      title: const Center(
        child: Text(
          'Enter UPI ID',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            child: TextField(
              keyboardType: TextInputType.text,
              controller: _enterupiController,
              decoration: const InputDecoration(
                filled: true,
                border: InputBorder.none,
                hintText: 'testupibankid@okaxis,com',
              ),
              style: const TextStyle(
                backgroundColor: Colors.transparent,
              ),
              enabled:
                  true, // set to false if you want the text field to be disabled
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              String upi = _enterupiController.text;
              updateUpi(upi);

              Navigator.pop(context);
            },
            child: const Text(
              'Update UPI',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: colors.primary, // set button background color here
            ),
          ),
        ],
      ),
    );
  }
}
