import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:color_challenge/Helper/apiCall.dart';
import 'package:color_challenge/Helper/utils.dart';
import 'package:color_challenge/muChallenges.dart';
import 'package:color_challenge/spinnerPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Helper/Color.dart';
import 'Helper/Constant.dart';
import 'myResults.dart';
import 'numchallenge.dart';

class GenerateCoins extends StatefulWidget {

  const GenerateCoins({Key? key}) : super(key: key);



  @override
  State<GenerateCoins> createState() => _GenerateCoinsState();
}

class _GenerateCoinsState extends State<GenerateCoins> {
  late SharedPreferences prefs;
  double _progressValue = 0.0; // Set the progress value between 0.0 and 1.0 here
  double starttime = 0; // Set the progress value between 0.0 and 1.0 here
  String coin_count = "0";
  int level = 1;
  String max_coin = "0";
  String time_left = "0";
  String refer_amount = "0";
  String generate_coin = "0";
  bool timerStarted = false;
  bool isLevel1 = false,isLevel2 = false,isLevel3 = false;
  Random random = Random();
  late String contact_us;
  String generateText = 'Generate';
  final TextEditingController _serialController = TextEditingController();
  String serilarandom = "";

  List<String> messages = [
    'Nice job!',
    'Well done!',
    'You are doing great!',
    'Awesome work!',
    'Keep it up!',
    // Add more messages as needed
  ];


