import 'package:color_challenge/Helper/utils.dart';
import 'package:color_challenge/contestUsers.dart';
import 'package:color_challenge/muChallenges.dart';
import 'package:color_challenge/offline_jobs.dart';
import 'package:color_challenge/result.dart';
import 'package:color_challenge/spinnerPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Helper/Color.dart';
import 'Helper/Constant.dart';
import 'contest_challenge.dart';
import 'findcolor.dart';
import 'myResults.dart';
import 'numchallenge.dart';
import 'online_jobs.dart';

class Refer extends StatefulWidget {
  const Refer({Key? key}) : super(key: key);


  @override
  State<Refer> createState() => ReferState();
}

class ReferState extends State<Refer> {
  late SharedPreferences prefs;
  String referText = "";

  late String contact_us,
      image = "";
  String ads_image = Constant.MainBaseUrl + 'level.jpeg';
  String job_details = Constant.MainBaseUrl + 'job.pdf';

  @override
  void initState() {
    // TODO: implement initState
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      setState(() {
        contact_us = prefs.getString(Constant.CONTACT_US).toString();
        image = prefs.getString(Constant.IMAGE).toString();
        referText = prefs.getString(Constant.REFER_CODE)!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 20, left: 20, top: 0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Refer  a friend and earn get ₹150 ",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.red,
                          fontWeight: FontWeight.normal,
                          fontFamily: "Montserrat"),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        OutlinedButton(
                          onPressed: () {
                            Utils().showToast("Copied !");
                            Clipboard.setData(ClipboardData(text: referText));
                          },
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              side: const BorderSide(color: colors.red),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(14),
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
                                  style: TextStyle(
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
                        const SizedBox(width: 16.0),
                        MaterialButton(
                          onPressed: () {
                            Share.share(referText + " Use my Refer Code and install this app https://play.google.com/store/apps/details?id=com.app.colorchallenge");
                          },
                          color: colors.primary,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(8.0)),
                          ),
                          child: Padding(
                            padding:
                            const EdgeInsets.only(top: 16.0, bottom: 16.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const <Widget>[
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
        ],
      ),

    );
  }
}