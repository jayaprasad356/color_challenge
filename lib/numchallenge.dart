import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:color_challenge/Helper/utils.dart';
import 'package:color_challenge/homePage.dart';
import 'package:color_challenge/login/mainScreen.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import '../Helper/Color.dart';
import '../Helper/Constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/apiCall.dart';
import '../user.dart';

class NumChallenge extends StatefulWidget {



  const NumChallenge({Key? key}) : super(key: key);

  @override
  State<NumChallenge> createState() => _NumChallengeState();
}

class _NumChallengeState extends State<NumChallenge> {
  late String OtpText1 = "",OtpText2 = "",OtpText3 = "",OtpText4 = "",OtpText5 = "",OtpText6 = "",OtpText7 = "",OtpText8 = "";
  Timer? _timer;
  int _start = 60;
  OtpFieldController otpController = OtpFieldController();
  late String random = "YOUR NUMBER DISPLAY HERE" ;
  late String taskstatus = "start";
  late String start_coins = "";
  late String prize = "";
  late String desc = "";
  late String btnText = "Start - $start_coins Coins";
  late SharedPreferences prefs;
  bool isOtpTextFieldEnabled1 = true;
  late ProgressDialog pr;
  String result = "loss";

  @override
  void initState() {
    super.initState();

    taskList();



  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SingleChildScrollView(
        child: Container(

          color: colors.white,
          child: Column(
            children: <Widget>[
              SizedBox(height: 30),
              Container(
                child: Padding(
                    padding: EdgeInsets.all(16),
                  child:               Text(desc,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: colors.dkgreen,
                        fontFamily: "Montserrat"),
                  ),

                ),
              ),
              Card(
                // Set card elevation and margin as needed
                elevation: 4,
                margin: EdgeInsets.all(8),
                // Set card color if needed
                color: Colors.white,
                // Create a container with some padding to hold the text
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    textAlign: TextAlign.center,
                    random,
                    style: TextStyle(

                        letterSpacing: 5.0,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: colors.black,
                        fontFamily: "Montserrat"),
                  ),

                ),
              ),
              //todo OTP Text view

              const SizedBox(height: 10),
              IgnorePointer(
                ignoring: isOtpTextFieldEnabled1,
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: OTPTextField(
                      controller: otpController,
                      length: 6,
                      width: MediaQuery.of(context).size.width,
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      fieldWidth: 45,
                      fieldStyle: FieldStyle.box,
                      outlineBorderRadius: 15,
                      style: const TextStyle(fontSize: 17),
                      inputFormatter: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      onChanged: (pin) {
                        OtpText1=pin;
                        print("Completed: " + pin);
                      },
                      onCompleted: (pin) {
                        OtpText1=pin;
                        print("Completed: " + pin);
                      }),
                ),

              ),

              const SizedBox(height: 10),
              IgnorePointer(
                ignoring: isOtpTextFieldEnabled1,
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: OTPTextField(
                      controller: otpController,
                      length: 6,
                      width: MediaQuery.of(context).size.width,
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      fieldWidth: 45,
                      fieldStyle: FieldStyle.box,
                      outlineBorderRadius: 15,
                      style: const TextStyle(fontSize: 17),
                      inputFormatter: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      onChanged: (pin) {
                        OtpText2=pin;
                        print("Completed: " + pin);
                      },
                      onCompleted: (pin) {
                        OtpText2=pin;
                        print("Completed: " + pin);
                      }),
                ),
              ),

