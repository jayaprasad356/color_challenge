import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:color_challenge/Helper/apiCall.dart';
import 'package:color_challenge/Helper/utils.dart';
import 'package:color_challenge/adScreen.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Helper/Color.dart';
import 'Helper/Constant.dart';
import 'login/mainScreen.dart';


class TrialAd extends StatefulWidget {

  const TrialAd({Key? key}) : super(key: key);



  @override
  State<TrialAd> createState() => TrialAdState();
}

class TrialAdState extends State<TrialAd> {
  late SharedPreferences prefs;
  double starttime = 0; // Set the progress value between 0.0 and 1.0 here
  String today_ads_remain = "0";
  String level = '0',status = '';
  String history_days = '0';
  String ads_image = 'https://admin.colorjobs.site/dist/img/logo.jpeg';
  int time_start = 0;
  double seconds = 0.0;
  String time_left = '0';
  String max_coin = "0";
  String refer_amount = "0";
  String generate_coin = "0";
  bool _isLoading = true;
  String balance = "0";
  bool timerStarted = false;
  bool isTrial = true,isPremium = false;
  Random random = Random();
  late String contact_us;
  final TextEditingController _serialController = TextEditingController();
  String serilarandom = "";


  @override
  void initState() {
    super.initState();


    SharedPreferences.getInstance().then((value) {
      prefs = value;
      contact_us = prefs.getString(Constant.CONTACT_US).toString();

      ads_status("status");
    });


  }

