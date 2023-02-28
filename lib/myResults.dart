import 'dart:convert';
import 'package:color_challenge/challenge_data.dart';
import 'package:color_challenge/result_data.dart';
import 'package:flutter/material.dart';

import 'Helper/Color.dart';
import 'Helper/Constant.dart';
import 'Helper/apiCall.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyResults extends StatefulWidget {
  const MyResults({Key? key}) : super(key: key);

  @override
  State<MyResults> createState() => _MyResultsState();
}

class _MyResultsState extends State<MyResults> {
  late List<ResultData> datas = [];
  late SharedPreferences prefs;
  Future<List<ResultData>> _getMyResults() async {
    datas.clear();
    prefs = await SharedPreferences.getInstance();

    var response = await dataCall(Constant.MY_RESULTS_URL);

    String jsonsDataString = response.toString();
    final jsonsData = jsonDecode(jsonsDataString);
    datas.clear();
    for (var u in jsonsData['data']) {
      final name = u['name'];
      final code = u["code"];
      final date = u['date'];

      ResultData data = ResultData(name, code, date);
      datas.add(data);
    }
    return datas;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getMyResults(),
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
                    color: colors.white,
                    margin: const EdgeInsets.only(right: 15, left: 15, bottom: 10,top: 10),
                    child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  width: 45,
                                  height: 40,
                                  decoration:  BoxDecoration(
                                    color: Color(int.parse(datas[index].code.replaceAll('#', '0xFF'))),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                  ),
                                ),
                                 Text(
                                  datas[index].name,
                                  style: TextStyle(
                                      fontFamily: "Montserra",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: colors.black),
                                ),
                                Expanded(child: Container()),
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Row(
                              children: [
                                const Text(
                                  "2023-03-10",
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: colors.black),
                                ),
                                 Text(
                                  datas[index].date,
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: colors.black),
                                ),
                                Expanded(child: Container()),
                              ],
                            )),
                      ],
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
