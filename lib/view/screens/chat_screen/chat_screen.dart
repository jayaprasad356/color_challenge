import 'dart:convert';

import 'package:a1_ads/controller/home_controller.dart';
import 'package:a1_ads/controller/pcc_controller.dart';
import 'package:a1_ads/model/user.dart';
import 'package:a1_ads/controller/utils.dart';
import 'package:a1_ads/view/screens/profile_screen/update_profile_screen.dart';
import 'package:a1_ads/view/screens/shorts_vid/post_upload.dart';
import 'package:a1_ads/view/screens/upi_screen/apply%20leave.dart';
import 'package:a1_ads/view/screens/upi_screen/my_withdrawal_records.dart';
import 'package:a1_ads/view/screens/upi_screen/verify_ads.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../util/Color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../util/Constant.dart';
import '../../../Helper/apiCall.dart';
import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:salesiq_mobilisten/salesiq_mobilisten.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    initPlatformState();
    initMobilisten();
  }

  Future<void> initMobilisten() async {
    if (io.Platform.isIOS || io.Platform.isAndroid) {
      String appKey;
      String accessKey;
      if (io.Platform.isIOS) {
        appKey = "INSERT_IOS_APP_KEY";
        accessKey = "INSERT_IOS_ACCESS_KEY";
      } else {
        appKey = "INSERT_ANDROID_APP_KEY";
        accessKey = "INSERT_ANDROID_ACCESS_KEY";
      }
      ZohoSalesIQ.init(appKey, accessKey).then((_) {
        // initialization successful
        ZohoSalesIQ.showLauncher(true);
      }).catchError((error) {
        // initialization failed
        print(error);
      });
      ZohoSalesIQ.setThemeColorForiOS("#6d85fc");
    }
  }

  Future<void> initPlatformState() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Example Application'),
          ),
          body: Center(child: Column(children: <Widget>[]))),
    );
  }
}
