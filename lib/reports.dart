import 'dart:convert';

import 'package:color_challenge/Helper/utils.dart';
import 'package:color_challenge/addupi.dart';
import 'package:color_challenge/my_withdrawal_records.dart';
import 'package:color_challenge/transactions_records.dart';
import 'package:color_challenge/user.dart';
import 'package:color_challenge/withdrawal_data.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';

import 'Helper/Color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Helper/Constant.dart';
import 'Helper/apiCall.dart';
import 'bank_detail_screen.dart';

class report extends StatefulWidget {
  const report({Key? key}) : super(key: key);

  @override
  State<report> createState() => _reportState();
}

class _reportState extends State<report> {
  final TextEditingController _withdrawalAmtController =
      TextEditingController();
  TextEditingController _upiIdController = TextEditingController();
  Utils utils = Utils();
  late SharedPreferences prefs;

  late String totalRefund = '';


  @override
  void initState() {
    // TODO: implement initState
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      setState(() {




      });
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width, // Set width to the screen width
            height: MediaQuery.of(context).size.height, // Set height to the screen height
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [colors.primary_color, colors.secondary_color],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Transactions()),
        ),
    );
  }

  void userDeatils() async {
    prefs = await SharedPreferences.getInstance();
    var url = Constant.USER_DETAIL_URL;
    Map<String, dynamic> bodyObject = {
      Constant.USER_ID: prefs.getString(Constant.ID),
    };
    String jsonString = await apiCall(url, bodyObject);
    final Map<String, dynamic> responseJson = jsonDecode(jsonString);
    final dataList = responseJson['data'] as List;
    final Users user = Users.fromJsonNew(dataList.first);

    prefs.setString(Constant.ID, user.id);
    prefs.setString(Constant.UPI, user.upi);
    prefs.setString(Constant.EARN, user.earn);
    prefs.setString(Constant.BALANCE, user.balance);
    prefs.setString(Constant.REFERRED_BY, user.referredBy);
    prefs.setString(Constant.REFER_CODE, user.referCode);
    prefs.setString(Constant.WITHDRAWAL_STATUS, user.withdrawalStatus);
    prefs.setString(Constant.STATUS, user.status);
    prefs.setString(Constant.JOINED_DATE, user.joinedDate);
    prefs.setString(Constant.LAST_UPDATED, user.lastUpdated);
    setState(() {

    });
  }

}
