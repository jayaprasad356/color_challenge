import 'dart:convert';
import 'dart:math';


import 'package:color_challenge/Helper/apiCall.dart';
import 'package:color_challenge/util/Color.dart';
import 'package:color_challenge/util/Constant.dart';
import 'package:color_challenge/controller/utils.dart';
import 'package:color_challenge/view/screens/login/otpVerfication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
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
  final googleSignIn = GoogleSignIn();
  bool isSigningIn = false;
  String email = "";
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  int randomNumber = Random().nextInt(900000) + 100000;
  late String contact_us;


  @override
  void initState() {
    super.initState();


    Utils().deviceInfo();
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
          width: MediaQuery.of(context).size.width, // Set width to the screen width
          height: MediaQuery.of(context).size.height, // Set height to the screen height
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [colors.primary_color, colors.secondary_color], // Change these colors to your desired gradient colors
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 150),
              Image.asset(
                "assets/images/applogo.jpeg",
                height: 130,
                width: 150,
              ),
              const SizedBox(height: 50),

              //todo login Text view
              const Text(
                "Log in",
                style: TextStyle(
                    fontSize: 24,
                    color: colors.white,
                    fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(35), // Adjust the radius as needed
                  border: Border.all(color: colors.widget_color), // Border color
                ),
                child: TextField(

                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: _mobileNumberController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Mobile number', // Hint text
                    hintStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.transparent, // Set to transparent to let the background show
                    contentPadding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent), // Set your desired border color
                    ),

                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent), // Set your desired border color for focused state
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
              ),

              const SizedBox(height: 60),
              MaterialButton(
                onPressed: () async {
                  if (_mobileNumberController.text.isEmpty) {
                    Utils().showToast("Please Enter Mobile Number");
                  } else if (_mobileNumberController.text.length != 10) {
                    Utils().showToast("Please Enter Valid Mobile Number");
                  } else {
                    Navigator.pushReplacement(
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
                      image: AssetImage("assets/images/btnbg.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Send Otp',
                      style: TextStyle(
                          color: colors.white,
                          fontSize: 18,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              MaterialButton(
                onPressed: () {
                  String text = 'Hello I need help in app';
                  String encodedText = Uri.encodeFull(text);
                  String uri = 'https://wa.me/$contact_us?text=$encodedText';
                  launchUrl(
                    Uri.parse(uri),
                    mode: LaunchMode.externalApplication,
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/help.png',
                      height: 60,
                      width: 150,// Replace with the actual image path
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  otpsuccess() async {
    Map<String, dynamic> bodyObject = {
      Constant.EMAIL: 'dsds',
    };

    if (_referCodeController.text.isNotEmpty) {
      bodyObject[Constant.REFERRED_BY] = _referCodeController.text;
    }
    String jsonString = await apiCall("https://api.authkey.io/request?authkey=b45c58db6d261f2a&mobile="+_mobileNumberController.text+"&country_code=91&sid=9214&otp="+randomNumber.toString()+"&company=A1 Ads", bodyObject);
  }

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