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

class OfflineJobs extends StatefulWidget {
  const OfflineJobs({Key? key}) : super(key: key);


  @override
  State<OfflineJobs> createState() => OfflineJobsState();
}

class OfflineJobsState extends State<OfflineJobs> {
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
                      "assets/images/offline_job.jpeg",// Replace this with the path to your image asset
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: MaterialButton(
                          onPressed: () {
                            String text =
                                'Hello I want to Apply for offline jobs.';

                            // Encode the text for the URL
                            String encodedText = Uri.encodeFull(text);
                            String uri =
                                'https://wa.me/$contact_us?text=$encodedText';
                            launchUrl(
                              Uri.parse(uri),
                              mode: LaunchMode.externalApplication,
                            );
                          },
                          color: colors.primary,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                            child: Text(
                              "Apply Job",
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