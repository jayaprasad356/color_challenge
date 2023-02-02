import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.bg_white,
      body: Container(
          child: Column(children: <Widget>[
        Container(
          margin: const EdgeInsets.only(right: 10, left: 10, top: 60),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Refer  a friend and get 50 coins',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Montserrat"),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              side: BorderSide(color: Colors.red),
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
                                const Text(
                                  'GBD 21',
                                  style: TextStyle(
                                    color: Colors.primary,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )),
                      const SizedBox(width: 16.0),
                      MaterialButton(
                        onPressed: () {},
                        color: Colors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                'Button Text',
                                style: TextStyle(
                                  color: Colors.white,
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
        Container(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 75,
                    color: Colors.cc_green,
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          "assets/images/fly.png",
                          width: 24.0,
                          height: 24.0,
                        ),
                        SizedBox(height: 8.0),
                        Text('Join Green'),
                      ],
                    ),
                  ),
                  Container(
                    height: 75,
                    color: Colors.cc_skyblue,
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          "assets/images/fly.png",
                          width: 24.0,
                          height: 24.0,
                        ),
                        SizedBox(height: 8.0),
                        Text('Join Green'),
                      ],
                    ),
                  ),
                  Container(
                    height: 75,
                    color: Colors.cc_red,
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          "assets/images/fly.png",
                          width: 24.0,
                          height: 24.0,
                        ),
                        SizedBox(height: 8.0),
                        Text('Join Green'),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 75,
                    color: Colors.cc_pink,
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          "assets/images/fly.png",
                          width: 24.0,
                          height: 24.0,
                        ),
                        SizedBox(height: 8.0),
                        Text('Join Green'),
                      ],
                    ),
                  ),
                  Container(
                    height: 75,
                    color: Colors.cc_yellow,
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          "assets/images/fly.png",
                          width: 24.0,
                          height: 24.0,
                        ),
                        SizedBox(height: 8.0),
                        Text('Join Green'),
                      ],
                    ),
                  ),
                  Container(
                    height: 75,
                    color: Colors.cc_purpul,
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          "assets/images/fly.png",
                          width: 24.0,
                          height: 24.0,
                        ),
                        SizedBox(height: 8.0),
                        Text('Join Green'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ])),
    );
  }
}
