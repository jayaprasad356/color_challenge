import 'package:a1_ads/util/Color.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Reward extends StatefulWidget {
  const Reward({super.key});

  @override
  State<Reward> createState() => _RewardState();
}

class _RewardState extends State<Reward> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
        gradient: LinearGradient(
        colors: [colors.primary_color, colors.secondary_color],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
    ),
    ),
    padding: const EdgeInsets.all(20),
    child: Container(
      height: size.height * 0.7,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      child: Column(
        children: [
          Image.asset('assets/images/cup 1.png',height: size.height * 0.1,),
          const SizedBox(height: 10,),
          Row(
            children: [
              Image.asset('assets/images/medal 2.png',height: 24,),
              const SizedBox(width: 10,),
              const Text(
                'Steps to Earn',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'MontserratBold',
                  color: Color(0xFF000000),
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20,),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "1.Click on the 'Get Rewards' button",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: 'MontserratLight',
                color: Color(0xFF000000),
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 20,),
          const Align(
            alignment: Alignment.topLeft,
             child: Text(
              "2.Download the app.",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: 'MontserratLight',
                color: Color(0xFF000000),
                fontSize: 16,
              ),
                       ),
           ),
          const SizedBox(height: 20,),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "3.Enter your mobile number and verify with OTP.",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: 'MontserratLight',
                color: Color(0xFF000000),
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 20,),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "4.After verification .. capture screenshot and send to A1 customer support",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: 'MontserratLight',
                color: Color(0xFF000000),
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 20,),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "5.Then you get Rs.10 rewards😊",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: 'MontserratLight',
                color: Color(0xFF000000),
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(height: size.width * 0.15,),
                    InkWell(
                      onTap: () {
                        String uri =
                        'https://klr.bz/9wOSh';
                        launchUrl(
                          Uri.parse(uri),
                          mode: LaunchMode.inAppWebView,
                        );
                      },
                      child: Container(
                        height: 50,
                        width: size.width * 0.35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: const Color(0xFF161C7E),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Get Rewards',
                          style: TextStyle(
                            fontFamily: 'MontserratLight',
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),),
        ],
      ),
    ),
      ),
    );
  }
}
