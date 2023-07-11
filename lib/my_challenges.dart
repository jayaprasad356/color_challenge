import 'package:color_challenge/muChallenges.dart';
import 'package:color_challenge/spinnerPage.dart';
import 'package:flutter/material.dart';

import 'Helper/Color.dart';
import 'myResults.dart';

class MyChallenges extends StatefulWidget {
  const MyChallenges({Key? key}) : super(key: key);


  @override
  State<MyChallenges> createState() => _MyChallengesState();
}

class _MyChallengesState extends State<MyChallenges> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 20, left: 20, top: 0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(

                children: <Widget>[
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[

                      Container(
                        width: 200.0,
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return spinnerPage(); // Replace NextPage with the actual page you want to navigate to
                                },
                              ),
                            );
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            height: 80,
                            width: double.infinity,
                            margin: const EdgeInsets.only(left: 10),
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/Verify.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Get Daily Bonus',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Montserrat"),
                              ),
                            ),
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
            child: MyChallenge(),
          ),
        ],
      ),
    );
  }


}
