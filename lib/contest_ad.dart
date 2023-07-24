import 'package:color_challenge/contestUsers.dart';
import 'package:color_challenge/muChallenges.dart';
import 'package:color_challenge/spinnerPage.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Helper/Color.dart';
import 'Helper/Constant.dart';
import 'contest_challenge.dart';
import 'myResults.dart';
import 'numchallenge.dart';

class ContestAd extends StatefulWidget {
  const ContestAd({Key? key}) : super(key: key);


  @override
  State<ContestAd> createState() => ContestAdState();
}

class ContestAdState extends State<ContestAd> {
  late SharedPreferences prefs;

  late String contact_us,image = "";

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
            // Optionally, you can set height and width for the container
            // height: 200,
            // width: 200,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Flexible(child: Container(
                        width: 150.0,
                        child: MaterialButton(
                          onPressed: () {
                            String text =
                                'Hello I need Help in Contest';

                            // Encode the text for the URL
                            String encodedText = Uri.encodeFull(text);
                            String uri =
                                'https://wa.me/$contact_us?text=$encodedText';
                            launchUrl(
                              Uri.parse(uri),
                              mode: LaunchMode.externalApplication,
                            );
                          },
                          color: colors.cc_green,
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
                                  'Get Help',
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
                      ),),
                      Flexible(child: Container(
                        width: 150.0,
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ContestChallenge(); // Replace NextPage with the actual page you want to navigate to
                                },
                              ),
                            );;
                          },
                          color: colors.gold_dark,
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
                                  'Join Contest',
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
                      ),)

                    ],
                  ),
                  SizedBox(height: 5),



                  Image.network(
                    image,
                    // Replace with the URL of your image
                    fit: BoxFit.contain, // Adjust the fit as needed
                  ),
                  SizedBox(height: 10), // Add some space between the image and the text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Equal spacing between texts
                    children: [
                      Expanded(
                        child: Text(
                          'Name', // Replace with the desired text
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16, // Adjust the font size as needed
                            fontWeight: FontWeight.bold, // Adjust the font weight as needed
                            color: Colors.black, // Adjust the text color as needed
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Time(sec)', // Replace with the desired text
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16, // Adjust the font size as needed
                            fontWeight: FontWeight.bold, // Adjust the font weight as needed
                            color: Colors.black, // Adjust the text color as needed
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Prize', // Replace with the desired text
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16, // Adjust the font size as needed
                            fontWeight: FontWeight.bold, // Adjust the font weight as needed
                            color: Colors.black, // Adjust the text color as needed
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),


          Expanded(

            child: ContestUsers(),
          ),
        ],
      ),
    );
  }

}
