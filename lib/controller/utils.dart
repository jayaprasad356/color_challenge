import 'package:a1_ads/util/Constant.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:convert';
import 'package:crypto/crypto.dart';

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
    late String deviceId;

    if (kIsWeb) {
      final userData = {
        'userAgent': 'Web user agent data',
        'language': 'Web language data',
        'platform': 'Web platform data',
      };
      final encodedData = json.encode(userData);
      final uniqueId = _generateMD5Hash(encodedData);
      deviceId = uniqueId;
    } else {
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      deviceId = androidInfo.androidId;
    }

    final prefs = await SharedPreferences.getInstance();
    prefs.setString(Constant.MY_DEVICE_ID, deviceId);

    return deviceId;
  }

  // String generateWebUniqueId() {
  //   final userData = {
  //     'userAgent': html.window.navigator.userAgent,
  //     'language': html.window.navigator.language,
  //     'platform': html.window.navigator.platform,
  //   };
  //   final encodedData = json.encode(userData);
  //   final uniqueId = _generateMD5Hash(encodedData);
  //   return uniqueId;
  // }

  String _generateMD5Hash(String input) {
    final bytes = utf8.encode(input);
    final digest = md5.convert(bytes);
    return digest.toString();
  }

  void logout() async {
    SystemNavigator.pop();
  }
}