              const SizedBox(height: 10),
              IgnorePointer(
                ignoring: isOtpTextFieldEnabled1,
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: OTPTextField(
                      controller: otpController,
                      length: 6,
                      width: MediaQuery.of(context).size.width,
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      fieldWidth: 45,
                      fieldStyle: FieldStyle.box,
                      outlineBorderRadius: 15,
                      style: const TextStyle(fontSize: 17),
                      inputFormatter: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      onChanged: (pin) {
                        OtpText3=pin;
                        print("Completed: " + pin);
                      },
                      onCompleted: (pin) {
                        OtpText3=pin;
                        print("Completed: " + pin);
                      }),
                ),
              ),
              const SizedBox(height: 10),
              IgnorePointer(
                ignoring: isOtpTextFieldEnabled1,
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: OTPTextField(
                      controller: otpController,
                      length: 6,
                      width: MediaQuery.of(context).size.width,
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      fieldWidth: 45,
                      fieldStyle: FieldStyle.box,
                      outlineBorderRadius: 15,
                      style: const TextStyle(fontSize: 17),
                      inputFormatter: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      onChanged: (pin) {
                        OtpText4=pin;
                        print("Completed: " + pin);
                      },
                      onCompleted: (pin) {
                        OtpText4=pin;
                        print("Completed: " + pin);
                      }),
                ),
              ),



              const SizedBox(
                height: 10,
              ),
              IgnorePointer(
                ignoring: isOtpTextFieldEnabled1,
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: OTPTextField(
                      controller: otpController,
                      length: 6,
                      width: MediaQuery.of(context).size.width,
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      fieldWidth: 45,
                      fieldStyle: FieldStyle.box,
                      outlineBorderRadius: 15,
                      style: const TextStyle(fontSize: 17),
                      inputFormatter: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      onChanged: (pin) {
                        OtpText5=pin;
                        print("Completed: " + pin);
                      },
                      onCompleted: (pin) {
                        OtpText5=pin;
                        print("Completed: " + pin);
                      }),
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              IgnorePointer(
                ignoring: isOtpTextFieldEnabled1,
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: OTPTextField(
                      controller: otpController,
                      length: 6,
                      width: MediaQuery.of(context).size.width,
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      fieldWidth: 45,
                      fieldStyle: FieldStyle.box,
                      outlineBorderRadius: 15,
                      style: const TextStyle(fontSize: 17),
                      inputFormatter: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      onChanged: (pin) {
                        OtpText6=pin;
                        print("Completed: " + pin);
                      },
                      onCompleted: (pin) {
                        OtpText6=pin;
                        print("Completed: " + pin);
                      }),
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              IgnorePointer(
                ignoring: isOtpTextFieldEnabled1,
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: OTPTextField(
                      controller: otpController,
                      length: 6,
                      width: MediaQuery.of(context).size.width,
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      fieldWidth: 45,
                      fieldStyle: FieldStyle.box,
                      outlineBorderRadius: 15,
                      style: const TextStyle(fontSize: 17),
                      inputFormatter: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      onChanged: (pin) {
                        OtpText7=pin;
                        print("Completed: " + pin);
                      },
                      onCompleted: (pin) {
                        OtpText7=pin;
                        print("Completed: " + pin);
                      }),
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              IgnorePointer(
                ignoring: isOtpTextFieldEnabled1,
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: OTPTextField(
                      controller: otpController,
                      length: 6,
                      width: MediaQuery.of(context).size.width,
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      fieldWidth: 45,
                      fieldStyle: FieldStyle.box,
                      outlineBorderRadius: 15,
                      style: const TextStyle(fontSize: 17),
                      inputFormatter: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      onChanged: (pin) {
                        OtpText8=pin;
                        print("Completed: " + pin);
                      },
                      onCompleted: (pin) {
                        OtpText8=pin;
                        print("Completed: " + pin);
                      }),
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              Text(
                '$_start seconds',
                style: TextStyle(
                    fontSize: 14,
                    color: colors.black,
                    fontFamily: "Montserrat"),
              ),
              const SizedBox(
                height: 10,
              ),

              MaterialButton(
                onPressed: () {
                  if(taskstatus == 'start'){
                    startTask();

                  }else if(taskstatus == 'verify'){
                    verifyResult();

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
                  child: Center(
                    child: Text(
                      btnText,
                      style: TextStyle(
                          fontSize: 14,
                          color: colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Montserrat"),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
  void startTimer(BuildContext context) {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        if (_start == 0) {
          _timer?.cancel();
          result = "loss";

          declareResult();

          //_showDialog(context);
        } else {
          _start--;
        }
      });
    });
  }
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String generateRandom54DigitNumber() {
    final random = Random();
    final maxDigits = 48;
    String randomNumber = '';

    for (int i = 0; i < maxDigits; i++) {
      randomNumber += random.nextInt(10).toString();
    }

    return randomNumber;
  }

  Future<void> verifyResult() async {

    late String output = OtpText1 + OtpText2 +OtpText3 +OtpText4 + OtpText5 + OtpText6 + OtpText7+OtpText8;

    if(output == random){
      result = "won";
      Utils().showToast("Correct");

      declareResult();
    }else{
      result = "loss";
      Utils().showToast("Wrong");
    }



  }

  Future<void> startTask() async {


    prefs = await SharedPreferences.getInstance();
    var url = Constant.TASK_START;
    Map<String, dynamic> bodyObject = {
      Constant.USER_ID: prefs.getString(Constant.ID),
    };
    String jsonString = await apiCall(url, bodyObject);
    final jsonResponse = jsonDecode(jsonString);
    final message = jsonResponse['message'];
    final status = jsonResponse['success'];

    if (status) {
      Utils().showToast(message);
      setState(() {
        btnText = "Verify";
        taskstatus = "verify";
        isOtpTextFieldEnabled1 = false;
        random = generateRandom54DigitNumber().toString();
        startTimer(context);
      });

    }else{
      Utils().showToast(message);
    }
  }
  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Time Out'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Start Again'),
            ),
          ],
        );
      },
    );
  }

  Future<void> taskList() async {
    var response = await dataCall(Constant.TASK_LIST);

    String jsonDataString = response.toString();
    final jsonData = jsonDecode(jsonDataString);

    final dataList = jsonData['data'] as List;

    final datass = dataList.first;
    setState(() {
      start_coins = datass[Constant.START_COINS];
      prize = datass[Constant.PRIZE];
      btnText = "Start - $start_coins Coins";
      desc =
      "See Number then type in box within time and get Rs.$prize reward";
    });
  }

  Future<void> declareResult() async {

    int time = 0;

    time = 60 - _start;
    prefs = await SharedPreferences.getInstance();
    var url = Constant.TASK_END;
    Map<String, dynamic> bodyObject = {
      Constant.USER_ID: prefs.getString(Constant.ID),
      Constant.RESULT: result,
      Constant.TIME: time.toString(),
    };
    String jsonString = await apiCall(url, bodyObject);
    final jsonResponse = jsonDecode(jsonString);
    final message = jsonResponse['message'];
    final status = jsonResponse['success'];

    if (status) {
      Utils().showToast(message);

    }else{
      Utils().showToast(message);
    }
    Navigator.pop(context);

  }







}
