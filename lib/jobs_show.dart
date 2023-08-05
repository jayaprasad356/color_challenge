import 'package:color_challenge/contestUsers.dart';
import 'package:color_challenge/muChallenges.dart';
import 'package:color_challenge/offline_jobs.dart';
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
import 'online_jobs.dart';

class JobShow extends StatefulWidget {
  const JobShow({Key? key}) : super(key: key);


  @override
  State<JobShow> createState() => JobShowState();
}

class JobShowState extends State<JobShow> {
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
                  SizedBox(height: 5),
                  GestureDetector(
                    onTap: () {
                      // Your onTap logic here
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return OnlineJobs();
                                  },
                                ),
                              );
                            },
                            child: Container(
                              height: 150,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Online Jobs',
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return OfflineJobs();
                                  },
                                ),
                              );
                            },
                            child: Container(
                              height: 150,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Offline Jobs',
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