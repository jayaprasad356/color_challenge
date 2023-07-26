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
import 'findColorList.dart';

class FindColor extends StatefulWidget {



  const FindColor({Key? key}) : super(key: key);

  @override
  State<FindColor> createState() => _FindColorState();
}

class _FindColorState extends State<FindColor> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          Container(

            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(

                children: <Widget>[

                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[

                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: FindColorList(),
          ),
        ],
      ),
    );
  }

}
