// import 'dart:convert';
//
// import 'package:color_challenge/Helper/apiCall.dart';
// import 'package:color_challenge/model/user.dart';
// import 'package:color_challenge/util/Constant.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
//
// class MainScreenController extends GetxController {
//   final int _selectedIndex = 0;
//   String title = "HOME";
//   String upiId = "";
//   bool actionsVisible = true;
//   bool logoutVisible = false;
//   bool leftArrowVisible = false;
//   bool notificationVisible = false;
//   late Users user;
//   late SharedPreferences prefs;
//   String coins = "0";
//   String balance = "";
//   String text = 'Click here to Send Screenshot';
//   String link = 'http://t.me/Colorchallengeapp1';
//   final googleSignIn = GoogleSignIn();
//   late String contactUs = "";
//   late String _fcmToken;
//
//   @override
//   void onInit() {
//     super.onInit();
//     setupSettings();
//     FirebaseMessaging.instance.getToken().then((token) {
//       _fcmToken = token!;
//       userDeatils();
//       print('FCM Token: $_fcmToken');
//     });
//   }
//
//
//   void userDeatils() async {
//     prefs = await SharedPreferences.getInstance();
//     var url = Constant.USER_DETAIL_URL;
//     Map<String, dynamic> bodyObject = {
//       Constant.USER_ID: prefs.getString(Constant.ID),
//       Constant.FCM_ID: _fcmToken
//     };
//     String jsonString = await apiCall(url, bodyObject);
//     final Map<String, dynamic> responseJson = jsonDecode(jsonString);
//     final dataList = responseJson['data'] as List;
//     final Users user = Users.fromJsonNew(dataList.first);
//
//     prefs.setString(Constant.LOGED_IN, "true");
//     prefs.setString(Constant.ID, user.id);
//     prefs.setString(Constant.MOBILE, user.mobile);
//     prefs.setString(Constant.NAME, user.name);
//     prefs.setString(Constant.UPI, user.upi);
//     prefs.setString(Constant.EARN, user.earn);
//     prefs.setString(Constant.BALANCE, user.balance);
//     prefs.setString(Constant.REFERRED_BY, user.referredBy);
//     prefs.setString(Constant.REFER_CODE, user.referCode);
//     prefs.setString(Constant.WITHDRAWAL_STATUS, user.withdrawalStatus);
//     prefs.setString(Constant.STATUS, user.status);
//     prefs.setString(Constant.JOINED_DATE, user.joinedDate);
//     prefs.setString(Constant.LAST_UPDATED, user.lastUpdated);
//     prefs.setString(Constant.MIN_WITHDRAWAL, user.min_withdrawal);
//     prefs.setString(Constant.HOLDER_NAME, user.holder_name);
//     prefs.setString(Constant.ACCOUNT_NUM, user.account_num);
//     prefs.setString(Constant.IFSC, user.ifsc);
//     prefs.setString(Constant.BANK, user.bank);
//     prefs.setString(Constant.BRANCH, user.branch);
//     if (user.status == "2" || user.device_id == "0") {
//       logout();
//       SystemNavigator.pop();
//     }
//   }
//
//   void _onItemTapped(int index) {
//       _selctedIndex = index;
//       if (index == 1) {
//         title = "Info";
//         _actionsVisible = false;
//         _logoutVisible = false;
//         _leftArrowVisible = false;
//         _notificationVisible = true;
//       } else if (index == 2) {
//         title = "Reports";
//         _actionsVisible = false;
//         _logoutVisible = false;
//         _leftArrowVisible = false;
//         _notificationVisible = true;
//       } else if (index == 3) {
//         title = "Wallet";
//         _actionsVisible = false;
//         _logoutVisible = true;
//         _leftArrowVisible = false;
//         _notificationVisible = false;
//       } else {
//         title = "Home";
//         _actionsVisible = true;
//         _logoutVisible = false;
//         _leftArrowVisible = false;
//         _notificationVisible = false;
//       }
//       update();
//   }
//
//   showUpiDetailSheet() {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(
//           top: Radius.circular(40.0),
//         ),
//       ),
//       builder: (context) {
//         return SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.only(
//               bottom: MediaQuery.of(context).viewInsets.bottom,
//             ),
//             child: const SizedBox(
//               height: 500, // Adjust the height according to your needs
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   SizedBox(
//                     height: 30,
//                   ),
//                   Center(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "Add Coins",
//                           style: TextStyle(
//                             fontSize: 18,
//                             color: Colors.black,
//                             fontFamily: "Montserrat",
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget getPage(int index) {
//     switch (index) {
//       case 0:
//         return const Home(); //HomePage(updateAmount: updateAmount);
//       case 1:
//         return const JobShow();
//       case 2:
//         return const report();
//       case 3:
//         return const wallet();
//       default:
//         return const wallet();
//     }
//   }
//
//   void setupSettings() async {
//     prefs = await SharedPreferences.getInstance();
//
//     var response = await dataCall(Constant.SETTINGS_URL);
//
//     String jsonDataString = response.toString();
//     final jsonData = jsonDecode(jsonDataString);
//
//     final dataList = jsonData['data'] as List;
//
//     final datass = dataList.first;
//     prefs.setString(Constant.CONTACT_US, datass[Constant.CONTACT_US]);
//     prefs.setString(Constant.IMAGE, datass[Constant.IMAGE]);
//     prefs.setString(Constant.OFFER_IMAGE, datass[Constant.OFFER_IMAGE]);
//     prefs.setString(Constant.REFER_BONUS, datass[Constant.REFER_BONUS]);
//     prefs.setString(
//         Constant.WITHDRAWAL_STATUS, datass[Constant.WITHDRAWAL_STATUS]);
//   }
//
//   ontop() {
//     Clipboard.setData(ClipboardData(text: link));
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Copied to clipboard')),
//     );
//     Utils().showToast("Copied!");
//   }
//
//   void logout() async {
//     await googleSignIn.disconnect();
//     FirebaseAuth.instance.signOut();
//   }
// }
