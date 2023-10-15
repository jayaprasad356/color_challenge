import 'dart:async';

import 'package:color_challenge/controller/utils.dart';
import 'package:color_challenge/model/jobs_show.dart';
import 'package:color_challenge/reports.dart';
import 'package:color_challenge/util/Color.dart';
import 'package:color_challenge/util/Constant.dart';
import 'package:color_challenge/view/screens/upi_screen/wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {


  late SharedPreferences prefs;
  String name = "";
  String mobile_number = "";
  String referText = "", refer_bonus = "";

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
      refer_bonus = prefs.getString(Constant.REFER_BONUS)!;
    });
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                                  Share.share(referText +
                                      "\n Use my Refer Code and install this app https://play.google.com/store/apps/details?id=com.app.colorchallenge");
                                },
                                color: colors.primary_color,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(8.0)),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 14.0, horizontal: 16.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        'Refer Friends',
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
                    SizedBox(
                      height: 55,
                      child: Column(
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
