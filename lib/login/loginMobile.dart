import 'dart:convert';

import 'package:color_challenge/login/otpVerfication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Helper/Color.dart';
import '../Helper/Constant.dart';
import '../Helper/apiCall.dart';
import '../user.dart';
import 'mainScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginMobile extends StatefulWidget {
  const LoginMobile({Key? key}) : super(key: key);

  @override
  State<LoginMobile> createState() => _LoginMobileState();
}

class _LoginMobileState extends State<LoginMobile> {
  final TextEditingController _mobileNumberController = TextEditingController();
  late SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: colors.white,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 250),
              Image.asset(
                "assets/images/app_logo.png",
                height: 130,
                width: 150,
              ),
              const SizedBox(height: 50),
              //todo login Text view
              const Text(
                "Log in",
                style: TextStyle(
                    fontSize: 24,
                    color: colors.black,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 60),
              //todo description text view
              const Text(
                "Enter Mobile Number",
                style: TextStyle(
                    fontSize: 18,
                    color: colors.greyss,
                    fontFamily: "Montserrat"),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Material(
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    controller: _mobileNumberController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: colors.primary),
                      ),
                    ),
                    style: const TextStyle(backgroundColor: Colors.transparent),
                  ),
                ),
              ),
              const SizedBox(height: 60),
              MaterialButton(
                onPressed: () async {
                  var url = Constant.CHECK_MOBILE;
                  Map<String, dynamic> bodyObject = {
                    Constant.MOBILE: _mobileNumberController.text,
                  };
                  String jsonString = await apiCall(url, bodyObject);
                  dynamic json = jsonDecode(jsonString);
                  bool status = json["registered"];
                  prefs = await SharedPreferences.getInstance();
                  prefs.setString(Constant.MOBILE, _mobileNumberController.text);
                  if (status) {
                      newRegister();
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OtpVerification(),
                      ),
                    );
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
                      'Log in',
                      style: TextStyle(
                          color: colors.white,
                          fontSize: 18,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  newRegister() async {
    var url = Constant.LOGIN_URL;
    Map<String, dynamic> bodyObject = {
      Constant.MOBILE: _mobileNumberController.text,
    };
    String jsonString = await apiCall(url, bodyObject);
    final Map<String, dynamic> responseJson = jsonDecode(jsonString);
    final dataList = responseJson['data'] as List;
    final User user = User.fromJsonNew(dataList.first);

    prefs.setString(Constant.LOGED_IN, "true");
    prefs.setString(Constant.ID, user.id);
    prefs.setString(Constant.MOBILE, user.mobile);
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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MainScreen(),
      ),
    );
  }
}
