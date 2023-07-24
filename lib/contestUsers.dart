import 'dart:convert';
import 'package:color_challenge/challenge_data.dart';
import 'package:flutter/material.dart';

import 'Helper/Color.dart';
import 'Helper/Constant.dart';
import 'Helper/apiCall.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'contest_users_data.dart';

class ContestUsers extends StatefulWidget {
  const ContestUsers({Key? key}) : super(key: key);

  @override
  State<ContestUsers> createState() => _ContestUsersState();
}

class _ContestUsersState extends State<ContestUsers> {
  late List<ContestUsersData> datas = [];
  late SharedPreferences prefs;

  Future<List<ContestUsersData>> _getUser() async {
    prefs = await SharedPreferences.getInstance();

    var url = Constant.CONTEST_RANK_URL;
    Map<String, dynamic> bodyObject = {
      Constant.USER_ID: prefs.getString(Constant.ID)
      //Constant.USER_ID: "1"
    };
    String jsonString = await apiCall(url, bodyObject);
    final jsonsData = jsonDecode(jsonString);
    datas = [];

    for (var u in jsonsData['data']) {
      final rank = u['rank'];
      final name = u["name"];
      final time = u['time'];
      final prize = u['prize'];
      ContestUsersData data = ContestUsersData(rank, name, time,prize);
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
          return SizedBox(
            height: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: datas.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {},
                  child: Card(
                    color: colors.cc_list_grey,
                    margin:
                        const EdgeInsets.only(right: 5, left: 5, bottom: 5),
                    child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, // add this line

                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Equal spacing between texts
                              children: [
                                Expanded(
                                  child: Text(
                                    '#'+datas[index].rank + datas[index].name, // Replace with the desired text
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14, // Adjust the font size as needed
                                      fontWeight: FontWeight.normal, // Adjust the font weight as needed
                                      color: Colors.grey, // Adjust the text color as needed
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    datas[index].time, // Replace with the desired text
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14, // Adjust the font size as needed
                                      fontWeight: FontWeight.normal, // Adjust the font weight as needed
                                      color: Colors.blue, // Adjust the text color as needed
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '₹'+datas[index].prize, // Replace with the desired text
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 17, // Adjust the font size as needed
                                      fontWeight: FontWeight.bold, // Adjust the font weight as needed
                                      color: Colors.green, // Adjust the text color as needed
                                    ),
                                  ),
                                ),
                              ],
                            ),

                          ],
                        )
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