  @override
  void initState() {
    super.initState();
    serilarandom = generateSerialNumber().toString();

    SharedPreferences.getInstance().then((value) {
      prefs = value;
      contact_us = prefs.getString(Constant.CONTACT_US).toString();
      coins_status("status");
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
          timerStarted = true;
        });
      }
    });
  }

  String getRandomMessage() {
    int randomIndex = random.nextInt(messages.length);
    return messages[randomIndex];
  }
  bool isMultipleOf5(int number) {
    return number % 5 == 0;
  }
  @override
  Widget build(BuildContext context) {
    final double desiredSize = 600.0;
    Color customColor = Color(0xFFDAA520); // Replace with your custom color code
    Color lightgray = Color(0xFFd3d3d3); // Replace with your custom color code

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/wfh.jpg",
              fit: BoxFit.contain,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                GestureDetector(
                  onTap: () {
                    // Add your action here, e.g., navigate to a new screen or update some state.
                    showLevelAlert(context,"1");
                  },
                  child: Card(
                    color: isLevel1 ? colors.cc_telegram_light : Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(16.0), // You can adjust the value as needed
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "10 min",
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
                    showLevelAlert(context,"2");
                  },
                  child:Card(
                  color: isLevel2 ? colors.cc_telegram_light : Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(16.0), // You can adjust the value as needed
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "5 min",
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
                    showLevelAlert(context,"3");
                  },child:Card(
                  color: isLevel3 ? colors.cc_telegram_light : Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(16.0), // You can adjust the value as needed
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "3 min",
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

            SizedBox(height: 20),
            Text(
              "Refer & Earn ₹ "+refer_amount,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.green),
            ),
            SizedBox(height: 120),
            Transform.scale(
              scale: desiredSize / 100.0,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    strokeWidth: 6,
                    value: _progressValue,
                    valueColor: AlwaysStoppedAnimation<Color>(customColor),
                    backgroundColor: lightgray,
                    // Consider changing this to Colors.grey
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 3,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: (_progressValue * 100).round().toString(),
                          style: TextStyle(fontSize: 10), // Set the desired larger font size for "5".
                        ),
                        TextSpan(text: '/'+max_coin),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 120),
          MaterialButton(
            onPressed:() {
              if(!timerStarted && generate_coin == '1'){
                showSheet();


              }else if(generate_coin == '0'){
                String text =
                    'Hello I need to Join in work from home job';

                // Encode the text for the URL
                String encodedText = Uri.encodeFull(text);
                String uri =
                    'https://wa.me/$contact_us?text=$encodedText';
                launchUrl(
                  Uri.parse(uri),
                  mode: LaunchMode.externalApplication,
                );

              }

            },
            color: timerStarted && generate_coin == '1' ? Colors.grey : colors.primary,

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
                      generateText,
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
              starttime.round().toString() + " seconds left",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal,color: Colors.red),
            ),
          ],
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
                            fontSize: 18,
                            color: Colors.grey,
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
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: colors.primary),
                            ),
                          ),
                          style: TextStyle(backgroundColor: Colors.transparent),
                        ),
                      ),
                      const SizedBox(height: 20),
                      MaterialButton(
                        onPressed: () {
                          if(serilarandom != _serialController.text.toString()){
                            Utils().showToast("Serial Number Wrong");
                          }else{
                            FocusScope.of(context).unfocus();
                            if(isMultipleOf5(int.parse(coin_count)) && (_progressValue * 100).round() > 4){
                              showAlertDialog(context,(_progressValue * 100).round().toString());

                            }

                            coins_status("generate");

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

  void showAlertDialog(BuildContext context, String coins) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Generated $coins Coins'),
          content: Text(getRandomMessage()),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
  String generateSerialNumber() {
    final random = Random();
    final maxDigits = 12;
    String randomNumber = '';

    for (int i = 0; i < maxDigits; i++) {
      randomNumber += random.nextInt(10).toString();
    }

    return randomNumber;
  }
  void showLevelAlert(BuildContext context, String level) {
    String levelcontent = "";
    if(level == '1'){
      levelcontent = 'Starting level\nGenerate time 10 min\nPer hour 6 coins can be Generate\nMaximum 100 Coins Storage';


    }else if(level == '2'){
      levelcontent = '3 Refers to reach level\nReduce time from 10 min to 5 min\nPer hour 12 coins can be Generate\nMaximum 150 Coins Storage per day';

    }else{
      levelcontent = '5 Refers to reach level\nReduce time from 5 min to 3 min\nPer hour 20 coins can be Generate\nMaximum 200 Coins Storage Per day';

    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Level $level'),
          content: Text(levelcontent),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
  // Method to get device info.
  Future<void> coins_status(String type) async {
    var url = Constant.GENERATE_COINS_URL;
    Map<String, dynamic> bodyObject = {
      Constant.USER_ID: prefs.getString(Constant.ID),
      Constant.DEVICE_ID:prefs.getString(Constant.MY_DEVICE_ID).toString(),
      Constant.TYPE: type
    };
    String jsonString = await apiCall(url, bodyObject);
    final jsonResponse = jsonDecode(jsonString);
    //Utils().showToast(jsonResponse['message'].toString());
    if(jsonResponse['success'] && type == 'status'){
      setState(() {
        coin_count = jsonResponse['coin_count'].toString();
        max_coin = jsonResponse['max_coin'].toString();
        time_left = jsonResponse['time_left'].toString();
        refer_amount = jsonResponse['refer_amount'].toString();
        level = jsonResponse['level'];
        generate_coin = jsonResponse['generate_coin'].toString();
        _progressValue = double.parse(coin_count)/100;
        starttime = double.parse(time_left);
        if(generate_coin == '0'){
          generateText = 'Join now';

        }
        if(level == 1){
          isLevel1 = true;
        }else if(level == 2){
          isLevel2 = true;

        }else if(level == 3){
          isLevel3 = true;

        }
        if(starttime != 600){
          startTimer();
        }

      });

    }else if(jsonResponse['success'] && type == 'generate'){

      setState(() {
        coin_count = jsonResponse['coin_count'].toString();
        max_coin = jsonResponse['max_coin'].toString();
        time_left = jsonResponse['time_left'].toString();
        refer_amount = jsonResponse['refer_amount'].toString();
        refer_amount = jsonResponse['refer_amount'].toString();
        level = jsonResponse['level'];
        generate_coin = jsonResponse['generate_coin'].toString();
        _progressValue = double.parse(coin_count)/100;
        starttime = double.parse(time_left);
        if(generate_coin == '0'){
          generateText = 'Join now';

        }

        if(starttime <= 600){

          startTimer();
        }

      });

    }
    else{
      Utils().showToast(jsonResponse['message']);
    }


  }


}
