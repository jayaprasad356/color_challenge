import 'package:flutter/material.dart';

import 'Helper/Color.dart';
import 'myResults.dart';
import 'my_challenges.dart';

class Result extends StatefulWidget {
  const Result({Key? key}) : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Column(
          children: [
            Container(

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(

                  children: <Widget>[

                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Flexible(child: Container(
                          width: 200.0,
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return MyChallenges(); // Replace NextPage with the actual page you want to navigate to
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
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/Verify.png"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  'My Challenges',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Montserrat"),
                                ),
                              ),
                            ),
                          ),
                        ),)

                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: MyResults(),
            ),
          ],
        ),

    );
  }
}
