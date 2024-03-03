import 'dart:async';
import 'dart:html';
import 'dart:math';
// import 'dart:math';

import 'package:a1_ads/controller/home_controller.dart';
import 'package:a1_ads/controller/pcc_controller.dart';
import 'package:a1_ads/controller/utils.dart';
import 'package:a1_ads/model/jobs_show.dart';
import 'package:a1_ads/reports.dart';
import 'package:a1_ads/util/Color.dart';
import 'package:a1_ads/util/Constant.dart';
import 'package:a1_ads/view/screens/home_page/my_orders.dart';
import 'package:a1_ads/view/screens/job/my_team.dart';
import 'package:a1_ads/view/screens/login/loginMobile.dart';
import 'package:a1_ads/view/screens/login/recharge_screen.dart';
import 'package:a1_ads/view/screens/profile_screen/my_customer.dart';
import 'package:a1_ads/view/screens/profile_screen/my_plan.dart';
import 'package:a1_ads/view/screens/profile_screen/update_profile_screen.dart';
import 'package:a1_ads/view/screens/shorts_vid/post_upload.dart';
import 'package:a1_ads/view/screens/upi_screen/bank_detail_screen.dart';
import 'package:a1_ads/view/screens/upi_screen/transactions_records.dart';
import 'package:a1_ads/view/screens/upi_screen/wallet.dart';
import 'package:a1_ads/view/screens/upi_screen/whatsapp_status.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
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
  final PCC c = Get.find<PCC>();
  List<XFile> photo = [];
  late SharedPreferences prefs;
  String name = "";
  String mobile_number = "";
  String referText = "", refer_bonus = "";
  StreamController<int> selected = StreamController<int>();

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  List<List<dynamic>> selectItems = [
    ['assets/images/wallet(1) 1.png', 'Wallet', const wallet()],
    [
      'assets/images/transaction-history 1.png',
      'Transaction',
      const Transactions()
    ],
    ['assets/images/shop-bag 1.png', 'My Orders', const MyOrders()],
    ['assets/images/user(1) 1.png', 'Update Profile', UpdateProfileScreen()],
    [
      'assets/images/bank-account 1 (1).png',
      'Update Bank',
      BankDetailsScreen()
    ],
    ['assets/images/refer.png', 'My Customer', const MyCustomer()],
  ];

  @override
  void initState() {
    super.initState();
    homeController.scratchCard();
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
    Get.to(const LoginMobile(
      referCode: '',
    ));
  }

  Future<void> clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              height: size.height * 0.22,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF444BBA),
                    Color(0xFF070C5C),
                  ],
                ),
              ),
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Text(
                        '₹249.00',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'MontserratBold',
                          fontSize: 16,
                        ),
                      ),
                      const Text(
                        'Total income',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.yellow,
                          fontFamily: 'MontserratMedium',
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: size.height * 0.05,),
                      const Text(
                        '₹249.00',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'MontserratBold',
                          fontSize: 16,
                        ),
                      ),
                      const Text(
                        'Total withdraw',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.yellow,
                          fontFamily: 'MontserratMedium',
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: 1,
                          height: double.infinity,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: size.height * 0.03,),
                      Expanded(
                        child: Container(
                          width: 1,
                          height: double.infinity,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        '₹249.00',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'MontserratBold',
                          fontSize: 16,
                        ),
                      ),
                      const Text(
                        'Total recharge',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.yellow,
                          fontFamily: 'MontserratMedium',
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: size.height * 0.05,),
                      const Text(
                        '₹249.00',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'MontserratBold',
                          fontSize: 16,
                        ),
                      ),
                      const Text(
                        'Today\'s income',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.yellow,
                          fontFamily: 'MontserratMedium',
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: 1,
                          height: double.infinity,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: size.height * 0.03,),
                      Expanded(
                        child: Container(
                          width: 1,
                          height: double.infinity,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        '₹249.00',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'MontserratBold',
                          fontSize: 16,
                        ),
                      ),
                      const Text(
                        'Total assets',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.yellow,
                          fontFamily: 'MontserratMedium',
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: size.height * 0.05,),
                      const Text(
                        '₹249.00',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'MontserratBold',
                          fontSize: 16,
                        ),
                      ),
                      const Text(
                        'Team income',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.yellow,
                          fontFamily: 'MontserratMedium',
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
            //   child: Container(
            //     height: size.height * 0.25,
            //     width: double.infinity,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(10),
            //       gradient: const LinearGradient(
            //           begin: Alignment.topCenter,
            //           end: Alignment.bottomCenter,
            //           colors: [
            //             Color(0xFF444BBA),
            //             Color(0xFF070C5C),
            //           ]),
            //     ),
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Text(
            //           "Refer friend and earn $refer_bonus",
            //           textAlign: TextAlign.start,
            //           style: const TextStyle(
            //             fontFamily: 'MontserratLight',
            //             color: Color(0xFFFFFFFF),
            //             fontSize: 20,
            //           ),
            //         ),
            //         const SizedBox(
            //           height: 10,
            //         ),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: [
            //             Image.asset(
            //               'assets/images/OBJECTS.png',
            //               height: size.height * 0.1,
            //             ),
            //             const SizedBox(
            //               width: 20,
            //             ),
            //             Column(
            //               children: [
            //                 InkWell(
            //                   onTap: () {
            //                     Utils().showToast("Copied !");
            //                     Clipboard.setData(
            //                         ClipboardData(text: referText));
            //                   },
            //                   child: Container(
            //                     height: 40,
            //                     width: size.width * 0.3,
            //                     decoration: BoxDecoration(
            //                       borderRadius: BorderRadius.circular(6),
            //                       color: Colors.white,
            //                       border:
            //                           Border.all(width: 0.5, color: colors.red),
            //                     ),
            //                     alignment: Alignment.center,
            //                     child: Text(
            //                       referText,
            //                       style: const TextStyle(
            //                         color: colors.primary,
            //                         fontSize: 12.0,
            //                         fontFamily: 'MontserratLight',
            //                         fontWeight: FontWeight.bold,
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //                 const SizedBox(
            //                   height: 10,
            //                 ),
            //                 InkWell(
            //                   onTap: () {
            //                     // Utils().showToast("Copied !");
            //                     // Clipboard.setData(ClipboardData(text: referText));
            //                     // Share.share(
            //                     //     "$referText\nUse my Refer Code and Login to our website ${Constant.A1AdsWebUrl}");
            //                     String referralUrl =
            //                         "${Constant.A1AdsWebUrl}/?referralCode=$referText\nClick this link  to join A1 Store App ☺️";
            //                     debugPrint("referralUrl: $referralUrl");
            //                     Share.share(referralUrl);
            //                   },
            //                   child: Container(
            //                     height: 40,
            //                     width: size.width * 0.3,
            //                     decoration: BoxDecoration(
            //                       borderRadius: BorderRadius.circular(6),
            //                       color: colors.cc_velvet,
            //                       border: Border.all(
            //                         width: 0.5,
            //                         color: colors.white,
            //                       ),
            //                     ),
            //                     alignment: Alignment.center,
            //                     child: const Text(
            //                       'Refer Friends',
            //                       style: TextStyle(
            //                         color: colors.white,
            //                         fontSize: 12.0,
            //                         fontFamily: 'MontserratLight',
            //                         fontWeight: FontWeight.bold,
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ],
            //         ),
            //         const SizedBox(
            //           height: 10,
            //         ),
            //         // Row(
            //         //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //         //   children: <Widget>[
            //         //     OutlinedButton(
            //         //       onPressed: () {
            //         //         Utils().showToast("Copied !");
            //         //         Clipboard.setData(ClipboardData(text: referText));
            //         //       },
            //         //       style: OutlinedButton.styleFrom(
            //         //         backgroundColor: Colors.white,
            //         //         shape: RoundedRectangleBorder(
            //         //           borderRadius: BorderRadius.circular(6.0),
            //         //           side: const BorderSide(color: colors.red),
            //         //         ),
            //         //       ),
            //         //       child: Padding(
            //         //         padding: const EdgeInsets.symmetric(
            //         //             horizontal: 16, vertical: 11),
            //         //         child: Text(
            //         //           referText,
            //         //           style: const TextStyle(
            //         //             color: colors.primary,
            //         //             fontSize: 12.0,
            //         //             fontFamily: 'MontserratLight',
            //         //             fontWeight: FontWeight.bold,
            //         //           ),
            //         //         ),
            //         //       ),
            //         //     ),
            //         //     const SizedBox(width: 12.0),
            //         //     OutlinedButton(
            //         //       onPressed: () {
            //         //         Share.share(
            //         //             "$referText\nUse my Refer Code and Login to our website ${Constant.A1AdsWebUrl}");
            //         //       },
            //         //       style: OutlinedButton.styleFrom(
            //         //         backgroundColor: colors.cc_velvet,
            //         //         shape: RoundedRectangleBorder(
            //         //           borderRadius: BorderRadius.circular(6.0),
            //         //           side: const BorderSide(
            //         //               color: colors.white, width: 3),
            //         //         ),
            //         //       ),
            //         //       child: const Padding(
            //         //         padding: EdgeInsets.symmetric(
            //         //             horizontal: 16, vertical: 11),
            //         //         child: Text(
            //         //           'Refer Friends',
            //         //           style: TextStyle(
            //         //             color: colors.white,
            //         //             fontSize: 12.0,
            //         //             fontFamily: 'MontserratLight',
            //         //             fontWeight: FontWeight.bold,
            //         //           ),
            //         //         ),
            //         //       ),
            //         //     ),
            //         //   ],
            //         // ),
            //       ],
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                // String uri = 'https://chat.whatsapp.com/KFBkIquqNioCPfwLu59t69';
                String? uri = prefs.getString(Constant.WHATSPP_GROUP_LINK);
                debugPrint("uri: $uri");
                launchUrl(
                  Uri.parse(uri!),
                  mode: LaunchMode.externalApplication,
                );
              },
              child: Container(
                width: size.width * 0.6,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color(0xFF00D95F),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/whatsapp-icon-2048x2048-64wjztht 1.png",
                      height: 30,
                    ),
                    const Text(
                      'Whatsapp Group Link',
                      style: TextStyle(
                        fontFamily: 'MontserratBold',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Get.to(const MyPlan());
                      },
                      child: Container(
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xFFFFFFFF),
                          border: Border.all(
                            width: 1,
                            color: const Color(0xFF161C7E),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'My Plan',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: 'MontserratLight',
                            color: Color(0xFF000000),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Get.to(const RechargeScreen());
                      },
                      child: Container(
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xFF161C7E),
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 16,
                              width: 16,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                                border: Border.all(
                                  width: 2,
                                  color: Colors.white,
                                ),
                              ),
                              child: const Icon(Icons.add, color: Colors.white, size: 13),
                            ),
                            const SizedBox(width: 5,),
                            const Text(
                              "Recharge",
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontFamily: 'MontserratMedium',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Get.to(const wallet());
              },
              child: Container(
                height: size.height * 0.07,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFC6C8E9)),
                margin:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/wallet(1) 1.png',
                      height: 34,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Wallet',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: 'MontserratLight',
                        color: Color(0xFF000000),
                        fontSize: 16,
                      ),
                    ),
                    Expanded(child: Container()),
                    Transform.rotate(
                      angle: 3.1,
                      child: const Icon(Icons.arrow_back_ios_new),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                spinningWheelAlertDialog(context, selected,);
                // showScratchCard(
                //     context,
                //     homeController.scratchCardDataDataAmount.toString(),
                //     selected);
                // if (homeController.scratchCardDataDataStatus.toString() == '1') {
                //   showScratchCard(
                //       context,
                //       homeController.scratchCardDataDataAmount.toString());
                // } else {
                //   Get.snackbar(
                //     'Scratch Card',
                //     homeController.scratchCardDataDataMessage.toString(),
                //     colorText: colors.primary,
                //     backgroundColor: Colors.white,
                //     duration: const Duration(seconds: 3),
                //   );
                // }
              },
              child: Container(
                height: size.height * 0.07,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFC6C8E9)),
                margin:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/Spinner_icon_image.png',
                      height: 34,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Spin Your Offer',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: 'MontserratLight',
                        color: Color(0xFF000000),
                        fontSize: 16,
                      ),
                    ),
                    Expanded(child: Container()),
                    Transform.rotate(
                      angle: 3.1,
                      child: const Icon(Icons.arrow_back_ios_new),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(const Transactions());
              },
              child: Container(
                height: size.height * 0.07,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFC6C8E9)),
                margin:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/transaction-history 1.png',
                      height: 34,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Transaction',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: 'MontserratLight',
                        color: Color(0xFF000000),
                        fontSize: 16,
                      ),
                    ),
                    Expanded(child: Container()),
                    Transform.rotate(
                      angle: 3.1,
                      child: const Icon(Icons.arrow_back_ios_new),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(const MyOrders());
              },
              child: Container(
                height: size.height * 0.07,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFC6C8E9)),
                margin:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/shop-bag 1.png',
                      height: 34,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'My Orders',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: 'MontserratLight',
                        color: Color(0xFF000000),
                        fontSize: 16,
                      ),
                    ),
                    Expanded(child: Container()),
                    Transform.rotate(
                      angle: 3.1,
                      child: const Icon(Icons.arrow_back_ios_new),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(UpdateProfileScreen());
              },
              child: Container(
                height: size.height * 0.07,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFC6C8E9)),
                margin:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/user(1) 1.png',
                      height: 34,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Update Profile',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: 'MontserratLight',
                        color: Color(0xFF000000),
                        fontSize: 16,
                      ),
                    ),
                    Expanded(child: Container()),
                    Transform.rotate(
                      angle: 3.1,
                      child: const Icon(Icons.arrow_back_ios_new),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(BankDetailsScreen());
              },
              child: Container(
                height: size.height * 0.07,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFC6C8E9)),
                margin:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/bank-account 1 (1).png',
                      height: 34,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Update Bank',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: 'MontserratLight',
                        color: Color(0xFF000000),
                        fontSize: 16,
                      ),
                    ),
                    Expanded(child: Container()),
                    Transform.rotate(
                      angle: 3.1,
                      child: const Icon(Icons.arrow_back_ios_new),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(const WhatsappStatus());
              },
              child: Container(
                height: size.height * 0.07,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFC6C8E9)),
                margin:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFFFFFFFF)),
                      child: Image.asset(
                        'assets/images/whatsapp-logo.png',
                        height: 34,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Upload WhatsApp status',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: 'MontserratLight',
                        color: Color(0xFF000000),
                        fontSize: 16,
                      ),
                    ),
                    Expanded(child: Container()),
                    Transform.rotate(
                      angle: 3.1,
                      child: const Icon(Icons.arrow_back_ios_new),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            GestureDetector(
              onTap: () {
                prefs.setString(Constant.LOGED_IN, "false");
                logout();
              },
              child: Container(
                width: size.width * 0.3,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                alignment: Alignment.center,
                child: const Row(
                  children: [
                    Icon(
                      Icons.power_settings_new,
                      size: 28,
                      color: Color(0xFF242426),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Logout",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: 'MontserratLight',
                        color: Color(0xFF242426),
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
          ],
        ),
      ),
    );

    // return Scaffold(
    //   backgroundColor: colors.secondary_color,
    //   body: SingleChildScrollView(
    //     physics: const BouncingScrollPhysics(),
    //     child: Container(
    //       width: MediaQuery.of(context)
    //           .size
    //           .width, // Set width to the screen width
    //       height: MediaQuery.of(context)
    //           .size
    //           .height, // Set height to the screen height
    //       decoration: const BoxDecoration(
    //         gradient: LinearGradient(
    //           colors: [colors.primary_color, colors.secondary_color],
    //           begin: Alignment.topCenter,
    //           end: Alignment.bottomCenter,
    //         ),
    //       ),
    //       // padding: const EdgeInsets.all(15),
    //       child: Column(
    //         children: [
    //           Container(
    //             color: colors.cc_velvet,
    //             margin: const EdgeInsets.only(right: 10, left: 10, top: 10),
    //             child: Card(
    //               child: Container(
    //                 color: colors.cc_velvet,
    //                 child: Padding(
    //                   padding: const EdgeInsets.all(5.0),
    //                   child: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.center,
    //                     children: <Widget>[
    //                       Text(
    //                         "Refer friend and earn ₹$refer_bonus",
    //                         style: const TextStyle(
    //                             fontSize: 14,
    //                             color: Colors.white,
    //                             fontWeight: FontWeight.bold,
    //                             fontFamily: "Montserrat"),
    //                       ),
    //                       const SizedBox(height: 10.0),
    //                       Row(
    //                         mainAxisAlignment:
    //                         MainAxisAlignment.spaceEvenly,
    //                         children: <Widget>[
    //                           OutlinedButton(
    //                             onPressed: () {
    //                               Utils().showToast("Copied !");
    //                               Clipboard.setData(
    //                                   ClipboardData(text: referText));
    //                             },
    //                             style: OutlinedButton.styleFrom(
    //                               backgroundColor: Colors.white,
    //                               shape: RoundedRectangleBorder(
    //                                 borderRadius:
    //                                 BorderRadius.circular(6.0),
    //                                 side:
    //                                 const BorderSide(color: colors.red),
    //                               ),
    //                             ),
    //                             child: Padding(
    //                               padding: const EdgeInsets.symmetric(
    //                                   horizontal: 16, vertical: 11),
    //                               child: Row(
    //                                 mainAxisSize: MainAxisSize.min,
    //                                 children: <Widget>[
    //                                   Image.asset(
    //                                     "assets/images/copy.png",
    //                                     width: 24.0,
    //                                     height: 24.0,
    //                                   ),
    //                                   const SizedBox(width: 8.0),
    //                                   Text(
    //                                     referText,
    //                                     style: const TextStyle(
    //                                       color: colors.primary,
    //                                       fontSize: 12.0,
    //                                       fontFamily: "Montserrat",
    //                                       fontWeight: FontWeight.bold,
    //                                     ),
    //                                   ),
    //                                 ],
    //                               ),
    //                             ),
    //                           ),
    //                           const SizedBox(width: 12.0),
    //                           MaterialButton(
    //                             onPressed: () {
    //                               Share.share("$referText\nUse my Refer Code and Login to our website ${Constant.A1AdsWebUrl}");
    //                             },
    //                             color: colors.primary_color,
    //                             shape: const RoundedRectangleBorder(
    //                               borderRadius: BorderRadius.all(
    //                                   Radius.circular(8.0)),
    //                             ),
    //                             child: const Padding(
    //                               padding: EdgeInsets.symmetric(
    //                                   vertical: 14.0, horizontal: 14.0),
    //                               child: Text(
    //                                 'Refer Friends',
    //                                 style: TextStyle(
    //                                   color: colors.white,
    //                                   fontSize: 16.0,
    //                                   fontWeight: FontWeight.bold,
    //                                 ),
    //                               ),
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ),
    //           const SizedBox(
    //             height: 15,
    //           ),
    //           Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 15),
    //             child: Row(
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: [
    //                 Container(
    //                   height: 55,
    //                   width: 55,
    //                   decoration: BoxDecoration(
    //                     // shape: BoxShape.circle,
    //                     borderRadius: BorderRadius.circular(1000),
    //                     gradient: const LinearGradient(
    //                       colors: [colors.primary_color, colors.secondary_color],
    //                       begin: Alignment.topCenter,
    //                       end: Alignment.bottomCenter,
    //                     ),
    //                   ),
    //                   alignment: Alignment.center,
    //                   child: const Icon(
    //                     Icons.person,
    //                     size: 35,
    //                     color: Colors.white,
    //                   ),
    //                 ),
    //                 const SizedBox(
    //                   width: 15,
    //                 ),
    //                 Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                      Text(
    //                       name.toString(),
    //                       textAlign: TextAlign.start,
    //                       style: const TextStyle(
    //                         color: Colors.white,
    //                         fontSize: 20,
    //                       ),
    //                     ),
    //                     const SizedBox(
    //                       height: 5,
    //                     ),
    //                     Text(
    //                       mobile_number.toString(),
    //                       textAlign: TextAlign.start,
    //                       style: const TextStyle(
    //                         color: Colors.white,
    //                         fontSize: 16,
    //                       ),
    //                     ),
    //
    //                   ],
    //                 ),
    //               ],
    //             ),
    //           ),
    //           const SizedBox(
    //             height: 15,
    //           ),
    //           const Padding(
    //             padding: EdgeInsets.symmetric(horizontal: 15),
    //             child: Divider(color: Colors.white70, thickness: 1.5),
    //           ),
    //           const SizedBox(
    //             height: 15,
    //           ),
    //           Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 15),
    //             child: InkWell(
    //               onTap: () => Get.to(const wallet()),
    //               child: const Row(
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: [
    //                   Padding(
    //                     padding: EdgeInsets.only(right: 10, left: 10),
    //                     child: ImageIcon(
    //                       AssetImage("assets/images/Wallet.png"),
    //                       color: colors.white,
    //                     ),
    //                   ),
    //                   SizedBox(
    //                     width: 15,
    //                   ),
    //                   Text(
    //                     "Wallet",
    //                     textAlign: TextAlign.start,
    //                     style: TextStyle(
    //                       color: Colors.white,
    //                       fontSize: 20,
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //           const SizedBox(
    //             height: 15,
    //           ),
    //           Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 15),
    //             child: InkWell(
    //               onTap: () => Get.to(const report()),
    //               child: const Row(
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: [
    //                   Padding(
    //                     padding: EdgeInsets.only(right: 10, left: 10),
    //                     child: ImageIcon(
    //                       AssetImage("assets/images/result.png"),
    //                       color: colors.white,
    //                     ),
    //                   ),
    //                   SizedBox(
    //                     width: 15,
    //                   ),
    //                   Text(
    //                     "Transaction",
    //                     textAlign: TextAlign.start,
    //                     style: TextStyle(
    //                       color: Colors.white,
    //                       fontSize: 20,
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //           const SizedBox(
    //             height: 15,
    //           ),
    //           // InkWell(
    //           //   onTap: () => Get.to(const JobShow()),
    //           //   child: const Row(
    //           //     crossAxisAlignment: CrossAxisAlignment.center,
    //           //     children: [
    //           //       Padding(
    //           //         padding: EdgeInsets.only(right: 10, left: 10),
    //           //         child: ImageIcon(
    //           //               AssetImage(
    //           //                 "assets/images/challenge.png",
    //           //               ),
    //           //               color: colors.white,
    //           //             ),
    //           //       ),
    //           //       SizedBox(
    //           //         width: 15,
    //           //       ),
    //           //       Text(
    //           //         "Info",
    //           //         textAlign: TextAlign.start,
    //           //         style: TextStyle(
    //           //           color: Colors.white,
    //           //           fontSize: 20,
    //           //         ),
    //           //       ),
    //           //     ],
    //           //   ),
    //           // ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }

  void spinningWheelAlertDialog(
      BuildContext context,
      StreamController<int> selected
      ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return spinningWheel(
          selected: selected,
        );
      },
    );
  }

  showScratchCard(BuildContext context, String scratchCardDataDataAmount,
      StreamController<int> _selected) {
    _selected?.close();
    _selected = StreamController<int>();
    final items = <FortuneItem>[
      FortuneItem(
        style: FortuneItemStyle(
          color: Colors.pink.shade600,
          borderWidth: 0,
        ),
        child: const Text(
          "₹20",
          style: TextStyle(
            fontFamily: 'MontserratBold',
            color: Color(0xFFFFFFFF),
            fontSize: 12,
          ),
        ),
      ),
      FortuneItem(
        style: FortuneItemStyle(
          color: Colors.blue.shade600,
          borderWidth: 0,
        ),
        child: const Text(
          "₹120",
          style: TextStyle(
            fontFamily: 'MontserratBold',
            color: Color(0xFFFFFFFF),
            fontSize: 12,
          ),
        ),
      ),
      FortuneItem(
        style: FortuneItemStyle(
          color: Colors.amber.shade600,
          borderWidth: 0,
        ),
        child: const Text(
          "₹500",
          style: TextStyle(
            fontFamily: 'MontserratBold',
            color: Color(0xFFFFFFFF),
            fontSize: 12,
          ),
        ),
      ),
      FortuneItem(
        style: FortuneItemStyle(
          color: Colors.deepOrange.shade600,
          borderWidth: 0,
        ),
        child: const Text(
          "₹1000",
          style: TextStyle(
            fontFamily: 'MontserratBold',
            color: Color(0xFFFFFFFF),
            fontSize: 12,
          ),
        ),
      ),
      FortuneItem(
        style: const FortuneItemStyle(
          color: Colors.white,
          borderWidth: 0,
        ),
        child: Text(
          "₹1500",
          style: TextStyle(
            fontFamily: 'MontserratBold',
            color: Colors.brown.shade700,
            fontSize: 12,
          ),
        ),
      ),
      FortuneItem(
        style: FortuneItemStyle(
          color: Colors.red.shade800,
          borderWidth: 0,
        ),
        child: const Text(
          "₹2000",
          style: TextStyle(
            fontFamily: 'MontserratBold',
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ),
    ];
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: colors.primary_color,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 280,
            width: 280,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    height: 260,
                    width: 260,
                    child: Image.asset(
                      "assets/images/realistic-gold.png",
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 250,
                    width: 250,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1000000),
                            ),
                            child: Image.asset(
                              "assets/images/Group 18250.png",
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 210,
                            width: 210,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1000000),
                              border: Border.all(color: Colors.white,width: 2),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.white54,
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(5, 2),
                                ),
                                // Add more BoxShadow if needed
                              ],
                            ),
                            child: FortuneWheel(
                              selected: _selected.stream,
                              indicators: const <FortuneIndicator>[
                                FortuneIndicator(
                                  alignment: Alignment.topCenter,
                                  child: TriangleIndicator(
                                    color: Colors.green,
                                    width: 2.0,
                                    height: 2.0,
                                    elevation: 0,
                                  ),
                                ),
                              ],
                              styleStrategy: const UniformStyleStrategy(
                                color: Color(0xFFC6C8E9),
                                borderWidth: 0,
                              ),
                              items: items,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            "assets/images/realistic-gold.png",
                            height: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.topCenter,
                    child: Transform.rotate(
                      angle: pi / 2, // 90 degrees in radians
                      child: Image.asset(
                        "assets/images/pngtree-yellow.png",
                        height: 50,
                      ),
                    )
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                _selected.add(
                  Fortune.randomInt(0, items.length),
                );
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.all(10),
              child: const Text("rotate"),
            ),
          )
        ],
      ),
    );
  }

  // showScratchCard(BuildContext context, String scratchCardDataDataAmount, StreamController<int> _selected) {
  //   final items = <FortuneItem>[
  //     FortuneItem(child: Text("20")),
  //     FortuneItem(child: Text("60")),
  //     FortuneItem(child: Text("150")),
  //     FortuneItem(child: Text("500")),
  //     FortuneItem(child: Text("1500")),
  //     FortuneItem(child: Text("5000")),
  //   ];
  //
  //   final weights = <double>[
  //     1.0, 1.0, 1.0, 0.5, 1.0, 0.2 // Adjust the weights as per your preference
  //   ];
  //
  //   return showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //         content: Column(
  //           children: [
  //             SizedBox(
  //               height: 300,
  //               width: 300,
  //               child: FortuneWheel(
  //                 selected: _selected.stream,
  //                 items: items,
  //               ),
  //             ),
  //             InkWell(
  //               onTap: () {
  //                 setState(() {
  //                   _selected.add(
  //                     weightedRandomIndex(weights),
  //                   );
  //                 });
  //               },
  //               child: Container(
  //                 decoration: BoxDecoration(
  //                   color: Colors.blue,
  //                   borderRadius: BorderRadius.circular(5),
  //                 ),
  //                 padding: const EdgeInsets.all(10),
  //                 child: const Text("rotate"),
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  // int weightedRandomIndex(List<double> weights) {
  //   final totalWeight = weights.reduce((a, b) => a + b);
  //   final randomValue = Random().nextDouble() * totalWeight;
  //
  //   var cumulativeWeight = 0.0;
  //   for (var i = 0; i < weights.length; i++) {
  //     cumulativeWeight += weights[i];
  //     if (randomValue <= cumulativeWeight) {
  //       return i;
  //     }
  //   }
  //
  //   // Default case (should not reach here under normal circumstances)
  //   return 0;
  // }
}

