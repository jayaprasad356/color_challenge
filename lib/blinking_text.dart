import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Helper/Color.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Helper/Constant.dart';
import 'Helper/apiCall.dart';
import 'package:intl/intl.dart';

class BlinkingText extends StatefulWidget {
  final String text;

  const BlinkingText({required this.text});

  @override
  _BlinkingTextState createState() => _BlinkingTextState();
}

class _BlinkingTextState extends State<BlinkingText> {
  late Stream<Color> _colorStream;
  late SharedPreferences prefs;
  String resultTime = "";
  String blinkText = "";
  int leftTime = 0;

  @override
  void initState() {
    super.initState();
    _colorStream = Stream.periodic(const Duration(milliseconds: 500), (count) {
      resultTiming();
      return count % 2 == 0 ? colors.primary : Colors.white;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Color>(
      stream: _colorStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        }
        return Text(
          blinkText,
          style: TextStyle(
            fontSize: 16,
            color: snapshot.data!,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        );
      },
    );
  }

  void resultTiming() async {
    prefs = await SharedPreferences.getInstance();
    var url = Constant.RESULT_TIME_URL;

    String jsonString = await dataCall(url);
    final Map<String, dynamic> responseJson = jsonDecode(jsonString);
    final dateTime = responseJson['result_announce_time'];
    DateTime date = DateTime.parse(dateTime);
    final formattedTime = DateFormat('h:mm a').format(date);

    setState(() {
      resultTime = "Today $formattedTime";
      leftTime = responseJson["time_diff"];
      blinkText = "Result Annouce in ${leftTime} Min";
    });
  }
}
