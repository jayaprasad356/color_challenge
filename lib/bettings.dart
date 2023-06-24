import 'dart:convert';
import 'package:color_challenge/challenge_data.dart';
import 'package:flutter/material.dart';

import 'Helper/Color.dart';
import 'Helper/Constant.dart';
import 'Helper/apiCall.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/dummy_challenges.dart';

class Bettings extends StatefulWidget {
  const Bettings({Key? key}) : super(key: key);

  @override
  State<Bettings> createState() => _BettingsState();
}

class _BettingsState extends State<Bettings> {
  late List<DummyChallenges> datas = [];
  late SharedPreferences prefs;

  Future<List<DummyChallenges>> _getUser() async {
    prefs = await SharedPreferences.getInstance();

    var url = Constant.DUMMY_CHALLENGES;
    // Map<String, dynamic> bodyObject = {
    //   Constant.USER_ID: prefs.getString(Constant.ID)
    //   //Constant.USER_ID: "1"
    // };
    var response = await dataCall(url);
    String jsonDataString = response.toString();
    final jsonData = jsonDecode(jsonDataString);
    datas.clear();

    for (var u in jsonData['data']) {
      final coins = u['coins'];
      final name = u["name"];
      final code = u['code'];
      DummyChallenges data = DummyChallenges(coins, name, code);
      datas.add(data);
    }
    return datas;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getUser(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (datas.isEmpty) {
          return Center(
              child: Column(
                children: const [
                  // CircularProgressIndicator(color: colors.primary),
                ],
              ));
        } else {
          return SingleChildScrollView(
            child: SizedBox(
              height: 400,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: datas.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Card(
                      color: colors.cc_list_grey,
                      margin:
                      const EdgeInsets.only(right: 15, left: 15, bottom: 5),
                      child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start, // add this line

                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Image.asset(
                                    "assets/images/coin.png",
                                    width: 20.0,
                                    height: 20.0,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    datas[index].coins,
                                    style: const TextStyle(
                                        fontFamily: "Montserra",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: colors.primary),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    datas[index].name,
                                    style: const TextStyle(
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: colors.primary),
                                  ),

                                  Expanded(child: Container()),
                                  // Text(
                                  //   datas[index].name,
                                  //   style: const TextStyle(fontFamily: "Montserrat"),
                                  // ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(5),
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: Color(int.parse(
                                          datas[index].code.replaceAll('#', '0xFF'))),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                    ),
                                  ),
                                ],
                              ),
                              // Row(
                              //   children: [
                              //     Padding(
                              //
                              //       padding: const EdgeInsets.only(left: 8.0,bottom: 4.0),
                              //       child: Text(
                              //         datas[index].datetime,
                              //         style: const TextStyle(
                              //             fontFamily: "Montserrat",
                              //             fontWeight: FontWeight.bold,
                              //             fontSize: 16,
                              //             color: colors.black),
                              //       ),
                              //     ),
                              //
                              //     Expanded(child: Container()),
                              //     Padding(
                              //       padding: const EdgeInsets.only(right: 5.0),
                              //       child: Text(
                              //         datas[index].status == "0"
                              //             ? "Wait For Result"
                              //             : datas[index].status == "1"
                              //             ? "Won"
                              //             : datas[index].status == "2"
                              //             ? "Loss"
                              //             : "", // handle other cases if necessary
                              //         style: TextStyle(
                              //           fontFamily: "Montserra",
                              //           color: datas[index].status == "0"
                              //               ? colors.primary
                              //               : datas[index].status == "1"
                              //               ? colors.cc_green
                              //               : datas[index].status == "2"
                              //               ? colors.red
                              //               : Colors.black, // default color if necessary
                              //         ),
                              //       ),
                              //     ),
                              //
                              //
                              //   ],
                              // ),

                            ],
                          )
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }
}