class spinningWheel extends StatefulWidget {
  final StreamController<int> selected;
  const spinningWheel({super.key, required this.selected});

  @override
  State<spinningWheel> createState() => _spinningWheelState();
}

class _spinningWheelState extends State<spinningWheel> {
  late final StreamController<int> _controller;

  @override
  void initState() {
    super.initState();
    _controller = StreamController<int>.broadcast();
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }


  final items = <FortuneItem>[
    FortuneItem(
      style: FortuneItemStyle(
        color: Colors.pink.shade600,
        borderWidth: 0,
      ),
      child: const Text(
        "₹20",
        style: TextStyle(
          fontFamily: 'MontserratBold',
          color: Color(0xFFFFFFFF),
          fontSize: 12,
        ),
      ),
    ),
    FortuneItem(
      style: FortuneItemStyle(
        color: Colors.blue.shade600,
        borderWidth: 0,
      ),
      child: const Text(
        "₹120",
        style: TextStyle(
          fontFamily: 'MontserratBold',
          color: Color(0xFFFFFFFF),
          fontSize: 12,
        ),
      ),
    ),
    FortuneItem(
      style: FortuneItemStyle(
        color: Colors.amber.shade600,
        borderWidth: 0,
      ),
      child: const Text(
        "₹500",
        style: TextStyle(
          fontFamily: 'MontserratBold',
          color: Color(0xFFFFFFFF),
          fontSize: 12,
        ),
      ),
    ),
    FortuneItem(
      style: FortuneItemStyle(
        color: Colors.deepOrange.shade600,
        borderWidth: 0,
      ),
      child: const Text(
        "₹1000",
        style: TextStyle(
          fontFamily: 'MontserratBold',
          color: Color(0xFFFFFFFF),
          fontSize: 12,
        ),
      ),
    ),
    FortuneItem(
      style: const FortuneItemStyle(
        color: Colors.white,
        borderWidth: 0,
      ),
      child: Text(
        "₹1500",
        style: TextStyle(
          fontFamily: 'MontserratBold',
          color: Colors.brown.shade700,
          fontSize: 12,
        ),
      ),
    ),
    FortuneItem(
      style: FortuneItemStyle(
        color: Colors.red.shade800,
        borderWidth: 0,
      ),
      child: const Text(
        "₹2000",
        style: TextStyle(
          fontFamily: 'MontserratBold',
          color: Colors.white,
          fontSize: 12,
        ),
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.5,
      decoration: const BoxDecoration(
        // borderRadius: BorderRadius.circular(16),
        // color: colors.primary_color,
        image: DecorationImage(
          image: AssetImage('assets/images/Group 18251 (1).png'),
        ),
      ),
      margin: EdgeInsets.symmetric(
          horizontal: size.width * 0.05, vertical: size.height * 0.1),
      padding: EdgeInsets.only(top: size.height * 0.2),
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.32,
            width: size.height * 0.32,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    height: size.height * 0.285,
                    width: size.height * 0.285,
                    child: Image.asset(
                      "assets/images/realistic-gold.png",
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: size.height * 0.285,
                    width: size.height * 0.285,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1000000),
                            ),
                            child: Image.asset(
                              "assets/images/Group 18250.png",
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: size.height * 0.23,
                            width: size.height * 0.23,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1000000),
                              border: Border.all(color: Colors.white,width: 2),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.white54,
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(5, 2),
                                ),
                                // Add more BoxShadow if needed
                              ],
                            ),
                            child: FortuneWheel(
                              selected: _controller.stream,
                              indicators: const <FortuneIndicator>[
                                FortuneIndicator(
                                  alignment: Alignment.topCenter,
                                  child: TriangleIndicator(
                                    color: Colors.green,
                                    width: 2.0,
                                    height: 2.0,
                                    elevation: 0,
                                  ),
                                ),
                              ],
                              styleStrategy: const UniformStyleStrategy(
                                color: Color(0xFFC6C8E9),
                                borderWidth: 0,
                              ),
                              items: items,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            "assets/images/realistic-gold.png",
                            height: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.topCenter,
                    child: Transform.rotate(
                      angle: pi / 2,
                      child: Image.asset(
                        "assets/images/pngtree-yellow.png",
                        height: 50,
                      ),
                    )
                ),
              ],
            ),
          ),
          const SizedBox(height: 20,),
          Material(
            color: const Color(0xFF171D82),
            child: InkWell(
              onTap: () {
                setState(() {
                  _controller.add(
                    Fortune.randomInt(0, items.length),
                  );
                });
              },
              child: Container(
                height: 50,
                width: size.width * 0.3,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFFE27E1C),
                          Color(0xFF851161),
                        ],),
                  borderRadius: BorderRadius.circular(1000),
                ),
                alignment: Alignment.center,
                child: const Text("Rotate",style: TextStyle(
                  fontFamily: 'MontserratLight',
                  color: Color(0xFFFFFFFF),
                  fontSize: 20,
                ),),
              ),
            ),
          )
        ],
      ),
    );
  }
}

