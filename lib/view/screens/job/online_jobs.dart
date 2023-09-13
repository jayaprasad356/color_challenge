

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../util/Color.dart';
import '../../../util/Constant.dart';


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
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width, // Set width to the screen width
          height: MediaQuery.of(context).size.height, // Set height to the screen height
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [colors.primary_color, colors.secondary_color],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(height: 40),
                      GestureDetector(
                        onTap: () {
                          String text = 'Hi Sir/Madam, I want to Purchase Plan and am ready to join now';
                          String encodedText = Uri.encodeFull(text);
                          String uri = 'https://slveenterprises.org/slveenterprises.org/30115409/Online-Advertising-Course-30-Days';
                          launchUrl(
                            Uri.parse(uri),
                            mode: LaunchMode.externalApplication,
                          );
                        },
                        child: Image.network(
                          Constant.MainBaseUrl + "poster.jpg",// Replace this with the path to your image asset
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        "If Paid then Send Screen Shot to Help Support .",
                        style: GoogleFonts.poppins( // Use GoogleFonts.poppins() to access Poppins font
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),




                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

}