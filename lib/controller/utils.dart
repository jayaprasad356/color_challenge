import 'package:color_challenge/util/Constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:device_info/device_info.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

final googleSignIn = GoogleSignIn();

class Utils extends GetxController {
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  late SharedPreferences prefs;

  showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }

  Future<String> deviceInfo() async {
    AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
    String deviceId = androidInfo.androidId;
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      prefs.setString(Constant.MY_DEVICE_ID, deviceId);
    });
    return deviceId;
  }

  void logout() async {
    SystemNavigator.pop();
  }
}
