
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../util/Color.dart';
import '../util/Constant.dart';
import '../controller/utils.dart';
import '../view/screens/job/online_jobs.dart';
import 'package:share_plus/share_plus.dart';

class JobShow extends StatefulWidget {
  const JobShow({Key? key}) : super(key: key);


  @override
  State<JobShow> createState() => JobShowState();
}

class JobShowState extends State<JobShow> {
  late SharedPreferences prefs;

  late String contact_us,
      image = "",referText = "",offer_image = "",refer_bonus = "";
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
        offer_image = prefs.getString(Constant.OFFER_IMAGE).toString();
        referText = prefs.getString(Constant.REFER_CODE)!;
        refer_bonus = prefs.getString(Constant.REFER_BONUS)!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colors.primary_color,
                colors.primary_color2
              ], // Change these colors to your desired gradient colors
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        title: const Text(
          "Info",
          style: TextStyle(fontFamily: 'MontserratBold', color: colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: colors.white,
          ),
        ),
      ),
      body: Container(
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
                    SizedBox(height: 5),
                    Container(
                      color: colors.cc_velvet,
                      margin: const EdgeInsets.only(right: 5, left: 5, top: 0),
                      child: Card(
                        child: Container(
                          color: colors.cc_velvet,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Refer friend and earn ₹$refer_bonus (only for premium user)",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
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
                                          backgroundColor: Colors.white,
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
                                        color: colors.primary_color,
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
                      ),
                    ),
                    SizedBox(height: 10),
                    Image.network(
                      offer_image,
                      fit: BoxFit.contain,
                      height: 300, // Set the desired height
                      width: 400,  // Set the desired width
                    ),
                    SizedBox(height: 10),
                    MaterialButton(
                      onPressed: () async {
                        launchUrl(
                          Uri.parse(job_details),
                          mode: LaunchMode.externalApplication,
                        );


                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        height: 60,
                        width: 140,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/btnbg.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Job Details',
                            style: TextStyle(
                                color: colors.white,
                                fontSize: 14,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.bold),
                          ),
                        ),
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
      ),

    );
  }
}