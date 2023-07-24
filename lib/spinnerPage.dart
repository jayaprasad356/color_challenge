import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:color_challenge/Helper/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Helper/Constant.dart';
import 'Helper/apiCall.dart';

class spinnerPage extends StatefulWidget {
  const spinnerPage({Key? key}) : super(key: key);

  @override
  State<spinnerPage> createState() => spinnerPageState();
}

class spinnerPageState extends State<spinnerPage> {
  StreamController<int> selected = StreamController<int>();
  late SharedPreferences prefs;
  final items = <String>[
    'No Coins',
    '5 Coins',
    '10 Coins',
    '15 Coins',
    '20 Coins',
    '25 Coins',
  ];

  int selectedIndex = 0; // Track the selected index separately
  bool isSpinning = false;
  bool isSpinEnabled = true;

  Timer? dialogTimer;

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedIndex = Random().nextInt(3);
      selected.add(selectedIndex);
    });
  }

  @override
  void dispose() {
    selected.close();
    dialogTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spinner Wheel'),
      ),
      body: GestureDetector(
        onTap: () {
          if (isSpinEnabled && !isSpinning) {
            setState(() {
              selectedIndex = Fortune.randomInt(0, 3);
              selected.add(selectedIndex);
              isSpinning = true;
              isSpinEnabled = false;
              dialogTimer?.cancel();
            });
          }
        },
        child: Column(
          children: [
            Expanded(
              child: FortuneWheel(
                selected: selected.stream,
                items: [
                  for (var it in items) FortuneItem(child: Text(it)),
                ],
                onAnimationEnd: () {
                  dialogTimer = Timer(Duration(seconds: 1), () {
                    dailyBonusApi(selectedIndex,items[selectedIndex]);

                    isSpinEnabled = true;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showResultDialog(String result, bool type) {
    String title = "";
    String desc = "";
    if(type){
      title = "Result";
      desc = "Congratulations! You won $result.";




    }else{
      title = "You Already Claimed Daily Bonus";
      desc = "Please Come Tomorrow and get Bonus";


    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(desc),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> dailyBonusApi(int itempos, String result) async {
    int iteemresult = itempos * 5;
    prefs = await SharedPreferences.getInstance();
    var url = Constant.DAILY_BONUS_URL;
    Map<String, dynamic> bodyObject = {
      Constant.USER_ID: prefs.getString(Constant.ID),
      Constant.COINS:iteemresult.toString(),
    };
    String jsonString = await apiCall(url, bodyObject);
    final jsonResponse = jsonDecode(jsonString);
    bool success = jsonResponse['success'];
    final message = jsonResponse['message'];
    if(success){
      showResultDialog(result,true);
    }else{

      showResultDialog(result,false);
    }

  }
}
