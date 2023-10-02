import 'dart:async';

import 'package:color_challenge/model/jobs_show.dart';
import 'package:color_challenge/reports.dart';
import 'package:color_challenge/util/Color.dart';
import 'package:color_challenge/util/Constant.dart';
import 'package:color_challenge/view/screens/upi_screen/wallet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      setState(() {
        name = prefs.getString(Constant.NAME)!;
        mobile_number = prefs.getString(Constant.MOBILE)!;
      });
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
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
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
              const SizedBox(
                height: 15,
              ),
              const Divider(color: Colors.white70, thickness: 1.5),
              const SizedBox(
                height: 15,
              ),
              InkWell(
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
              const SizedBox(
                height: 15,
              ),
              InkWell(
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
