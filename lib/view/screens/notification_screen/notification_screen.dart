import 'dart:convert';


import 'package:color_challenge/model/user.dart';
import 'package:color_challenge/controller/utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';

import '../../../util/Color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../util/Constant.dart';
import '../../../Helper/apiCall.dart';
import '../upi_screen/bank_detail_screen.dart';
import 'notifications_records.dart';


class NotifyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [colors.primary_color, colors.primary_color2], // Change these colors to your desired gradient colors
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: notification_screen(),
    );
  }
}
class notification_screen extends StatefulWidget {
  @override
  _notify_State createState() => _notify_State();
}


class _notify_State extends State<notification_screen> {

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
            child: Notifications()),
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
