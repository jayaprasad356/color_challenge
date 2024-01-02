import 'dart:async';
import 'dart:html';

import 'package:a1_ads/controller/home_controller.dart';
import 'package:a1_ads/controller/utils.dart';
import 'package:a1_ads/model/jobs_show.dart';
import 'package:a1_ads/reports.dart';
import 'package:a1_ads/util/Color.dart';
import 'package:a1_ads/util/Constant.dart';
import 'package:a1_ads/view/screens/home_page/my_orders.dart';
import 'package:a1_ads/view/screens/login/loginMobile.dart';
import 'package:a1_ads/view/screens/profile_screen/update_profile_screen.dart';
import 'package:a1_ads/view/screens/upi_screen/bank_detail_screen.dart';
import 'package:a1_ads/view/screens/upi_screen/transactions_records.dart';
import 'package:a1_ads/view/screens/upi_screen/wallet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final HomeController homeController = Get.find<HomeController>();
  late SharedPreferences prefs;
  String name = "";
  String mobile_number = "";
  String referText = "", refer_bonus = "";

  List<List<dynamic>> selectItems = [
    ['assets/images/wallet(1) 1.png','Wallet', const wallet()],
    ['assets/images/transaction-history 1.png','Transaction', const Transactions()],
    ['assets/images/shop-bag 1.png','My Orders', const MyOrders()],
    ['assets/images/user(1) 1.png','Update Profile', UpdateProfileScreen()],
    ['assets/images/bank-account 1 (1).png','Update Bank', BankDetailsScreen()],
  ];

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      // referText = prefs.getString(Constant.REFER_CODE)!;
      // refer_bonus = prefs.getString(Constant.REFER_BONUS)!;
      setState(() {
        name = prefs.getString(Constant.NAME)!;
        mobile_number = prefs.getString(Constant.MOBILE)!;
      });
    });
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      referText = prefs.getString(Constant.REFER_CODE)!;
      // refer_bonus = prefs.getString(Constant.REFER_BONUS)!;
      refer_bonus = homeController.referBonus.toString();
    });
  }

  void logout() async {
    clearSharedPreferences();
    SystemNavigator.pop();
    FirebaseAuth.instance.signOut();
    Get.to(const LoginMobile());
  }

  Future<void> clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // return Scaffold(
    //   backgroundColor: const Color(0xFFF2F2F2),
    //   body: SingleChildScrollView(
    //     physics: const BouncingScrollPhysics(),
    //     child: Column(
    //       children: [
    //         const SizedBox(
    //           height: 10,
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 20.0),
    //           child: Container(
    //             height: size.height * 0.35,
    //             width: double.infinity,
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(10),
    //               gradient: const LinearGradient(
    //                   begin: Alignment.topCenter,
    //                   end: Alignment.bottomCenter,
    //                   colors: [
    //                     Color(0xFF444BBA),
    //                     Color(0xFF070C5C),
    //                   ]),
    //             ),
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 Text(
    //                   "Refer friend and earn $refer_bonus",
    //                   textAlign: TextAlign.start,
    //                   style: const TextStyle(
    //                     fontFamily: 'MontserratLight',
    //                     color: Color(0xFFFFFFFF),
    //                     fontSize: 20,
    //                   ),
    //                 ),
    //                 const SizedBox(
    //                   height: 10,
    //                 ),
    //                 Image.asset(
    //                   'assets/images/OBJECTS.png',
    //                   height: size.height * 0.15,
    //                 ),
    //                 const SizedBox(
    //                   height: 10,
    //                 ),
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                   children: <Widget>[
    //                     OutlinedButton(
    //                       onPressed: () {
    //                         Utils().showToast("Copied !");
    //                         Clipboard.setData(ClipboardData(text: referText));
    //                       },
    //                       style: OutlinedButton.styleFrom(
    //                         backgroundColor: Colors.white,
    //                         shape: RoundedRectangleBorder(
    //                           borderRadius: BorderRadius.circular(6.0),
    //                           side: const BorderSide(color: colors.red),
    //                         ),
    //                       ),
    //                       child: Padding(
    //                         padding: const EdgeInsets.symmetric(
    //                             horizontal: 16, vertical: 11),
    //                         child: Text(
    //                           referText,
    //                           style: const TextStyle(
    //                             color: colors.primary,
    //                             fontSize: 12.0,
    //                             fontFamily: 'MontserratLight',
    //                             fontWeight: FontWeight.bold,
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                     const SizedBox(width: 12.0),
    //                     OutlinedButton(
    //                       onPressed: () {
    //                         Share.share(
    //                             "$referText\nUse my Refer Code and Login to our website ${Constant.A1AdsWebUrl}");
    //                       },
    //                       style: OutlinedButton.styleFrom(
    //                         backgroundColor: colors.cc_velvet,
    //                         shape: RoundedRectangleBorder(
    //                           borderRadius: BorderRadius.circular(6.0),
    //                           side: const BorderSide(color: colors.white,width: 3),
    //                         ),
    //                       ),
    //                       child: const Padding(
    //                         padding: EdgeInsets.symmetric(
    //                             horizontal: 16, vertical: 11),
    //                         child: Text(
    //                           'Refer Friends',
    //                           style: TextStyle(
    //                             color: colors.white,
    //                             fontSize: 12.0,
    //                             fontFamily: 'MontserratLight',
    //                             fontWeight: FontWeight.bold,
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //         const SizedBox(
    //           height: 10,
    //         ),
    //         InkWell(
    //           onTap: () {
    //             String? uri = prefs.getString(Constant.WHATSPP_GROUP_LINK);
    //             debugPrint("uri: $uri");
    //             launchUrl(
    //               Uri.parse(uri!),
    //               mode: LaunchMode.externalApplication,
    //             );
    //           },
    //           child: Container(
    //             width: size.width * 0.6,
    //             height: 40,
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(5),
    //               color: const Color(0xFF00D95F),
    //             ),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 Image.asset(
    //                   "assets/images/whatsapp-icon-2048x2048-64wjztht 1.png",
    //                   height: 30,
    //                 ),
    //                 const Text(
    //                   'Whatsapp Group Link',
    //                   style: TextStyle(
    //                     fontFamily: 'MontserratBold',
    //                     color: Colors.white,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //         const SizedBox(
    //           height: 10,
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 20.0),
    //           child: SizedBox(
    //             height: size.height * 0.5,
    //             child: ListView.builder(
    //               shrinkWrap: true,
    //               itemCount: selectItems.length,
    //                 itemBuilder: (context, index){
    //                 return InkWell(
    //                   onTap: (){
    //                     Get.to(selectItems[index][2]);
    //                   },
    //                   child: Container(
    //                     height: size.height * 0.07,
    //                     width: double.infinity,
    //                     decoration: BoxDecoration(
    //                         borderRadius: BorderRadius.circular(10),
    //                         color: const Color(0xFFC6C8E9)),
    //                     margin: const EdgeInsets.symmetric(vertical: 5.0),
    //                     padding: const EdgeInsets.symmetric(horizontal: 10.0),
    //                     child: Row(
    //                       children: [
    //                         Image.asset(
    //                           selectItems[index][0],
    //                           height: 34,
    //                         ),
    //                         const SizedBox(
    //                           width: 10,
    //                         ),
    //                         Text(
    //                           selectItems[index][1],
    //                           textAlign: TextAlign.start,
    //                           style: const TextStyle(
    //                             fontFamily: 'MontserratLight',
    //                             color: Color(0xFF000000),
    //                             fontSize: 16,
    //                           ),
    //                         ),
    //                         Expanded(child: Container()),
    //                         Transform.rotate(
    //                           angle: 3.1,
    //                           child: const Icon(Icons.arrow_back_ios_new),
    //                         )
    //                       ],
    //                     ),
    //                   ),
    //                 );
    //                 }
    //             ),
    //           )
    //         ),
    //         const SizedBox(
    //           height: 10,
    //         ),
    //         Align(
    //           alignment: Alignment.center,
    //           child: InkWell(
    //               onTap: (){
    //                 prefs.setString(Constant.LOGED_IN, "false");
    //                 logout();
    //               },
    //               child: Container(
    //                 width: size.width * 0.3,
    //                 padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
    //                 alignment: Alignment.center,
    //                 child: const Row(
    //                 children: [
    //                   Icon(Icons.power_settings_new,size: 28,color: Color(0xFF242426),),
    //                   SizedBox(
    //                     width: 10,
    //                   ),
    //                   Text(
    //                     "Logout",
    //                     textAlign: TextAlign.start,
    //                     style: TextStyle(
    //                       fontFamily: 'MontserratLight',
    //                       color: Color(0xFF242426),
    //                       fontSize: 20,
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    return Scaffold(
      backgroundColor: colors.secondary_color,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          width: MediaQuery.of(context)
              .size
              .width, // Set width to the screen width
          height: MediaQuery.of(context)
              .size
              .height, // Set height to the screen height
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [colors.primary_color, colors.secondary_color],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          // padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Container(
                color: colors.cc_velvet,
                margin: const EdgeInsets.only(right: 10, left: 10, top: 10),
                child: Card(
                  child: Container(
                    color: colors.cc_velvet,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Refer friend and earn ₹$refer_bonus",
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Montserrat"),
                          ),
                          const SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              OutlinedButton(
                                onPressed: () {
                                  Utils().showToast("Copied !");
                                  Clipboard.setData(
                                      ClipboardData(text: referText));
                                },
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(6.0),
                                    side:
                                    const BorderSide(color: colors.red),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 11),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Image.asset(
                                        "assets/images/copy.png",
                                        width: 24.0,
                                        height: 24.0,
                                      ),
                                      const SizedBox(width: 8.0),
                                      Text(
                                        referText,
                                        style: const TextStyle(
                                          color: colors.primary,
                                          fontSize: 12.0,
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12.0),
                              MaterialButton(
                                onPressed: () {
                                  Share.share("$referText\nUse my Refer Code and Login to our website ${Constant.A1AdsWebUrl}");
                                },
                                color: colors.primary_color,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(8.0)),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 14.0, horizontal: 14.0),
                                  child: Text(
                                    'Refer Friends',
                                    style: TextStyle(
                                      color: colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                        // shape: BoxShape.circle,
                        borderRadius: BorderRadius.circular(1000),
                        gradient: const LinearGradient(
                          colors: [colors.primary_color, colors.secondary_color],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.person,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(
                          name.toString(),
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          mobile_number.toString(),
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Divider(color: Colors.white70, thickness: 1.5),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: InkWell(
                  onTap: () => Get.to(const wallet()),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 10, left: 10),
                        child: ImageIcon(
                          AssetImage("assets/images/Wallet.png"),
                          color: colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Wallet",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: InkWell(
                  onTap: () => Get.to(const report()),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 10, left: 10),
                        child: ImageIcon(
                          AssetImage("assets/images/result.png"),
                          color: colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Transaction",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              // InkWell(
              //   onTap: () => Get.to(const JobShow()),
              //   child: const Row(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       Padding(
              //         padding: EdgeInsets.only(right: 10, left: 10),
              //         child: ImageIcon(
              //               AssetImage(
              //                 "assets/images/challenge.png",
              //               ),
              //               color: colors.white,
              //             ),
              //       ),
              //       SizedBox(
              //         width: 15,
              //       ),
              //       Text(
              //         "Info",
              //         textAlign: TextAlign.start,
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontSize: 20,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
