import 'package:color_challenge/contestUsers.dart';
import 'package:color_challenge/generate_coins.dart';
import 'package:color_challenge/muChallenges.dart';
import 'package:color_challenge/result.dart';
import 'package:color_challenge/spinnerPage.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Helper/Color.dart';
import 'Helper/Constant.dart';
import 'contest_challenge.dart';
import 'findcolor.dart';
import 'myResults.dart';
import 'numchallenge.dart';

class OnlineJobs extends StatefulWidget {
  const OnlineJobs({Key? key}) : super(key: key);


  @override
  State<OnlineJobs> createState() => OnlineJobsState();
}

class OnlineJobsState extends State<OnlineJobs> {
  late SharedPreferences prefs;

  late String contact_us,
      image = "";

  @override
  void initState() {
    // TODO: implement initState
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      setState(() {
        contact_us = prefs.getString(Constant.CONTACT_US).toString();
        image = prefs.getString(Constant.IMAGE).toString();
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
                  SizedBox(height: 40),
                  Container(
                    child: Image.asset(
                      "assets/images/wfh2.jpeg",// Replace this with the path to your image asset
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Why Should You Pay For Online Jobs ?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '• Access to Exclusive Opportunities',
                        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13, color: colors.primary),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '• Quality Assurance and Customer Support',
                        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13, color: colors.primary),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '• Server and Database Charges',
                        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13, color: colors.primary),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '• Minimum Guaranteed Pay for Workers',
                        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13, color: colors.primary),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '• 24 * 7 Customer Support',
                        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13, color: colors.primary),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: MaterialButton(
                          onPressed: () {
                            String text =
                                'Hello I need to Join in work from home job';

                            // Encode the text for the URL
                            String encodedText = Uri.encodeFull(text);
                            String uri =
                                'https://admin.colorjobs.site/proof.pdf';
                            launchUrl(
                              Uri.parse(uri),
                              mode: LaunchMode.externalApplication,
                            );
                          },
                          color: colors.cc_green,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                            child: Text(
                              "Payment Proof",
                              style: TextStyle(
                                color: colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16), // Optional space between buttons
                      Expanded(
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return GenerateCoins(); // Replace FindColor with the actual page you want to navigate to
                                },
                              ),
                            );
                          },
                          color: colors.primary,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                            child: Text(
                              "View Job",
                              style: TextStyle(
                                color: colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )


              ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}