  void startTimer() {
    // Example: Countdown from 100 to 0 with a 1-second interval
    const oneSec = const Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer timer) {
      if (starttime <= 0) {
        timer.cancel();
        setState(() {
          timerStarted = false;
        });
      } else {
        setState(() {
          starttime--;
          seconds = starttime % 60;
          timerStarted = true;
        });
      }
    });
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


  bool isMultipleOf5(int number) {
    return number % 5 == 0;
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width, // Set width to the screen width
        height: MediaQuery.of(context).size.height, // Set height to the screen height
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colors.primary_color, colors.secondary_color], // Change these colors to your desired gradient colors
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(isTrial)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  GestureDetector(
                    onTap: () {
                      showLevelAlert(context,"Free Trial");
                    },
                    child: Card(
                      color: isTrial ? colors.cc_telegram_light : Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(16.0), // You can adjust the value as needed
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "200 Ads",
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              "Free Trial",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              int.parse(history_days) >= 7 ? "expired":"7 days($history_days)",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        // Add your action here, e.g., navigate to a new screen or update some state.
                        showLevelAlert(context,"Premium");
                      },
                      child:Card(
                        color: colors.cc_velvet,
                        child: Padding(
                          padding: EdgeInsets.all(16.0), // You can adjust the value as needed
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "12000 Ads",
                                style: TextStyle(fontSize: 12,color: Colors.white),
                              ),
                              Text(
                                "Premium",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
                              ),
                              Text(
                                "30 days",
                                style: TextStyle(fontSize: 12,color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      )),
                ],
              ),
              if(isPremium)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    GestureDetector(
                      onTap: () {
                        // Add your action here, e.g., navigate to a new screen or update some state.
                        showPremiumLevelAlert(context,"1");
                      },
                      child: Card(
                        color: level == '1' ? colors.cc_telegram_light : Colors.white,
                        child: Padding(
                          padding: EdgeInsets.all(16.0), // You can adjust the value as needed
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "1 ad = 1 ad",
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                "Level 1",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "No refers",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          // Add your action here, e.g., navigate to a new screen or update some state.
                          showPremiumLevelAlert(context,"2");
                        },
                        child:Card(
                          color: level == '2' ? colors.cc_telegram_light : Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(16.0), // You can adjust the value as needed
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "1 ad = 2 ads",
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  "Level 2",
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "3 refers",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        )),
                    GestureDetector(
                        onTap: () {
                          // Add your action here, e.g., navigate to a new screen or update some state.
                          showPremiumLevelAlert(context,"3");
                        },child:Card(
                      color: level == '3' ? colors.cc_telegram_light : Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(16.0), // You can adjust the value as needed
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "1 ad = 4ads",
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              "Level 3",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "5 refers",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    )),
                  ],
                ),
              Text(
                status == '0' ? "Remaining Ads : $today_ads_remain":"Today Remaining Ads : $today_ads_remain",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Balance: ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: "₹$balance",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),
              Image.network(
                ads_image,
                fit: BoxFit.contain,
                height: 300, // Set the desired height
                width: 400,  // Set the desired width
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    _isLoading = false;


                    return child;
                  } else if (_isLoading) {
                    return CircularProgressIndicator(); // Show loading indicator
                  } else {
                    return child;
                  }
                },
              ),
              SizedBox(height: 20),

            MaterialButton(
              onPressed:() {
                if(!_isLoading && !timerStarted){
                  serilarandom = generateSerialNumber().toString();
                  showSheet();

                }




              },
              color: timerStarted && time_start == 1 ? Colors.grey : colors.primary,

                shape: const RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Padding(
                  padding:
                  const EdgeInsets.only(top: 16.0, bottom: 16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Watch Ad',
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
              SizedBox(height: 20),
              Text(
                "Next ads in " +seconds.round().toString().padLeft(2, '0'),


                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal,color: Colors.red),
              ),
            ],
          ),
        ),
      ),

    );

  }
  showSheet() {
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
                height: 500,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(
                        height: 50,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          serilarandom,
                          style: TextStyle(
                              letterSpacing: 5.0,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: colors.black,
                              fontFamily: "Montserrat",
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          controller: _serialController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: colors.primary),
                            ),
                            hintText: 'Enter PIN',
                          ),
                          style: TextStyle(backgroundColor: Colors.transparent),
                        ),
                      ),
                      const SizedBox(height: 20),
                      MaterialButton(
                        onPressed: () {
                          if(serilarandom != _serialController.text.toString()){
                            Utils().showToast("Pin Wrong");
                          }else{
                            _serialController.text = '';
                            Navigator.pop(context);

                            ads_status("watch_ad");

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
                              'Verify',
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


  String generateSerialNumber() {
    final random = Random();
    final maxDigits = 4;
    String randomNumber = '';

    for (int i = 0; i < maxDigits; i++) {
      randomNumber += random.nextInt(10).toString();
    }

    return randomNumber;
  }
  void  showLevelAlert(BuildContext context, String level) {
    String levelcontent = "";
    String leveltitle = "";
    if(level == 'Free Trial'){
      levelcontent = 'Total 200 Ads \n0.125 paise per Ad\n7 Days duration';
      leveltitle = 'Free Trial';

    }else{
      levelcontent = 'Total 12,000 Ads \n0.25 paise per Ad\n30 Days duration';
      leveltitle = 'Plan (₹1500 only)';

    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(leveltitle),
          content: Text(levelcontent),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                if(level == 'Free Trial'){
                  Navigator.of(context).pop();

                }else{
                  String text = 'Hello, I want to purchase Plan';
                  String encodedText = Uri.encodeFull(text);
                  String uri =
                      'https://wa.me/$contact_us?text=$encodedText';
                  launchUrl(
                    Uri.parse(uri),
                    mode: LaunchMode.externalApplication,
                  );

                }

              },
              child: Text(level == 'Free Trial' ? 'Close' : 'Purchase Plan'),
            ),
          ],
        );
      },
    );
  }
  void  showPremiumLevelAlert(BuildContext context, String level) {
    String levelcontent = "";
    String leveltitle = "";
    if(level == '1'){
      levelcontent = 'Watch 400 Ads per day\n1Ad = 1 Ad\nEarn ₹100 in 3 hrs 20 mins';
      leveltitle = 'Level 1';

    }else if(level == '2'){
      levelcontent = 'Watch 200 Ads per day\n1Ad = 2 Ads\nEarn ₹100 in 1 hrs 40 mins';
      leveltitle = 'Level 2(3 refers)';

    }else{
      levelcontent = 'Watch 100 Ads per day\n1Ad = 4 Ads\nEarn ₹100 in 50 mins\nNext Month Free plan';
      leveltitle = 'Level 3(5 refers)';

    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(leveltitle),
          content: Text(levelcontent),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                if(level == 'Free Trial'){
                  Navigator.of(context).pop();

                }else{
                  String text = 'Hello, I need help to reach next level';
                  String encodedText = Uri.encodeFull(text);
                  String uri =
                      'https://wa.me/$contact_us?text=$encodedText';
                  launchUrl(
                    Uri.parse(uri),
                    mode: LaunchMode.externalApplication,
                  );

                }

              },
              child: Text(level == '1' ? 'Close' : 'Get Help'),
            ),
          ],
        );
      },
    );
  }
  // Method to get device info.
  Future<void> ads_status(String type) async {

    var url = Constant.TRIAL_ADS_LIST;
    Map<String, dynamic> bodyObject = {
      Constant.USER_ID: prefs.getString(Constant.ID),
      Constant.DEVICE_ID:prefs.getString(Constant.MY_DEVICE_ID).toString(),
      Constant.TYPE: type
    };

    String jsonString = await apiCall(url, bodyObject);
    final jsonResponse = jsonDecode(jsonString);
    if(jsonResponse['success'] && type == 'status'){
      setState(() {
        today_ads_remain = jsonResponse['today_ads_remain'].toString();
        time_left = jsonResponse['time_left'].toString();
        time_start = jsonResponse['time_start'];
        refer_amount = jsonResponse['refer_amount'].toString();
        balance = jsonResponse['balance'].toString();
        history_days = jsonResponse['history_days'].toString();
        ads_image = jsonResponse['ads_image'].toString();
        status = jsonResponse['status'].toString();
        level = jsonResponse['level'].toString();
        starttime = double.parse(time_left);
        if(status == '1'){
          isTrial = false;
          isPremium = true;
        }
        if(time_start == 1){
          startTimer();
        }

      });

    }else if(jsonResponse['success'] && type == 'watch_ad'){

      setState(() {
        today_ads_remain = jsonResponse['today_ads_remain'].toString();
        time_left = jsonResponse['time_left'].toString();
        time_start = jsonResponse['time_start'];
        refer_amount = jsonResponse['refer_amount'].toString();
        balance = jsonResponse['balance'].toString();
        level = jsonResponse['level'].toString();
        status = jsonResponse['status'].toString();
        history_days = jsonResponse['history_days'].toString();
        ads_image = jsonResponse['ads_image'].toString();
        starttime = double.parse(time_left);

        if(status == '1'){
          isTrial = false;
          isPremium = true;
        }
        if(time_start == 1){
          startTimer();
        }
      });

    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(jsonResponse['message'])),
      );
    }


  }


}
