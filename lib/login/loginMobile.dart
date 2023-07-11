import 'dart:convert';
import 'dart:math';

import 'package:color_challenge/Helper/utils.dart';
import 'package:color_challenge/login/otpVerfication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Helper/Color.dart';
import '../Helper/Constant.dart';
import '../Helper/apiCall.dart';
import '../user.dart';
import 'mainScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:device_info/device_info.dart';

class LoginMobile extends StatefulWidget {
  const LoginMobile({Key? key}) : super(key: key);

  @override
  State<LoginMobile> createState() => _LoginMobileState();
}

class _LoginMobileState extends State<LoginMobile> {
  final TextEditingController _referCodeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  late SharedPreferences prefs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
  bool isSigningIn = false;
  String email = "";
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  int randomNumber = Random().nextInt(900000) + 100000;
  late String contact_us;


  @override
  void initState() {
    super.initState();
    setState(() {
      setupSettings();
    });
  }

  void setupSettings() async {
    prefs = await SharedPreferences.getInstance();

    var response = await dataCall(Constant.SETTINGS_URL);

    String jsonDataString = response.toString();
    final jsonData = jsonDecode(jsonDataString);

    final dataList = jsonData['data'] as List;

    final datass = dataList.first;
    contact_us = datass[Constant.CONTACT_US];

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: colors.white,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 150),
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
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                  if (_mobileNumberController.text.isEmpty) {
                    Utils().showToast("Please Enter Mobile Number");
                  } else if (_mobileNumberController.text.length < 10) {
                    Utils().showToast("Please Enter Valid Mobile Number");
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          if(_mobileNumberController.text.toString() != '8778624681'){
                            otpsuccess();

                          }

                          return OtpVerification(mobileNumber: _mobileNumberController.text, otp: randomNumber.toString()); // Replace NextPage with the actual page you want to navigate to
                        },
                      ),
                    );
                  }

                  // var url = Constant.CHECK_MOBILE;
                  // Map<String, dynamic> bodyObject = {
                  //   Constant.MOBILE: _mobileNumberController.text,
                  // };
                  // String jsonString = await apiCall(url, bodyObject);
                  // dynamic json = jsonDecode(jsonString);
                  // bool status = json["registered"];
                  // prefs = await SharedPreferences.getInstance();
                  // prefs.setString(Constant.MOBILE, _mobileNumberController.text);
                  // if (status) {
                  //     newRegister();
                  // } else {
                  //
                  //
                  // }
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
              ),
              // MaterialButton(
              //   onPressed: () async {
              //     login();
              //   },
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: Container(
              //     margin: const EdgeInsets.only(left: 10),
              //     height: 80,
              //     width: double.infinity,
              //     decoration: const BoxDecoration(
              //       image: DecorationImage(
              //         image: AssetImage("assets/images/Verify.png"),
              //         fit: BoxFit.fill,
              //       ),
              //     ),
              //     // child: const Center(
              //     //   child: Text(
              //     //     'Google Signin',
              //     //     style: TextStyle(
              //     //         color: colors.white,
              //     //         fontSize: 18,
              //     //         fontFamily: "Montserrat",
              //     //         fontWeight: FontWeight.bold),
              //     //   ),
              //     // ),
              //   ),
              // ),
              // const SizedBox(height: 280),

              // MaterialButton(
              //   onPressed: () {
              //    // launch(link);
              //    // showSuccesDialog();
              //   },
              //   color: colors.cc_telegram,
              //   shape: const RoundedRectangleBorder(
              //     borderRadius:
              //     BorderRadius.all(Radius.circular(8.0)),
              //   ),
              //   child: Padding(
              //     padding:
              //     const EdgeInsets.only(top: 16.0, bottom: 16.0),
              //     child: Row(
              //       mainAxisSize: MainAxisSize.min,
              //       children: const <Widget>[
              //         Text(
              //           'Join Our Telegram Channel',
              //           style: TextStyle(
              //             color: colors.white,
              //             fontSize: 16.0,
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              const SizedBox(height: 30),
              MaterialButton(
                onPressed: () {
                  String text =
                      'Hello, I Need Help';

                  // Encode the text for the URL
                  String encodedText = Uri.encodeFull(text);
                  String uri =
                      'https://wa.me/$contact_us?text=$encodedText';
                  launchUrl(
                    Uri.parse(uri),
                    mode: LaunchMode.externalApplication,
                  );

                },
                color: colors.cc_whatsapp,
                shape: const RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Padding(
                  padding:
                  const EdgeInsets.only(top: 16.0, bottom: 16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const <Widget>[
                      Text(
                        'Chat Support',
                        style: TextStyle(
                          color: colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // newRegister() async {
  //   AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
  //   String deviceId = androidInfo.androidId;
  //   Utils().showToast(deviceId);
  //   prefs = await SharedPreferences.getInstance();
  //   var url = Constant.REGISTER_URL;
  //   Map<String, dynamic> bodyObject = {
  //     Constant.EMAIL: email,
  //     Constant.NAME: _nameController.text.toString(),
  //     Constant.DEVICE_ID: deviceId
  //   };
  //
  //   if (_referCodeController.text.isNotEmpty) {
  //     bodyObject[Constant.REFERRED_BY] = _referCodeController.text;
  //   }
  //   String jsonString = await apiCall(url, bodyObject);
  //   final Map<String, dynamic> responseJson = jsonDecode(jsonString);
  //   final dataList = responseJson['data'] as List;
  //   final Users user = Users.fromJsonNew(dataList.first);
  //
  //   prefs.setString(Constant.LOGED_IN, "true");
  //   prefs.setString(Constant.ID, user.id);
  //   prefs.setString(Constant.EARN, user.earn);
  //   prefs.setString(Constant.COINS, user.coins);
  //   prefs.setString(Constant.EMAIL, user.mobile);
  //   prefs.setString(Constant.NAME, user.name);
  //   prefs.setString(Constant.BALANCE, user.balance);
  //   prefs.setString(Constant.REFERRED_BY, user.referredBy);
  //   prefs.setString(Constant.REFER_CODE, user.referCode);
  //   prefs.setString(Constant.WITHDRAWAL_STATUS, user.withdrawalStatus);
  //   prefs.setString(Constant.CHALLENGE_STATUS, user.challengeStatus);
  //   prefs.setString(Constant.STATUS, user.status);
  //   prefs.setString(Constant.JOINED_DATE, user.joinedDate);
  //   prefs.setString(Constant.LAST_UPDATED, user.lastUpdated);
  //   Navigator.pushAndRemoveUntil(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => MainScreen(),
  //     ),
  //         (_) => false, // Remove all the previous routes.
  //   );
  // }

  otpsuccess() async {
    Map<String, dynamic> bodyObject = {
      Constant.EMAIL: 'dsds',
    };

    if (_referCodeController.text.isNotEmpty) {
      bodyObject[Constant.REFERRED_BY] = _referCodeController.text;
    }
    String jsonString = await apiCall("https://api.authkey.io/request?authkey=b45c58db6d261f2a&mobile="+_mobileNumberController.text+"&country_code=91&sid=9214&otp="+randomNumber.toString()+"&company=Color Challenge", bodyObject);
  }

  // Future login() async {
  //   AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
  //   String deviceId = androidInfo.androidId;
  //   Utils().showToast(deviceId);
  //   final user = await googleSignIn.signIn();
  //   if (user == null) {
  //     isSigningIn = false;
  //     return;
  //   } else {
  //     final googleAuth = await user.authentication;
  //
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );
  //
  //     await FirebaseAuth.instance.signInWithCredential(credential);
  //     var credentia = await _auth.signInWithCredential(credential);
  //     isSigningIn = credentia.user != null ? true : false;
  //     setState(() {
  //       email = user.email;
  //     });
  //   }
  //   if (isSigningIn) {
  //     prefs = await SharedPreferences.getInstance();
  //     var url = Constant.LOGIN_URL;
  //     Map<String, dynamic> bodyObject = {Constant.EMAIL: email};
  //     String jsonString = await apiCall(url, bodyObject);
  //     dynamic json = jsonDecode(jsonString);
  //     bool status = json["user_registered"];
  //
  //     if (status) {
  //       final Map<String, dynamic> responseJson =
  //       jsonDecode(jsonString);
  //       final dataList = responseJson['data'] as List;
  //       final Users user = Users.fromJsonNew(dataList.first);
  //       prefs.setString(Constant.LOGED_IN, "true");
  //       prefs.setString(Constant.ID, user.id);
  //       prefs.setString(Constant.UPI, user.upi);
  //       prefs.setString(Constant.EARN, user.earn);
  //       prefs.setString(Constant.NAME, user.name);
  //       prefs.setString(Constant.COINS, user.coins);
  //       prefs.setString(Constant.EMAIL, user.mobile);
  //       prefs.setString(Constant.BALANCE, user.balance);
  //       prefs.setString(Constant.REFERRED_BY, user.referredBy);
  //       prefs.setString(Constant.REFER_CODE, user.referCode);
  //       prefs.setString(
  //           Constant.WITHDRAWAL_STATUS, user.withdrawalStatus);
  //       prefs.setString(
  //           Constant.CHALLENGE_STATUS, user.challengeStatus);
  //       prefs.setString(Constant.STATUS, user.status);
  //       prefs.setString(Constant.JOINED_DATE, user.joinedDate);
  //       prefs.setString(Constant.LAST_UPDATED, user.lastUpdated);
  //       if(user.status=="0"){
  //         Utils().showToast("Your Blocked");
  //         Utils().logout();
  //       }else{
  //       Navigator.pushAndRemoveUntil(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => MainScreen(),
  //         ),
  //             (_) => false, // Remove all the previous routes.
  //       );}
  //     } else {
  //       showReferCodeSheet();
  //     }
  //   }else{
  //     Utils().showToast("Signin Failed");
  //   }
  // }


  showReferCodeSheet() {
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
                height: 350,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(
                        height: 30,
                      ),
                      // const Center(
                      //   child: Text(
                      //     "Enter Referal Code (optional)",
                      //     style: TextStyle(
                      //         fontSize: 18,
                      //         color: colors.greyss,
                      //         fontFamily: "Montserrat"),
                      //   ),
                      // ),
                      const SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            filled: true,
                            hintText: "Enter Name",
                            fillColor: Colors.transparent,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: colors.primary),
                            ),
                          ),
                          style: TextStyle(backgroundColor: Colors.transparent),
                        ),
                      ),
                      const SizedBox(height: 20),

                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          controller: _referCodeController,
                          decoration: const InputDecoration(
                            hintText: "Enter Refer Code (optional)",
                            filled: true,
                            fillColor: Colors.transparent,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: colors.primary),
                            ),
                          ),
                          style: TextStyle(backgroundColor: Colors.transparent),
                        ),
                      ),

                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Same device Multiple Register",
                              style: TextStyle(
                                color: colors.cc_red,
                                fontFamily: 'Montserrat',
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "Refer bonus can’t be send",
                              style: TextStyle(
                                color: colors.cc_red,
                                fontFamily: 'Montserrat',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),


                      const SizedBox(height: 30),
                      MaterialButton(
                        onPressed: () {
                          //newRegister();
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
                              'Continue',
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
            'Allow one device one Registration only',
            style: TextStyle(
              fontFamily: "Montserrat",
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        actions: <Widget>[
          ElevatedButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

}
