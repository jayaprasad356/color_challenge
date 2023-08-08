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
import 'Helper/utils.dart';
import 'contest_challenge.dart';
import 'findcolor.dart';
import 'myResults.dart';
import 'numchallenge.dart';
import 'online_jobs.dart';
import 'package:share_plus/share_plus.dart';

class JobShow extends StatefulWidget {
  const JobShow({Key? key}) : super(key: key);


  @override
  State<JobShow> createState() => JobShowState();
}

class JobShowState extends State<JobShow> {
  late SharedPreferences prefs;

  late String contact_us,
      image = "",referText = "";
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
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(height: 5),
                  Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              String text =
                                  'Hello, I want to POST Ads';
                              String encodedText = Uri.encodeFull(text);
                              String uri = 'https://wa.me/$contact_us?text=$encodedText';
                              launchUrl(
                                Uri.parse(uri),
                                mode: LaunchMode.externalApplication,
                              );
                            },
                            child: Container(
                              height: 50,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Post Your Ad',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              String uri = job_details;
                              launchUrl(
                                Uri.parse(uri),
                                mode: LaunchMode.externalApplication,
                              );
                            },
                            child: Container(
                              height: 50,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Job Details',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  Container(
                    margin: const EdgeInsets.only(right: 5, left: 5, top: 0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Refer  a friend and earn ₹150 ",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
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
                                const SizedBox(width: 12.0),
                                MaterialButton(
                                  onPressed: () {
                                    Share.share(referText + "\n Use my Refer Code and install this app https://play.google.com/store/apps/details?id=com.app.colorchallenge");
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
                  Image.network(
                    ads_image,
                    fit: BoxFit.contain,
                    height: 300, // Set the desired height
                    width: 400,  // Set the desired width
                  ),
                ],
              ),
            ),
          ),
          // Add your button below the existing content
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextButton(
              onPressed: () {
                String uri =
                    'https://chat.whatsapp.com/CAbUFlXWnbdJtCe0V9NZ3Z';
                launchUrl(
                  Uri.parse(uri),
                  mode: LaunchMode.externalApplication,
                );
              },
              child: Text(
                'Join Our WhatsApp Group',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                // You can customize other styles of the button here as well
              ),
            ),
          ),
        ],
      ),

    );
  }
}